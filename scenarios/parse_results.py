from utils import *
import json

headers=[
    "Scenario ID",
    "Client trust store",
    "Client presented certificates",
    "Server trust store",
    "Server presented certificates",
    "Status"
]

OPTIMAL_SCENARIO = "SC-R-LIn-R-LIn"

servers_key = "servers"
status_key = "Status"
success_value = "Success"

with open(os.path.normpath(f"{parent_dir}/results/latest.json"), 'r') as results:
    with open(os.path.normpath(f"{script_dir}/OUTCOMES.md"), 'w', encoding='utf-8', newline='') as scenarios:
        scenarios.write('# Viable TLS configurations\n\n')
        decoded = json.load(results)

        scenarios.write('This report was generated from the data output by the following command\n')
        scenarios.write('```sh\n')
        scenarios.write(decoded["commandline"] + '\n')
        scenarios.write('```\n\n')

        for server in decoded[servers_key]:
            scenarios.write(f'## {server}\n\n')

            if (decoded[servers_key][server][OPTIMAL_SCENARIO][status_key] == success_value):
                scenarios.write(f'{server} supports the optimal configuration of only roots in trust stores, with leaf and intermediates in certificate files\n\n')
            else:
                scenarios.write(f'{server} does not support the optimal configuration of only roots in trust stores, with leaf and intermediates in certificate files\n\n')
            
            scenarios.write('|' + '|'.join(headers) + '|\n')
            scenarios.write('|' + '|'.join(['---'] * len(headers)) + '|\n')

            for scenario_id in decoded[servers_key][server]:
                status = decoded[servers_key][server][scenario_id][status_key]
                if status != success_value:
                    continue

                parsed_scenario = scenario_id.split('-')

                client_trust_store = TrustStoreLookup[parsed_scenario[1]]
                client_presented_certificates = PresentedCertificatesLookup[parsed_scenario[2]]
                server_trust_store = TrustStoreLookup[parsed_scenario[3]]
                server_presented_certificates = PresentedCertificatesLookup[parsed_scenario[4]]

                scenarios.write(f'|{scenario_id}|{client_trust_store}|{client_presented_certificates}|{server_trust_store}|{server_presented_certificates}|{status}|\n')