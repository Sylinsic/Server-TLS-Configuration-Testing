from utils import *

permutations = list(product(*rows))
headers=[
    "Scenario ID",
    "Client trust store",
    "Client presented certificates",
    "Server trust store",
    "Server presented certificates"
]

with open(os.path.normpath(f"{script_dir}/SCENARIOS.md"), 'w', encoding='utf-8', newline='') as scenarios:
    scenarios.write('# TLS Testing Scenarios\n\n')
    scenarios.write('This document contains all the permutations of trust store and presented certificate configurations for TLS testing.\n\n')

    scenarios.write('|' + '|'.join(headers) + '|\n')
    scenarios.write('|' + '|'.join(['---'] * len(headers)) + '|\n')

    for permutation in permutations:
        client_trust_store = TrustStoreLookup[permutation[0]]
        client_presented_certificates = PresentedCertificatesLookup[permutation[1]]
        server_trust_store = TrustStoreLookup[permutation[2]]
        server_presented_certificates = PresentedCertificatesLookup[permutation[3]]

        scenario_id = f'SC-{permutation[0]}-{permutation[1]}-{permutation[2]}-{permutation[3]}'

        scenarios.write(f'|{scenario_id}|{client_trust_store}|{client_presented_certificates}|{server_trust_store}|{server_presented_certificates}|\n')

        with open(os.path.normpath(f'{script_dir}/{scenario_id}.env'), 'w', encoding='utf-8') as env_file:
            env_file.writelines([
                f'BASE_DIR={os.path.normpath(parent_dir)}\n',
                f'CLIENT_CA={get_trust_store_path(permutation[0])}\n',
                f'CLIENT_CERT={get_presented_certificates_path(ClientName, permutation[1])}\n',
                f'CLIENT_KEY={os.path.normpath(parent_dir + "certs/Client/cert.key")}\n',
                f'CLIENT_ROOT={os.path.normpath(parent_dir + "/certs/RootCA/cert.crt")}\n',
                f'SERVER_CA={get_trust_store_path(permutation[2])}\n',
                f'SERVER_CERT={get_presented_certificates_path(ServerName, permutation[3])}\n',
                f'SERVER_KEY={os.path.normpath(parent_dir + "/certs/Server/cert.key")}\n',
                f'SERVER_ROOT={os.path.normpath(parent_dir + "/certs/RootCA/cert.crt")}\n'
            ])

print(f'Created {len(permutations)} scenarios')