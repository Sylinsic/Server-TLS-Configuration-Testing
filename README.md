# TLS Testing

## Pre-requisites

- docker
- docker-compose
- python 3.11 or above
- openssl

## How-To

1. Generate the test certificates (requires OpenSSL)
   ```sh
   python3 certs/generate.py
   ```

2. Generate the possible scenario configuration files
   ```sh
   python3 scenarios/generate_scenarios.py
   ```

3. Run the test suite
   ```sh
   python3 ./test.py
   ```

   You can specify specific scenarios using `--scenarios`
   You can specify specific servers using `--servers`
   You can capture failure output using `--capture-output`

4. Parse the test results
   ```sh
   python3 scenarios/parse_results.py
   ```

## Output

- `scenarios/SCENARIOS.md` contains a list of all scenarios that will be tested
- `results/latest.json` contains the full test outcomes in machine-readable format.
- `scenarios/OUTCOMES.md` contains a table of the tested functional configurations for each server. It also indicates whether the server supports the optimal configuration of only trusting roots, whilst presenting leaf and intermediates.