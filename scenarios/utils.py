from itertools import product
from enum import StrEnum

class TrustStoreConfiguration(StrEnum):
    R = "R"
    RIn = "RIn"
    In = "In"
    Is = "Is"
    IIs = "IIs"

class PresentedCertificatesConfiguration(StrEnum):
    F = "F"
    LIn = "LIn"
    LIs = "LIs"
    L = "L"

TrustStoreRow = [
    TrustStoreConfiguration.R,
    TrustStoreConfiguration.RIn,
    TrustStoreConfiguration.In,
    TrustStoreConfiguration.Is,
    TrustStoreConfiguration.IIs
]

PresentedCertificatesRow = [
    PresentedCertificatesConfiguration.F,
    PresentedCertificatesConfiguration.LIn,
    PresentedCertificatesConfiguration.LIs,
    PresentedCertificatesConfiguration.L
]

TrustStoreLookup = {
    TrustStoreConfiguration.R: "Root CA",
    TrustStoreConfiguration.RIn: "Root CA + Intermediate CAs",
    TrustStoreConfiguration.In: "Intermediate CAs",
    TrustStoreConfiguration.Is: "Issuing CA",
    TrustStoreConfiguration.IIs: "Incorrect Issuing CA"
}

PresentedCertificatesLookup = {
    PresentedCertificatesConfiguration.F: "Full Chain",
    PresentedCertificatesConfiguration.LIn: "Leaf + Intermediate CAs",
    PresentedCertificatesConfiguration.LIs: "Leaf + Issuing CA",
    PresentedCertificatesConfiguration.L: "Leaf Only"
}

rows = [
    TrustStoreRow,
    PresentedCertificatesRow,
    TrustStoreRow,
    PresentedCertificatesRow
]; 

def get_individual_cert_path(cert: str) -> str:
    return f"certs/{cert}/cert.crt"

def get_chain_path(chain: str) -> str:
    return f"certs/Chains/{chain}.crt"

def get_specific_chain_path(type: str,chain: str) -> str:
    return f"certs/{type}/Chains/{chain}.crt"

RootCAName = "RootCA"
Tier2CA1Name = "Tier2CA1"
Tier3CA1Name = "Tier3CA1"
Tier3CA2Name = "Tier3CA2"
ServerName = "Server"
ClientName = "Client"

FullChainName = "full"
IntermediatesChainName = "intermediates"
IssuerChainName = "issuer"

def get_trust_store_path(trust_store_configuration: TrustStoreConfiguration) -> str:
    if trust_store_configuration == TrustStoreConfiguration.R:
        return get_individual_cert_path(RootCAName)
    elif trust_store_configuration == TrustStoreConfiguration.RIn:
        return get_chain_path(FullChainName)
    elif trust_store_configuration == TrustStoreConfiguration.In:
        return get_chain_path(IntermediatesChainName)
    elif trust_store_configuration == TrustStoreConfiguration.Is:
        return get_individual_cert_path(Tier3CA1Name)
    elif trust_store_configuration == TrustStoreConfiguration.IIs:
        return get_individual_cert_path(Tier3CA2Name)

def get_presented_certificates_path(type: str, presentedCertificatesConfiguration: PresentedCertificatesConfiguration) -> str:
    if presentedCertificatesConfiguration == PresentedCertificatesConfiguration.F:
        return get_specific_chain_path(type, FullChainName)
    elif presentedCertificatesConfiguration == PresentedCertificatesConfiguration.LIn:
        return get_specific_chain_path(type, IntermediatesChainName)
    elif presentedCertificatesConfiguration == PresentedCertificatesConfiguration.LIs:
        return get_specific_chain_path(type, IssuerChainName)
    elif presentedCertificatesConfiguration == PresentedCertificatesConfiguration.L:
        return get_individual_cert_path(type)
