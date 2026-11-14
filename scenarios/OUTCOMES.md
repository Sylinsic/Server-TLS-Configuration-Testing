# Viable TLS configurations

## nginx

nginx supports the optimal configuration of only roots in trust stores, with leaf and intermediates in certificate files

|Scenario ID|Client trust store|Client presented certificates|Server trust store|Server presented certificates|Status|
|---|---|---|---|---|---|
|SC-RIn-F-R-LIs|Root CA + Intermediate CAs|Full Chain|Root CA|Leaf + Issuing CA|Success|
|SC-R-F-RIn-LIn|Root CA|Full Chain|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Success|
|SC-RIn-LIn-R-F|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA|Full Chain|Success|
|SC-RIn-L-RIn-LIs|Root CA + Intermediate CAs|Leaf Only|Root CA + Intermediate CAs|Leaf + Issuing CA|Success|
|SC-R-LIs-RIn-LIn|Root CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Success|
|SC-RIn-L-RIn-LIn|Root CA + Intermediate CAs|Leaf Only|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Success|
|SC-RIn-LIs-RIn-LIs|Root CA + Intermediate CAs|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Issuing CA|Success|
|SC-In-LIn-R-F|Intermediate CAs|Leaf + Intermediate CAs|Root CA|Full Chain|Success|
|SC-Is-LIn-RIn-L|Issuing CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf Only|Success|
|SC-Is-LIs-RIn-F|Issuing CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Full Chain|Success|
|SC-Is-F-R-F|Issuing CA|Full Chain|Root CA|Full Chain|Success|
|SC-In-LIn-R-LIs|Intermediate CAs|Leaf + Intermediate CAs|Root CA|Leaf + Issuing CA|Success|
|SC-RIn-L-RIn-F|Root CA + Intermediate CAs|Leaf Only|Root CA + Intermediate CAs|Full Chain|Success|
|SC-Is-F-RIn-LIs|Issuing CA|Full Chain|Root CA + Intermediate CAs|Leaf + Issuing CA|Success|
|SC-R-L-RIn-F|Root CA|Leaf Only|Root CA + Intermediate CAs|Full Chain|Success|
|SC-Is-L-RIn-LIs|Issuing CA|Leaf Only|Root CA + Intermediate CAs|Leaf + Issuing CA|Success|
|SC-Is-LIn-RIn-F|Issuing CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Full Chain|Success|
|SC-RIn-F-RIn-F|Root CA + Intermediate CAs|Full Chain|Root CA + Intermediate CAs|Full Chain|Success|
|SC-R-LIs-RIn-F|Root CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Full Chain|Success|
|SC-Is-LIn-R-LIn|Issuing CA|Leaf + Intermediate CAs|Root CA|Leaf + Intermediate CAs|Success|
|SC-Is-LIs-RIn-L|Issuing CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf Only|Success|
|SC-RIn-LIn-R-LIn|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA|Leaf + Intermediate CAs|Success|
|SC-R-LIn-R-F|Root CA|Leaf + Intermediate CAs|Root CA|Full Chain|Success|
|SC-R-L-RIn-LIn|Root CA|Leaf Only|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Success|
|SC-RIn-F-R-L|Root CA + Intermediate CAs|Full Chain|Root CA|Leaf Only|Success|
|SC-R-LIn-RIn-LIn|Root CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Success|
|SC-RIn-LIn-RIn-L|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf Only|Success|
|SC-Is-L-RIn-F|Issuing CA|Leaf Only|Root CA + Intermediate CAs|Full Chain|Success|
|SC-Is-LIs-RIn-LIs|Issuing CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Issuing CA|Success|
|SC-Is-L-RIn-L|Issuing CA|Leaf Only|Root CA + Intermediate CAs|Leaf Only|Success|
|SC-Is-LIn-RIn-LIn|Issuing CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Success|
|SC-Is-F-R-LIs|Issuing CA|Full Chain|Root CA|Leaf + Issuing CA|Success|
|SC-Is-LIn-R-L|Issuing CA|Leaf + Intermediate CAs|Root CA|Leaf Only|Success|
|SC-Is-LIn-R-LIs|Issuing CA|Leaf + Intermediate CAs|Root CA|Leaf + Issuing CA|Success|
|SC-R-F-RIn-F|Root CA|Full Chain|Root CA + Intermediate CAs|Full Chain|Success|
|SC-RIn-F-RIn-L|Root CA + Intermediate CAs|Full Chain|Root CA + Intermediate CAs|Leaf Only|Success|
|SC-In-LIn-RIn-LIn|Intermediate CAs|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Success|
|SC-RIn-F-RIn-LIn|Root CA + Intermediate CAs|Full Chain|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Success|
|SC-RIn-LIn-RIn-LIn|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Success|
|SC-R-F-R-F|Root CA|Full Chain|Root CA|Full Chain|Success|
|SC-Is-LIn-R-F|Issuing CA|Leaf + Intermediate CAs|Root CA|Full Chain|Success|
|SC-R-F-R-LIn|Root CA|Full Chain|Root CA|Leaf + Intermediate CAs|Success|
|SC-Is-F-RIn-F|Issuing CA|Full Chain|Root CA + Intermediate CAs|Full Chain|Success|
|SC-RIn-F-RIn-LIs|Root CA + Intermediate CAs|Full Chain|Root CA + Intermediate CAs|Leaf + Issuing CA|Success|
|SC-RIn-LIs-RIn-F|Root CA + Intermediate CAs|Leaf + Issuing CA|Root CA + Intermediate CAs|Full Chain|Success|
|SC-Is-F-R-LIn|Issuing CA|Full Chain|Root CA|Leaf + Intermediate CAs|Success|
|SC-Is-F-RIn-LIn|Issuing CA|Full Chain|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Success|
|SC-Is-F-R-L|Issuing CA|Full Chain|Root CA|Leaf Only|Success|
|SC-Is-L-RIn-LIn|Issuing CA|Leaf Only|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Success|
|SC-RIn-LIn-R-L|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA|Leaf Only|Success|
|SC-RIn-F-R-F|Root CA + Intermediate CAs|Full Chain|Root CA|Full Chain|Success|
|SC-Is-F-RIn-L|Issuing CA|Full Chain|Root CA + Intermediate CAs|Leaf Only|Success|
|SC-RIn-LIn-R-LIs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA|Leaf + Issuing CA|Success|
|SC-RIn-LIn-RIn-F|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Full Chain|Success|
|SC-RIn-LIs-RIn-LIn|Root CA + Intermediate CAs|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Success|
|SC-Is-LIn-RIn-LIs|Issuing CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Issuing CA|Success|
|SC-R-LIn-R-LIn|Root CA|Leaf + Intermediate CAs|Root CA|Leaf + Intermediate CAs|Success|
|SC-RIn-F-R-LIn|Root CA + Intermediate CAs|Full Chain|Root CA|Leaf + Intermediate CAs|Success|
|SC-Is-LIs-RIn-LIn|Issuing CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Success|
|SC-RIn-LIs-RIn-L|Root CA + Intermediate CAs|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf Only|Success|
|SC-RIn-L-RIn-L|Root CA + Intermediate CAs|Leaf Only|Root CA + Intermediate CAs|Leaf Only|Success|
|SC-RIn-LIn-RIn-LIs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Issuing CA|Success|
|SC-R-LIn-RIn-F|Root CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Full Chain|Success|
|SC-In-LIs-RIn-LIs|Intermediate CAs|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Issuing CA|Success|
