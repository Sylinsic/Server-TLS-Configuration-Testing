#!/usr/bin/env python3
"""Generate a four-tier test PKI and its certificate chains."""

import argparse
from pathlib import Path
import shutil
import subprocess
import sys


ROOT_DAYS = 3650
INTERMEDIATE_DAYS = 1825
END_ENTITY_DAYS = 365
PKCS12_PASSWORD = "password"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Generate the TLS testing certificate hierarchy."
    )
    parser.add_argument(
        "--output-directory",
        type=Path,
        default=Path(__file__).resolve().parent,
        help="Directory for generated certificates (default: script directory)",
    )
    parser.add_argument(
        "--dns-name",
        default="server",
        help="DNS name for the server certificate (default: server)",
    )
    parser.add_argument(
        "--openssl",
        help="OpenSSL executable (default: find openssl on PATH)",
    )
    parser.add_argument(
        "--keytool",
        help="keytool executable (default: find keytool on PATH)",
    )
    return parser.parse_args()

def print_indented(to_print, indent = 1):
    if (to_print != None and to_print != ""):
        print("\t"*indent + to_print.replace("\n", "\n" + "\t"*indent))

def run_openssl(openssl: str, *arguments: str) -> None:
    p = subprocess.run([openssl, *arguments], check=True, capture_output=True, text=True)
    p.check_returncode()
    print_indented(p.stdout)
    print_indented(p.stderr)


def create_java_truststore(
    keytool: str,
    output_path: Path,
    certificates: tuple[tuple[str, Path], ...],
) -> None:
    for alias, certificate in certificates:
        subprocess.run(
            [
                keytool,
                "-delete",
                "-alias",
                alias,
                "-keystore",
                str(output_path),
                "-storetype",
                "PKCS12",
                "-storepass",
                PKCS12_PASSWORD,
            ]
        )
        p = subprocess.run(
            [
                keytool,
                "-importcert",
                "-noprompt",
                "-alias",
                alias,
                "-file",
                str(certificate),
                "-keystore",
                str(output_path),
                "-storetype",
                "PKCS12",
                "-storepass",
                PKCS12_PASSWORD,
            ],
            capture_output=True,
            text=True,
        )
        print_indented(p.stdout)
        print_indented(p.stderr)

def write_config(path: Path, contents: str) -> None:
    path.write_text(contents, encoding="ascii")


def create_ca(
    openssl: str,
    directory: Path,
    issuer_certificate: Path | None,
    issuer_key: Path | None,
    common_name: str,
    validity_days: int,
    path_length: int,
) -> None:
    key_path = directory / "cert.key"
    csr_path = directory / "cert.csr"
    certificate_path = directory / "cert.crt"
    config_path = directory / "cert.cnf"

    if issuer_certificate is None:
        write_config(
            config_path,
            """[req]
distinguished_name = dn
prompt = no
x509_extensions = v3_ca

[dn]
CN = Lab Root CA
O = Example PKI

[v3_ca]
basicConstraints = critical,CA:TRUE,pathlen:2
keyUsage = critical,keyCertSign,cRLSign
subjectKeyIdentifier = hash
""",
        )
        run_openssl(
            openssl,
            "req",
            "-x509",
            "-newkey",
            "rsa:4096",
            "-nodes",
            "-keyout",
            str(key_path),
            "-out",
            str(certificate_path),
            "-days",
            str(validity_days),
            "-sha256",
            "-config",
            str(config_path),
            "-extensions",
            "v3_ca",
        )
        return

    if issuer_key is None:
        raise ValueError("An issuer key is required for an intermediate CA.")

    run_openssl(
        openssl,
        "genpkey",
        "-algorithm",
        "RSA",
        "-pkeyopt",
        "rsa_keygen_bits:3072",
        "-out",
        str(key_path),
    )
    run_openssl(
        openssl,
        "req",
        "-new",
        "-key",
        str(key_path),
        "-out",
        str(csr_path),
        "-subj",
        f"/CN={common_name}/O=Example PKI",
    )
    write_config(
        config_path,
        f"""[v3_intermediate_ca]
basicConstraints = critical,CA:TRUE,pathlen:{path_length}
keyUsage = critical,keyCertSign,cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
""",
    )
    run_openssl(
        openssl,
        "x509",
        "-req",
        "-in",
        str(csr_path),
        "-CA",
        str(issuer_certificate),
        "-CAkey",
        str(issuer_key),
        "-CAcreateserial",
        "-out",
        str(certificate_path),
        "-days",
        str(validity_days),
        "-sha256",
        "-extfile",
        str(config_path),
        "-extensions",
        "v3_intermediate_ca",
    )


def create_end_entity(
    openssl: str,
    directory: Path,
    issuer_certificate: Path,
    issuer_key: Path,
    common_name: str,
    validity_days: int,
    extension: str,
    dns_name: str | None = None,
) -> None:
    key_path = directory / "cert.key"
    csr_path = directory / "cert.csr"
    certificate_path = directory / "cert.crt"
    config_path = directory / "cert.cnf"
    run_openssl(
        openssl,
        "genpkey",
        "-algorithm",
        "RSA",
        "-pkeyopt",
        "rsa_keygen_bits:2048",
        "-out",
        str(key_path),
    )
    run_openssl(
        openssl,
        "req",
        "-new",
        "-key",
        str(key_path),
        "-out",
        str(csr_path),
        "-subj",
        f"/CN={common_name}/O=Example PKI",
    )
    san = f"subjectAltName = DNS:{dns_name}\n" if dns_name else ""
    write_config(
        config_path,
        f"""[v3_end_entity]
basicConstraints = critical,CA:FALSE
keyUsage = critical,digitalSignature,keyEncipherment
extendedKeyUsage = {extension}
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
{san}""",
    )
    run_openssl(
        openssl,
        "x509",
        "-req",
        "-in",
        str(csr_path),
        "-CA",
        str(issuer_certificate),
        "-CAkey",
        str(issuer_key),
        "-CAcreateserial",
        "-out",
        str(certificate_path),
        "-days",
        str(validity_days),
        "-sha256",
        "-extfile",
        str(config_path),
        "-extensions",
        "v3_end_entity",
    )


def write_chain(path: Path, *certificates: Path) -> None:
    path.write_bytes(b"".join(certificate.read_bytes() for certificate in certificates))


def create_pkcs12_files(
    openssl: str,
    certificate: Path,
    key: Path,
    output_directory: Path,
    chain_directory: Path,
    alias: str,
) -> None:
    for chain_name in ("full", "intermediates", "issuer", "leaf"):
        arguments = [
            "pkcs12",
            "-export",
            "-in",
            str(certificate),
            "-inkey",
            str(key),
        ]
        if chain_name != "leaf":
            arguments.extend(
                ["-certfile", str(chain_directory / f"{chain_name}.crt")]
            )
        arguments.extend(
            [
                "-out",
                str(output_directory / f"{chain_name}.p12"),
                "-password",
                f"pass:{PKCS12_PASSWORD}",
                "-name",
                alias,
            ]
        )
        run_openssl(openssl, *arguments)


def main() -> int:
    args = parse_args()
    openssl = args.openssl or shutil.which("openssl")
    if openssl is None:
        print(
            "OpenSSL not found. Install OpenSSL and add it to PATH, "
            "or specify it with --openssl.",
            file=sys.stderr,
        )
        return 1
    keytool = args.keytool or shutil.which("keytool")
    if keytool is None:
        print(
            "keytool not found. Install a JDK and add keytool to PATH, "
            "or specify it with --keytool.",
            file=sys.stderr,
        )
        return 1

    output = args.output_directory
    root = output / "RootCA"
    tier2 = output / "Tier2CA1"
    tier3a = output / "Tier3CA1"
    tier3b = output / "Tier3CA2"
    server = output / "Server"
    client = output / "Client"
    chains = output / "Chains"

    for directory in (
        root,
        tier2,
        tier3a,
        tier3b,
        server,
        server / "Chains",
        client,
        client / "Chains",
        chains,
    ):
        directory.mkdir(parents=True, exist_ok=True)

    print("\n=== FOUR TIER PKI CREATION ===")
    print("\n[1/6] Generating Root CA...")
    create_ca(openssl, root, None, None, "Lab Root CA", ROOT_DAYS, 2)
    print("Root CA created.")

    print("\n[2/6] Generating Tier 2 Intermediate CA 1...")
    create_ca(
        openssl,
        tier2,
        root / "cert.crt",
        root / "cert.key",
        "Lab Tier 1 Intermediate CA 1",
        INTERMEDIATE_DAYS,
        1,
    )
    print("Tier 2 Intermediate CA 1 created.")

    print("\n[3/6] Generating Tier 3 Intermediate CA 1...")
    create_ca(
        openssl,
        tier3a,
        tier2 / "cert.crt",
        tier2 / "cert.key",
        "Lab Tier 3 Intermediate CA 1",
        INTERMEDIATE_DAYS,
        0,
    )
    print("Tier 3 Intermediate CA 1 created.")

    print("\n[4/6] Generating Tier 3 Intermediate CA 2...")
    create_ca(
        openssl,
        tier3b,
        tier2 / "cert.crt",
        tier2 / "cert.key",
        "Lab Tier 3 Intermediate CA 2",
        INTERMEDIATE_DAYS,
        0,
    )
    print("Tier 3 Intermediate CA 2 created.")

    print("\n[5/6] Generating Server Certificate...")
    create_end_entity(
        openssl,
        server,
        tier3a / "cert.crt",
        tier3a / "cert.key",
        args.dns_name,
        END_ENTITY_DAYS,
        "serverAuth",
        args.dns_name,
    )
    print("Server Certificate created.")

    print("\n[6/6] Generating Client Certificate...")
    create_end_entity(
        openssl,
        client,
        tier3a / "cert.crt",
        tier3a / "cert.key",
        "My Client",
        END_ENTITY_DAYS,
        "clientAuth",
    )
    print("Client Certificate created.")

    print("\nCreating certificate chain...")
    root_certificate = root / "cert.crt"
    tier2_certificate = tier2 / "cert.crt"
    tier3a_certificate = tier3a / "cert.crt"
    tier3b_certificate = tier3b / "cert.crt"
    server_certificate = server / "cert.crt"
    client_certificate = client / "cert.crt"

    for directory, leaf_certificate in (
        (server / "Chains", server_certificate),
        (client / "Chains", client_certificate),
    ):
        write_chain(
            directory / "full.crt",
            leaf_certificate,
            tier3a_certificate,
            tier2_certificate,
            root_certificate,
        )
        write_chain(
            directory / "intermediates.crt",
            leaf_certificate,
            tier3a_certificate,
            tier2_certificate,
        )
        write_chain(directory / "issuer.crt", leaf_certificate, tier3a_certificate)

    write_chain(chains / "full.crt", tier3a_certificate, tier2_certificate, root_certificate)
    write_chain(chains / "intermediates.crt", tier3a_certificate, tier2_certificate)
    write_chain(chains / "issuer.crt", tier3a_certificate)

    print("\nCreating Java PKCS#12 truststores...")
    for name, certificates in (
        (
            "full",
            (
                ("tier3ca1", tier3a_certificate),
                ("tier3ca2", tier3b_certificate),
                ("tier2ca1", tier2_certificate),
                ("rootca", root_certificate),
            )
        ),
        (
            "intermediates",
            (
                ("tier3ca1", tier3a_certificate), 
                ("tier2ca1", tier2_certificate),
            )
        ),
        (
            "issuer", 
            (
                ("tier3ca1", tier3a_certificate),
            )
        )
    ):
        create_java_truststore(keytool, f"{chains}/{name}.p12", certificates)

    print("\nCreating PKCS#12 files...")
    create_pkcs12_files(
        openssl,
        server_certificate,
        server / "cert.key",
        server / "Chains",
        chains,
        "tomcat",
    )
    create_pkcs12_files(
        openssl,
        client_certificate,
        client / "cert.key",
        client / "Chains",
        chains,
        "client",
    )

    print("\nVerifying certificate chain...")
    run_openssl(
        openssl,
        "verify",
        "-CAfile",
        str(root_certificate),
        "-untrusted",
        str(chains / "intermediates.crt"),
        str(server_certificate),
    )

    print("\n=== PKI SUCCESSFULLY CREATED ===")
    for label, certificate, include_dates in (
        ("Root CA", root_certificate, True),
        ("Intermediate CA 1", tier2_certificate, False),
        ("Intermediate CA 2", tier3a_certificate, False),
        ("Server", server_certificate, True),
        ("Client", client_certificate, True),
    ):
        print(f"\n{label}:")
        arguments = ["x509", "-in", certificate, "-noout", "-subject", "-issuer"]
        if include_dates:
            arguments.append("-dates")
        run_openssl(openssl, *arguments)

    print(f"\nOutput directory: {output}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as error:
        print(
            f"Command failed with exit code {error.returncode}: "
            f"{subprocess.list2cmdline(error.cmd)}",
            file=sys.stderr,
        )
        raise SystemExit(error.returncode or 1) from error
