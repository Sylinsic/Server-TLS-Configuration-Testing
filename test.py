#!/usr/bin/env python3
import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime
import hashlib
import json
import shlex
import subprocess
import sys
from pathlib import Path
from typing import Any


SCRIPT_DIR = Path(__file__).resolve().parent
SCENARIOS_DIR = SCRIPT_DIR / "scenarios"
SERVERS_DIR = SCRIPT_DIR / "servers"
RESULTS_DIR = SCRIPT_DIR / "results"
LATEST_RESULTS = RESULTS_DIR / "latest.json"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Run TLS configuration scenarios.")
    parser.add_argument(
        "--force-check-all",
        action="store_true",
        help="Run all selected scenarios, ignoring cached results",
    )
    parser.add_argument(
        "--capture-output",
        action="store_true",
        help="Include failed Docker Compose output in the results",
    )
    parser.add_argument(
        "--parallel-scenarios",
        type=int,
        default=8,
        metavar="N",
        help="Maximum scenarios to run concurrently (default: 8)",
    )
    parser.add_argument(
        "--scenarios",
        action="append",
        default=[],
        metavar="LIST",
        help="Comma-separated scenario names (repeatable)",
    )
    parser.add_argument(
        "--servers",
        action="append",
        default=[],
        metavar="LIST",
        help="Comma-separated server names (repeatable)",
    )
    args = parser.parse_args()
    if args.parallel_scenarios < 1:
        parser.error("--parallel-scenarios must be a positive integer")
        
    args.scenario_filters = {
        name.casefold()
        for value in args.scenarios
        for name in value.split(",")
        if name
    }
    args.server_filters = {
        name.casefold()
        for value in args.servers
        for name in value.split(",")
        if name
    }
    return args


def sha256_file(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()


def get_server_hash(server_path: Path) -> str:
    file_hashes = "".join(
        sha256_file(path) for path in sorted(server_path.rglob("*")) if path.is_file()
    )
    return hashlib.sha256(file_hashes.encode("utf-8")).hexdigest().upper()


def load_previous_results() -> dict[str, Any]:
    if not LATEST_RESULTS.is_file():
        return {}
    try:
        with LATEST_RESULTS.open(encoding="utf-8-sig") as source:
            previous = json.load(source)
    except (OSError, UnicodeError, json.JSONDecodeError) as error:
        print(
            f"Unable to read cached results from {LATEST_RESULTS}: {error}. "
            "All selected scenarios will run.",
            file=sys.stderr,
        )
        return {}
    return previous if isinstance(previous, dict) else {}


def get_cached_result(
    previous: dict[str, Any],
    server: str,
    scenario: str,
    server_hash: str,
    scenario_hash: str,
) -> dict[str, Any] | None:
    hashes = previous.get("hashes")
    if not isinstance(hashes, dict):
        return None
    server_hashes = hashes.get("servers")
    scenario_hashes = hashes.get("scenarios")
    previous_servers = previous.get("servers")
    if not all(
        isinstance(value, dict)
        for value in (server_hashes, scenario_hashes, previous_servers)
    ):
        return None
    if (
        server_hashes.get(server) != server_hash
        or scenario_hashes.get(scenario) != scenario_hash
    ):
        return None
    server_results = previous_servers.get(server)
    if not isinstance(server_results, dict):
        return None
    result = server_results.get(scenario)
    return result if isinstance(result, dict) else None

def test_docker() -> bool:
        try:
            completed = subprocess.run(
                ["docker", "info"],
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                encoding="utf-8",
                errors="replace",
                check=False,
            )

            if completed.returncode == 0:
                print("Docker online. Continuing...")
                return True
            else:
                print("Docker is unavailable. Aborting...")
                return False
        except Exception as error:
            print(
                    f"Warning: unable to check if docker is available: {error}",
                    file=sys.stderr,
                )
            return False

def run_scenario(server: str, scenario: str, capture_output: bool) -> dict[str, Any]:
    project = f"{server.lower()}-{scenario.lower()}"
    compose_args = [
        "docker-compose",
        "--ansi",
        "never",
        "--project-directory",
        ".",
        "-f",
        "servers/docker-compose.yml",
        "-f",
        f"servers/{server}/docker-compose.yml",
        "--env-file",
        f"scenarios/{scenario}.env",
        "-p",
        project,
    ]
    print(f"Running scenario '{scenario}' with server '{server}'...")
    try:
        completed = subprocess.run(
            [*compose_args, "up", "--exit-code-from", "client"],
            cwd=SCRIPT_DIR,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            encoding="utf-8",
            errors="replace",
            check=False,
        )
    except OSError as error:
        raise RuntimeError(f"Unable to run Docker Compose: {error}") from error
    finally:
        try:
            cleanup = subprocess.run(
                [
                    "docker-compose",
                    "-p",
                    project,
                    "down",
                    "--volumes",
                    "--remove-orphans",
                ],
                cwd=SCRIPT_DIR,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                check=False,
            )
            if cleanup.returncode != 0:
                print(
                    f"Warning: Docker Compose cleanup failed for '{project}' "
                    f"(exit code {cleanup.returncode}).",
                    file=sys.stderr,
                )
        except OSError as error:
            print(
                f"Warning: unable to clean up Docker Compose project "
                f"'{project}': {error}",
                file=sys.stderr,
            )

    result: dict[str, Any] = {
        "Status": "Success" if completed.returncode == 0 else "Failed"
    }
    if result["Status"] == "Failed" and capture_output:
        result["Result"] = completed.stdout.splitlines()
    return result


def write_results(results: dict[str, Any]) -> None:
    RESULTS_DIR.mkdir(parents=True, exist_ok=True)
    encoded = json.dumps(results, indent=2) + "\n"
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    (RESULTS_DIR / f"{timestamp}.json").write_text(encoded, encoding="utf-8")
    LATEST_RESULTS.write_text(encoded, encoding="utf-8")


def main() -> int:
    args = parse_args()

    docker_available = test_docker()
    if not docker_available:
        return 1

    all_scenarios = sorted(path.stem for path in SCENARIOS_DIR.glob("*.env"))
    all_servers = sorted(path.name for path in SERVERS_DIR.iterdir() if path.is_dir())

    if not all_scenarios:
        print(f"Unable to load scenarios from {SCENARIOS_DIR}", file=sys.stderr)
        return 1
    if not all_servers:
        print(f"Unable to load servers from {SERVERS_DIR}", file=sys.stderr)
        return 1

    scenarios = [
        name
        for name in all_scenarios
        if not args.scenario_filters or name.casefold() in args.scenario_filters
    ]
    if not scenarios:
        print("No scenarios within the selection criteria", file=sys.stderr)
        return 1
    servers = [
        name
        for name in all_servers
        if not args.server_filters or name.casefold() in args.server_filters
    ]
    if not servers:
        print("No servers within the selection criteria", file=sys.stderr)
        return 1

    scenario_hashes = {
        scenario: sha256_file(SCENARIOS_DIR / f"{scenario}.env")
        for scenario in scenarios
    }
    server_hashes = {
        server: get_server_hash(SERVERS_DIR / server) for server in servers
    }
    commandline = shlex.join([Path(sys.argv[0]).as_posix(), *sys.argv[1:]])
    results: dict[str, Any] = {
        "commandline": commandline,
        "servers": {server: {} for server in servers},
        "scenarios": [
            {"Name": scenario, "Hash": scenario_hashes[scenario]}
            for scenario in scenarios
        ],
        "hashes": {
            "servers": server_hashes,
            "scenarios": scenario_hashes,
        },
    }
    previous = {} if args.force_check_all else load_previous_results()
    pending: dict[Any, tuple[str, str]] = {}

    with ThreadPoolExecutor(max_workers=args.parallel_scenarios) as executor:
        for server in servers:
            for scenario in scenarios:
                cached_result = get_cached_result(
                    previous,
                    server,
                    scenario,
                    server_hashes[server],
                    scenario_hashes[scenario],
                )
                if cached_result is not None:
                    print(
                        f"Skipping scenario '{scenario}' for server '{server}' "
                        "(no changes detected). Copying results from previous run."
                    )
                    results["servers"][server][scenario] = cached_result
                    continue
                future = executor.submit(
                    run_scenario, server, scenario, args.capture_output
                )
                pending[future] = (server, scenario)

        for future in as_completed(pending):
            server, scenario = pending[future]
            try:
                results["servers"][server][scenario] = future.result()
            except RuntimeError as error:
                print(
                    f"Failed to run scenario '{scenario}' with server '{server}': "
                    f"{error}",
                    file=sys.stderr,
                )
                return 1

    write_results(results)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
