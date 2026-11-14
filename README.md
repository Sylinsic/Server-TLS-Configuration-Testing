# TLS Testing

## Pre-requisites

- docker
- python 3.11 or above

## How-To

1. Generate the possible scenario configuration files
   ```sh
   cd scenarios
   python3 generate_scenarios.py
   ```

2. Run the test suite
   ```pwsh
   ./test.ps1
   ```

3. Parse the test results
   ```sh
   cd scenarios
   python3 parse_results.py
   ```

## Output

- `results/latest.json` contains the full test outcomes in machine-readable format.
- `scenarios/SCENARIOS.md` contains a list of all scenarios that will be tested
- `scenarios/OUTCOMES.md` contains a table of the functional configurations for each server. It also indicates whether the server supports the optimal configuration of only trusting roots, whilst presenting leaf and intermediates.