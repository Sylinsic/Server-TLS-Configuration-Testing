# TLS Testing Scenarios

This document contains all the permutations of trust store and presented certificate configurations for TLS testing.

|Scenario ID|Client trust store|Client presented certificates|Server trust store|Server presented certificates|
|---|---|---|---|---|
|SC-R-F-R-F|Root CA|Full Chain|Root CA|Full Chain|
|SC-R-F-R-LIn|Root CA|Full Chain|Root CA|Leaf + Intermediate CAs|
|SC-R-F-R-LIs|Root CA|Full Chain|Root CA|Leaf + Issuing CA|
|SC-R-F-R-L|Root CA|Full Chain|Root CA|Leaf Only|
|SC-R-F-RIn-F|Root CA|Full Chain|Root CA + Intermediate CAs|Full Chain|
|SC-R-F-RIn-LIn|Root CA|Full Chain|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-R-F-RIn-LIs|Root CA|Full Chain|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-R-F-RIn-L|Root CA|Full Chain|Root CA + Intermediate CAs|Leaf Only|
|SC-R-F-In-F|Root CA|Full Chain|Intermediate CAs|Full Chain|
|SC-R-F-In-LIn|Root CA|Full Chain|Intermediate CAs|Leaf + Intermediate CAs|
|SC-R-F-In-LIs|Root CA|Full Chain|Intermediate CAs|Leaf + Issuing CA|
|SC-R-F-In-L|Root CA|Full Chain|Intermediate CAs|Leaf Only|
|SC-R-F-Is-F|Root CA|Full Chain|Issuing CA|Full Chain|
|SC-R-F-Is-LIn|Root CA|Full Chain|Issuing CA|Leaf + Intermediate CAs|
|SC-R-F-Is-LIs|Root CA|Full Chain|Issuing CA|Leaf + Issuing CA|
|SC-R-F-Is-L|Root CA|Full Chain|Issuing CA|Leaf Only|
|SC-R-F-IIs-F|Root CA|Full Chain|Incorrect Issuing CA|Full Chain|
|SC-R-F-IIs-LIn|Root CA|Full Chain|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-R-F-IIs-LIs|Root CA|Full Chain|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-R-F-IIs-L|Root CA|Full Chain|Incorrect Issuing CA|Leaf Only|
|SC-R-LIn-R-F|Root CA|Leaf + Intermediate CAs|Root CA|Full Chain|
|SC-R-LIn-R-LIn|Root CA|Leaf + Intermediate CAs|Root CA|Leaf + Intermediate CAs|
|SC-R-LIn-R-LIs|Root CA|Leaf + Intermediate CAs|Root CA|Leaf + Issuing CA|
|SC-R-LIn-R-L|Root CA|Leaf + Intermediate CAs|Root CA|Leaf Only|
|SC-R-LIn-RIn-F|Root CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Full Chain|
|SC-R-LIn-RIn-LIn|Root CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-R-LIn-RIn-LIs|Root CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-R-LIn-RIn-L|Root CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf Only|
|SC-R-LIn-In-F|Root CA|Leaf + Intermediate CAs|Intermediate CAs|Full Chain|
|SC-R-LIn-In-LIn|Root CA|Leaf + Intermediate CAs|Intermediate CAs|Leaf + Intermediate CAs|
|SC-R-LIn-In-LIs|Root CA|Leaf + Intermediate CAs|Intermediate CAs|Leaf + Issuing CA|
|SC-R-LIn-In-L|Root CA|Leaf + Intermediate CAs|Intermediate CAs|Leaf Only|
|SC-R-LIn-Is-F|Root CA|Leaf + Intermediate CAs|Issuing CA|Full Chain|
|SC-R-LIn-Is-LIn|Root CA|Leaf + Intermediate CAs|Issuing CA|Leaf + Intermediate CAs|
|SC-R-LIn-Is-LIs|Root CA|Leaf + Intermediate CAs|Issuing CA|Leaf + Issuing CA|
|SC-R-LIn-Is-L|Root CA|Leaf + Intermediate CAs|Issuing CA|Leaf Only|
|SC-R-LIn-IIs-F|Root CA|Leaf + Intermediate CAs|Incorrect Issuing CA|Full Chain|
|SC-R-LIn-IIs-LIn|Root CA|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-R-LIn-IIs-LIs|Root CA|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-R-LIn-IIs-L|Root CA|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf Only|
|SC-R-LIs-R-F|Root CA|Leaf + Issuing CA|Root CA|Full Chain|
|SC-R-LIs-R-LIn|Root CA|Leaf + Issuing CA|Root CA|Leaf + Intermediate CAs|
|SC-R-LIs-R-LIs|Root CA|Leaf + Issuing CA|Root CA|Leaf + Issuing CA|
|SC-R-LIs-R-L|Root CA|Leaf + Issuing CA|Root CA|Leaf Only|
|SC-R-LIs-RIn-F|Root CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Full Chain|
|SC-R-LIs-RIn-LIn|Root CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-R-LIs-RIn-LIs|Root CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-R-LIs-RIn-L|Root CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf Only|
|SC-R-LIs-In-F|Root CA|Leaf + Issuing CA|Intermediate CAs|Full Chain|
|SC-R-LIs-In-LIn|Root CA|Leaf + Issuing CA|Intermediate CAs|Leaf + Intermediate CAs|
|SC-R-LIs-In-LIs|Root CA|Leaf + Issuing CA|Intermediate CAs|Leaf + Issuing CA|
|SC-R-LIs-In-L|Root CA|Leaf + Issuing CA|Intermediate CAs|Leaf Only|
|SC-R-LIs-Is-F|Root CA|Leaf + Issuing CA|Issuing CA|Full Chain|
|SC-R-LIs-Is-LIn|Root CA|Leaf + Issuing CA|Issuing CA|Leaf + Intermediate CAs|
|SC-R-LIs-Is-LIs|Root CA|Leaf + Issuing CA|Issuing CA|Leaf + Issuing CA|
|SC-R-LIs-Is-L|Root CA|Leaf + Issuing CA|Issuing CA|Leaf Only|
|SC-R-LIs-IIs-F|Root CA|Leaf + Issuing CA|Incorrect Issuing CA|Full Chain|
|SC-R-LIs-IIs-LIn|Root CA|Leaf + Issuing CA|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-R-LIs-IIs-LIs|Root CA|Leaf + Issuing CA|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-R-LIs-IIs-L|Root CA|Leaf + Issuing CA|Incorrect Issuing CA|Leaf Only|
|SC-R-L-R-F|Root CA|Leaf Only|Root CA|Full Chain|
|SC-R-L-R-LIn|Root CA|Leaf Only|Root CA|Leaf + Intermediate CAs|
|SC-R-L-R-LIs|Root CA|Leaf Only|Root CA|Leaf + Issuing CA|
|SC-R-L-R-L|Root CA|Leaf Only|Root CA|Leaf Only|
|SC-R-L-RIn-F|Root CA|Leaf Only|Root CA + Intermediate CAs|Full Chain|
|SC-R-L-RIn-LIn|Root CA|Leaf Only|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-R-L-RIn-LIs|Root CA|Leaf Only|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-R-L-RIn-L|Root CA|Leaf Only|Root CA + Intermediate CAs|Leaf Only|
|SC-R-L-In-F|Root CA|Leaf Only|Intermediate CAs|Full Chain|
|SC-R-L-In-LIn|Root CA|Leaf Only|Intermediate CAs|Leaf + Intermediate CAs|
|SC-R-L-In-LIs|Root CA|Leaf Only|Intermediate CAs|Leaf + Issuing CA|
|SC-R-L-In-L|Root CA|Leaf Only|Intermediate CAs|Leaf Only|
|SC-R-L-Is-F|Root CA|Leaf Only|Issuing CA|Full Chain|
|SC-R-L-Is-LIn|Root CA|Leaf Only|Issuing CA|Leaf + Intermediate CAs|
|SC-R-L-Is-LIs|Root CA|Leaf Only|Issuing CA|Leaf + Issuing CA|
|SC-R-L-Is-L|Root CA|Leaf Only|Issuing CA|Leaf Only|
|SC-R-L-IIs-F|Root CA|Leaf Only|Incorrect Issuing CA|Full Chain|
|SC-R-L-IIs-LIn|Root CA|Leaf Only|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-R-L-IIs-LIs|Root CA|Leaf Only|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-R-L-IIs-L|Root CA|Leaf Only|Incorrect Issuing CA|Leaf Only|
|SC-RIn-F-R-F|Root CA + Intermediate CAs|Full Chain|Root CA|Full Chain|
|SC-RIn-F-R-LIn|Root CA + Intermediate CAs|Full Chain|Root CA|Leaf + Intermediate CAs|
|SC-RIn-F-R-LIs|Root CA + Intermediate CAs|Full Chain|Root CA|Leaf + Issuing CA|
|SC-RIn-F-R-L|Root CA + Intermediate CAs|Full Chain|Root CA|Leaf Only|
|SC-RIn-F-RIn-F|Root CA + Intermediate CAs|Full Chain|Root CA + Intermediate CAs|Full Chain|
|SC-RIn-F-RIn-LIn|Root CA + Intermediate CAs|Full Chain|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-RIn-F-RIn-LIs|Root CA + Intermediate CAs|Full Chain|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-RIn-F-RIn-L|Root CA + Intermediate CAs|Full Chain|Root CA + Intermediate CAs|Leaf Only|
|SC-RIn-F-In-F|Root CA + Intermediate CAs|Full Chain|Intermediate CAs|Full Chain|
|SC-RIn-F-In-LIn|Root CA + Intermediate CAs|Full Chain|Intermediate CAs|Leaf + Intermediate CAs|
|SC-RIn-F-In-LIs|Root CA + Intermediate CAs|Full Chain|Intermediate CAs|Leaf + Issuing CA|
|SC-RIn-F-In-L|Root CA + Intermediate CAs|Full Chain|Intermediate CAs|Leaf Only|
|SC-RIn-F-Is-F|Root CA + Intermediate CAs|Full Chain|Issuing CA|Full Chain|
|SC-RIn-F-Is-LIn|Root CA + Intermediate CAs|Full Chain|Issuing CA|Leaf + Intermediate CAs|
|SC-RIn-F-Is-LIs|Root CA + Intermediate CAs|Full Chain|Issuing CA|Leaf + Issuing CA|
|SC-RIn-F-Is-L|Root CA + Intermediate CAs|Full Chain|Issuing CA|Leaf Only|
|SC-RIn-F-IIs-F|Root CA + Intermediate CAs|Full Chain|Incorrect Issuing CA|Full Chain|
|SC-RIn-F-IIs-LIn|Root CA + Intermediate CAs|Full Chain|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-RIn-F-IIs-LIs|Root CA + Intermediate CAs|Full Chain|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-RIn-F-IIs-L|Root CA + Intermediate CAs|Full Chain|Incorrect Issuing CA|Leaf Only|
|SC-RIn-LIn-R-F|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA|Full Chain|
|SC-RIn-LIn-R-LIn|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA|Leaf + Intermediate CAs|
|SC-RIn-LIn-R-LIs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA|Leaf + Issuing CA|
|SC-RIn-LIn-R-L|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA|Leaf Only|
|SC-RIn-LIn-RIn-F|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Full Chain|
|SC-RIn-LIn-RIn-LIn|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-RIn-LIn-RIn-LIs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-RIn-LIn-RIn-L|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf Only|
|SC-RIn-LIn-In-F|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Intermediate CAs|Full Chain|
|SC-RIn-LIn-In-LIn|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Intermediate CAs|Leaf + Intermediate CAs|
|SC-RIn-LIn-In-LIs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Intermediate CAs|Leaf + Issuing CA|
|SC-RIn-LIn-In-L|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Intermediate CAs|Leaf Only|
|SC-RIn-LIn-Is-F|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Issuing CA|Full Chain|
|SC-RIn-LIn-Is-LIn|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Issuing CA|Leaf + Intermediate CAs|
|SC-RIn-LIn-Is-LIs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Issuing CA|Leaf + Issuing CA|
|SC-RIn-LIn-Is-L|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Issuing CA|Leaf Only|
|SC-RIn-LIn-IIs-F|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Incorrect Issuing CA|Full Chain|
|SC-RIn-LIn-IIs-LIn|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-RIn-LIn-IIs-LIs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-RIn-LIn-IIs-L|Root CA + Intermediate CAs|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf Only|
|SC-RIn-LIs-R-F|Root CA + Intermediate CAs|Leaf + Issuing CA|Root CA|Full Chain|
|SC-RIn-LIs-R-LIn|Root CA + Intermediate CAs|Leaf + Issuing CA|Root CA|Leaf + Intermediate CAs|
|SC-RIn-LIs-R-LIs|Root CA + Intermediate CAs|Leaf + Issuing CA|Root CA|Leaf + Issuing CA|
|SC-RIn-LIs-R-L|Root CA + Intermediate CAs|Leaf + Issuing CA|Root CA|Leaf Only|
|SC-RIn-LIs-RIn-F|Root CA + Intermediate CAs|Leaf + Issuing CA|Root CA + Intermediate CAs|Full Chain|
|SC-RIn-LIs-RIn-LIn|Root CA + Intermediate CAs|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-RIn-LIs-RIn-LIs|Root CA + Intermediate CAs|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-RIn-LIs-RIn-L|Root CA + Intermediate CAs|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf Only|
|SC-RIn-LIs-In-F|Root CA + Intermediate CAs|Leaf + Issuing CA|Intermediate CAs|Full Chain|
|SC-RIn-LIs-In-LIn|Root CA + Intermediate CAs|Leaf + Issuing CA|Intermediate CAs|Leaf + Intermediate CAs|
|SC-RIn-LIs-In-LIs|Root CA + Intermediate CAs|Leaf + Issuing CA|Intermediate CAs|Leaf + Issuing CA|
|SC-RIn-LIs-In-L|Root CA + Intermediate CAs|Leaf + Issuing CA|Intermediate CAs|Leaf Only|
|SC-RIn-LIs-Is-F|Root CA + Intermediate CAs|Leaf + Issuing CA|Issuing CA|Full Chain|
|SC-RIn-LIs-Is-LIn|Root CA + Intermediate CAs|Leaf + Issuing CA|Issuing CA|Leaf + Intermediate CAs|
|SC-RIn-LIs-Is-LIs|Root CA + Intermediate CAs|Leaf + Issuing CA|Issuing CA|Leaf + Issuing CA|
|SC-RIn-LIs-Is-L|Root CA + Intermediate CAs|Leaf + Issuing CA|Issuing CA|Leaf Only|
|SC-RIn-LIs-IIs-F|Root CA + Intermediate CAs|Leaf + Issuing CA|Incorrect Issuing CA|Full Chain|
|SC-RIn-LIs-IIs-LIn|Root CA + Intermediate CAs|Leaf + Issuing CA|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-RIn-LIs-IIs-LIs|Root CA + Intermediate CAs|Leaf + Issuing CA|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-RIn-LIs-IIs-L|Root CA + Intermediate CAs|Leaf + Issuing CA|Incorrect Issuing CA|Leaf Only|
|SC-RIn-L-R-F|Root CA + Intermediate CAs|Leaf Only|Root CA|Full Chain|
|SC-RIn-L-R-LIn|Root CA + Intermediate CAs|Leaf Only|Root CA|Leaf + Intermediate CAs|
|SC-RIn-L-R-LIs|Root CA + Intermediate CAs|Leaf Only|Root CA|Leaf + Issuing CA|
|SC-RIn-L-R-L|Root CA + Intermediate CAs|Leaf Only|Root CA|Leaf Only|
|SC-RIn-L-RIn-F|Root CA + Intermediate CAs|Leaf Only|Root CA + Intermediate CAs|Full Chain|
|SC-RIn-L-RIn-LIn|Root CA + Intermediate CAs|Leaf Only|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-RIn-L-RIn-LIs|Root CA + Intermediate CAs|Leaf Only|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-RIn-L-RIn-L|Root CA + Intermediate CAs|Leaf Only|Root CA + Intermediate CAs|Leaf Only|
|SC-RIn-L-In-F|Root CA + Intermediate CAs|Leaf Only|Intermediate CAs|Full Chain|
|SC-RIn-L-In-LIn|Root CA + Intermediate CAs|Leaf Only|Intermediate CAs|Leaf + Intermediate CAs|
|SC-RIn-L-In-LIs|Root CA + Intermediate CAs|Leaf Only|Intermediate CAs|Leaf + Issuing CA|
|SC-RIn-L-In-L|Root CA + Intermediate CAs|Leaf Only|Intermediate CAs|Leaf Only|
|SC-RIn-L-Is-F|Root CA + Intermediate CAs|Leaf Only|Issuing CA|Full Chain|
|SC-RIn-L-Is-LIn|Root CA + Intermediate CAs|Leaf Only|Issuing CA|Leaf + Intermediate CAs|
|SC-RIn-L-Is-LIs|Root CA + Intermediate CAs|Leaf Only|Issuing CA|Leaf + Issuing CA|
|SC-RIn-L-Is-L|Root CA + Intermediate CAs|Leaf Only|Issuing CA|Leaf Only|
|SC-RIn-L-IIs-F|Root CA + Intermediate CAs|Leaf Only|Incorrect Issuing CA|Full Chain|
|SC-RIn-L-IIs-LIn|Root CA + Intermediate CAs|Leaf Only|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-RIn-L-IIs-LIs|Root CA + Intermediate CAs|Leaf Only|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-RIn-L-IIs-L|Root CA + Intermediate CAs|Leaf Only|Incorrect Issuing CA|Leaf Only|
|SC-In-F-R-F|Intermediate CAs|Full Chain|Root CA|Full Chain|
|SC-In-F-R-LIn|Intermediate CAs|Full Chain|Root CA|Leaf + Intermediate CAs|
|SC-In-F-R-LIs|Intermediate CAs|Full Chain|Root CA|Leaf + Issuing CA|
|SC-In-F-R-L|Intermediate CAs|Full Chain|Root CA|Leaf Only|
|SC-In-F-RIn-F|Intermediate CAs|Full Chain|Root CA + Intermediate CAs|Full Chain|
|SC-In-F-RIn-LIn|Intermediate CAs|Full Chain|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-In-F-RIn-LIs|Intermediate CAs|Full Chain|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-In-F-RIn-L|Intermediate CAs|Full Chain|Root CA + Intermediate CAs|Leaf Only|
|SC-In-F-In-F|Intermediate CAs|Full Chain|Intermediate CAs|Full Chain|
|SC-In-F-In-LIn|Intermediate CAs|Full Chain|Intermediate CAs|Leaf + Intermediate CAs|
|SC-In-F-In-LIs|Intermediate CAs|Full Chain|Intermediate CAs|Leaf + Issuing CA|
|SC-In-F-In-L|Intermediate CAs|Full Chain|Intermediate CAs|Leaf Only|
|SC-In-F-Is-F|Intermediate CAs|Full Chain|Issuing CA|Full Chain|
|SC-In-F-Is-LIn|Intermediate CAs|Full Chain|Issuing CA|Leaf + Intermediate CAs|
|SC-In-F-Is-LIs|Intermediate CAs|Full Chain|Issuing CA|Leaf + Issuing CA|
|SC-In-F-Is-L|Intermediate CAs|Full Chain|Issuing CA|Leaf Only|
|SC-In-F-IIs-F|Intermediate CAs|Full Chain|Incorrect Issuing CA|Full Chain|
|SC-In-F-IIs-LIn|Intermediate CAs|Full Chain|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-In-F-IIs-LIs|Intermediate CAs|Full Chain|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-In-F-IIs-L|Intermediate CAs|Full Chain|Incorrect Issuing CA|Leaf Only|
|SC-In-LIn-R-F|Intermediate CAs|Leaf + Intermediate CAs|Root CA|Full Chain|
|SC-In-LIn-R-LIn|Intermediate CAs|Leaf + Intermediate CAs|Root CA|Leaf + Intermediate CAs|
|SC-In-LIn-R-LIs|Intermediate CAs|Leaf + Intermediate CAs|Root CA|Leaf + Issuing CA|
|SC-In-LIn-R-L|Intermediate CAs|Leaf + Intermediate CAs|Root CA|Leaf Only|
|SC-In-LIn-RIn-F|Intermediate CAs|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Full Chain|
|SC-In-LIn-RIn-LIn|Intermediate CAs|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-In-LIn-RIn-LIs|Intermediate CAs|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-In-LIn-RIn-L|Intermediate CAs|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf Only|
|SC-In-LIn-In-F|Intermediate CAs|Leaf + Intermediate CAs|Intermediate CAs|Full Chain|
|SC-In-LIn-In-LIn|Intermediate CAs|Leaf + Intermediate CAs|Intermediate CAs|Leaf + Intermediate CAs|
|SC-In-LIn-In-LIs|Intermediate CAs|Leaf + Intermediate CAs|Intermediate CAs|Leaf + Issuing CA|
|SC-In-LIn-In-L|Intermediate CAs|Leaf + Intermediate CAs|Intermediate CAs|Leaf Only|
|SC-In-LIn-Is-F|Intermediate CAs|Leaf + Intermediate CAs|Issuing CA|Full Chain|
|SC-In-LIn-Is-LIn|Intermediate CAs|Leaf + Intermediate CAs|Issuing CA|Leaf + Intermediate CAs|
|SC-In-LIn-Is-LIs|Intermediate CAs|Leaf + Intermediate CAs|Issuing CA|Leaf + Issuing CA|
|SC-In-LIn-Is-L|Intermediate CAs|Leaf + Intermediate CAs|Issuing CA|Leaf Only|
|SC-In-LIn-IIs-F|Intermediate CAs|Leaf + Intermediate CAs|Incorrect Issuing CA|Full Chain|
|SC-In-LIn-IIs-LIn|Intermediate CAs|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-In-LIn-IIs-LIs|Intermediate CAs|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-In-LIn-IIs-L|Intermediate CAs|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf Only|
|SC-In-LIs-R-F|Intermediate CAs|Leaf + Issuing CA|Root CA|Full Chain|
|SC-In-LIs-R-LIn|Intermediate CAs|Leaf + Issuing CA|Root CA|Leaf + Intermediate CAs|
|SC-In-LIs-R-LIs|Intermediate CAs|Leaf + Issuing CA|Root CA|Leaf + Issuing CA|
|SC-In-LIs-R-L|Intermediate CAs|Leaf + Issuing CA|Root CA|Leaf Only|
|SC-In-LIs-RIn-F|Intermediate CAs|Leaf + Issuing CA|Root CA + Intermediate CAs|Full Chain|
|SC-In-LIs-RIn-LIn|Intermediate CAs|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-In-LIs-RIn-LIs|Intermediate CAs|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-In-LIs-RIn-L|Intermediate CAs|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf Only|
|SC-In-LIs-In-F|Intermediate CAs|Leaf + Issuing CA|Intermediate CAs|Full Chain|
|SC-In-LIs-In-LIn|Intermediate CAs|Leaf + Issuing CA|Intermediate CAs|Leaf + Intermediate CAs|
|SC-In-LIs-In-LIs|Intermediate CAs|Leaf + Issuing CA|Intermediate CAs|Leaf + Issuing CA|
|SC-In-LIs-In-L|Intermediate CAs|Leaf + Issuing CA|Intermediate CAs|Leaf Only|
|SC-In-LIs-Is-F|Intermediate CAs|Leaf + Issuing CA|Issuing CA|Full Chain|
|SC-In-LIs-Is-LIn|Intermediate CAs|Leaf + Issuing CA|Issuing CA|Leaf + Intermediate CAs|
|SC-In-LIs-Is-LIs|Intermediate CAs|Leaf + Issuing CA|Issuing CA|Leaf + Issuing CA|
|SC-In-LIs-Is-L|Intermediate CAs|Leaf + Issuing CA|Issuing CA|Leaf Only|
|SC-In-LIs-IIs-F|Intermediate CAs|Leaf + Issuing CA|Incorrect Issuing CA|Full Chain|
|SC-In-LIs-IIs-LIn|Intermediate CAs|Leaf + Issuing CA|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-In-LIs-IIs-LIs|Intermediate CAs|Leaf + Issuing CA|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-In-LIs-IIs-L|Intermediate CAs|Leaf + Issuing CA|Incorrect Issuing CA|Leaf Only|
|SC-In-L-R-F|Intermediate CAs|Leaf Only|Root CA|Full Chain|
|SC-In-L-R-LIn|Intermediate CAs|Leaf Only|Root CA|Leaf + Intermediate CAs|
|SC-In-L-R-LIs|Intermediate CAs|Leaf Only|Root CA|Leaf + Issuing CA|
|SC-In-L-R-L|Intermediate CAs|Leaf Only|Root CA|Leaf Only|
|SC-In-L-RIn-F|Intermediate CAs|Leaf Only|Root CA + Intermediate CAs|Full Chain|
|SC-In-L-RIn-LIn|Intermediate CAs|Leaf Only|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-In-L-RIn-LIs|Intermediate CAs|Leaf Only|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-In-L-RIn-L|Intermediate CAs|Leaf Only|Root CA + Intermediate CAs|Leaf Only|
|SC-In-L-In-F|Intermediate CAs|Leaf Only|Intermediate CAs|Full Chain|
|SC-In-L-In-LIn|Intermediate CAs|Leaf Only|Intermediate CAs|Leaf + Intermediate CAs|
|SC-In-L-In-LIs|Intermediate CAs|Leaf Only|Intermediate CAs|Leaf + Issuing CA|
|SC-In-L-In-L|Intermediate CAs|Leaf Only|Intermediate CAs|Leaf Only|
|SC-In-L-Is-F|Intermediate CAs|Leaf Only|Issuing CA|Full Chain|
|SC-In-L-Is-LIn|Intermediate CAs|Leaf Only|Issuing CA|Leaf + Intermediate CAs|
|SC-In-L-Is-LIs|Intermediate CAs|Leaf Only|Issuing CA|Leaf + Issuing CA|
|SC-In-L-Is-L|Intermediate CAs|Leaf Only|Issuing CA|Leaf Only|
|SC-In-L-IIs-F|Intermediate CAs|Leaf Only|Incorrect Issuing CA|Full Chain|
|SC-In-L-IIs-LIn|Intermediate CAs|Leaf Only|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-In-L-IIs-LIs|Intermediate CAs|Leaf Only|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-In-L-IIs-L|Intermediate CAs|Leaf Only|Incorrect Issuing CA|Leaf Only|
|SC-Is-F-R-F|Issuing CA|Full Chain|Root CA|Full Chain|
|SC-Is-F-R-LIn|Issuing CA|Full Chain|Root CA|Leaf + Intermediate CAs|
|SC-Is-F-R-LIs|Issuing CA|Full Chain|Root CA|Leaf + Issuing CA|
|SC-Is-F-R-L|Issuing CA|Full Chain|Root CA|Leaf Only|
|SC-Is-F-RIn-F|Issuing CA|Full Chain|Root CA + Intermediate CAs|Full Chain|
|SC-Is-F-RIn-LIn|Issuing CA|Full Chain|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-Is-F-RIn-LIs|Issuing CA|Full Chain|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-Is-F-RIn-L|Issuing CA|Full Chain|Root CA + Intermediate CAs|Leaf Only|
|SC-Is-F-In-F|Issuing CA|Full Chain|Intermediate CAs|Full Chain|
|SC-Is-F-In-LIn|Issuing CA|Full Chain|Intermediate CAs|Leaf + Intermediate CAs|
|SC-Is-F-In-LIs|Issuing CA|Full Chain|Intermediate CAs|Leaf + Issuing CA|
|SC-Is-F-In-L|Issuing CA|Full Chain|Intermediate CAs|Leaf Only|
|SC-Is-F-Is-F|Issuing CA|Full Chain|Issuing CA|Full Chain|
|SC-Is-F-Is-LIn|Issuing CA|Full Chain|Issuing CA|Leaf + Intermediate CAs|
|SC-Is-F-Is-LIs|Issuing CA|Full Chain|Issuing CA|Leaf + Issuing CA|
|SC-Is-F-Is-L|Issuing CA|Full Chain|Issuing CA|Leaf Only|
|SC-Is-F-IIs-F|Issuing CA|Full Chain|Incorrect Issuing CA|Full Chain|
|SC-Is-F-IIs-LIn|Issuing CA|Full Chain|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-Is-F-IIs-LIs|Issuing CA|Full Chain|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-Is-F-IIs-L|Issuing CA|Full Chain|Incorrect Issuing CA|Leaf Only|
|SC-Is-LIn-R-F|Issuing CA|Leaf + Intermediate CAs|Root CA|Full Chain|
|SC-Is-LIn-R-LIn|Issuing CA|Leaf + Intermediate CAs|Root CA|Leaf + Intermediate CAs|
|SC-Is-LIn-R-LIs|Issuing CA|Leaf + Intermediate CAs|Root CA|Leaf + Issuing CA|
|SC-Is-LIn-R-L|Issuing CA|Leaf + Intermediate CAs|Root CA|Leaf Only|
|SC-Is-LIn-RIn-F|Issuing CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Full Chain|
|SC-Is-LIn-RIn-LIn|Issuing CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-Is-LIn-RIn-LIs|Issuing CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-Is-LIn-RIn-L|Issuing CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf Only|
|SC-Is-LIn-In-F|Issuing CA|Leaf + Intermediate CAs|Intermediate CAs|Full Chain|
|SC-Is-LIn-In-LIn|Issuing CA|Leaf + Intermediate CAs|Intermediate CAs|Leaf + Intermediate CAs|
|SC-Is-LIn-In-LIs|Issuing CA|Leaf + Intermediate CAs|Intermediate CAs|Leaf + Issuing CA|
|SC-Is-LIn-In-L|Issuing CA|Leaf + Intermediate CAs|Intermediate CAs|Leaf Only|
|SC-Is-LIn-Is-F|Issuing CA|Leaf + Intermediate CAs|Issuing CA|Full Chain|
|SC-Is-LIn-Is-LIn|Issuing CA|Leaf + Intermediate CAs|Issuing CA|Leaf + Intermediate CAs|
|SC-Is-LIn-Is-LIs|Issuing CA|Leaf + Intermediate CAs|Issuing CA|Leaf + Issuing CA|
|SC-Is-LIn-Is-L|Issuing CA|Leaf + Intermediate CAs|Issuing CA|Leaf Only|
|SC-Is-LIn-IIs-F|Issuing CA|Leaf + Intermediate CAs|Incorrect Issuing CA|Full Chain|
|SC-Is-LIn-IIs-LIn|Issuing CA|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-Is-LIn-IIs-LIs|Issuing CA|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-Is-LIn-IIs-L|Issuing CA|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf Only|
|SC-Is-LIs-R-F|Issuing CA|Leaf + Issuing CA|Root CA|Full Chain|
|SC-Is-LIs-R-LIn|Issuing CA|Leaf + Issuing CA|Root CA|Leaf + Intermediate CAs|
|SC-Is-LIs-R-LIs|Issuing CA|Leaf + Issuing CA|Root CA|Leaf + Issuing CA|
|SC-Is-LIs-R-L|Issuing CA|Leaf + Issuing CA|Root CA|Leaf Only|
|SC-Is-LIs-RIn-F|Issuing CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Full Chain|
|SC-Is-LIs-RIn-LIn|Issuing CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-Is-LIs-RIn-LIs|Issuing CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-Is-LIs-RIn-L|Issuing CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf Only|
|SC-Is-LIs-In-F|Issuing CA|Leaf + Issuing CA|Intermediate CAs|Full Chain|
|SC-Is-LIs-In-LIn|Issuing CA|Leaf + Issuing CA|Intermediate CAs|Leaf + Intermediate CAs|
|SC-Is-LIs-In-LIs|Issuing CA|Leaf + Issuing CA|Intermediate CAs|Leaf + Issuing CA|
|SC-Is-LIs-In-L|Issuing CA|Leaf + Issuing CA|Intermediate CAs|Leaf Only|
|SC-Is-LIs-Is-F|Issuing CA|Leaf + Issuing CA|Issuing CA|Full Chain|
|SC-Is-LIs-Is-LIn|Issuing CA|Leaf + Issuing CA|Issuing CA|Leaf + Intermediate CAs|
|SC-Is-LIs-Is-LIs|Issuing CA|Leaf + Issuing CA|Issuing CA|Leaf + Issuing CA|
|SC-Is-LIs-Is-L|Issuing CA|Leaf + Issuing CA|Issuing CA|Leaf Only|
|SC-Is-LIs-IIs-F|Issuing CA|Leaf + Issuing CA|Incorrect Issuing CA|Full Chain|
|SC-Is-LIs-IIs-LIn|Issuing CA|Leaf + Issuing CA|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-Is-LIs-IIs-LIs|Issuing CA|Leaf + Issuing CA|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-Is-LIs-IIs-L|Issuing CA|Leaf + Issuing CA|Incorrect Issuing CA|Leaf Only|
|SC-Is-L-R-F|Issuing CA|Leaf Only|Root CA|Full Chain|
|SC-Is-L-R-LIn|Issuing CA|Leaf Only|Root CA|Leaf + Intermediate CAs|
|SC-Is-L-R-LIs|Issuing CA|Leaf Only|Root CA|Leaf + Issuing CA|
|SC-Is-L-R-L|Issuing CA|Leaf Only|Root CA|Leaf Only|
|SC-Is-L-RIn-F|Issuing CA|Leaf Only|Root CA + Intermediate CAs|Full Chain|
|SC-Is-L-RIn-LIn|Issuing CA|Leaf Only|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-Is-L-RIn-LIs|Issuing CA|Leaf Only|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-Is-L-RIn-L|Issuing CA|Leaf Only|Root CA + Intermediate CAs|Leaf Only|
|SC-Is-L-In-F|Issuing CA|Leaf Only|Intermediate CAs|Full Chain|
|SC-Is-L-In-LIn|Issuing CA|Leaf Only|Intermediate CAs|Leaf + Intermediate CAs|
|SC-Is-L-In-LIs|Issuing CA|Leaf Only|Intermediate CAs|Leaf + Issuing CA|
|SC-Is-L-In-L|Issuing CA|Leaf Only|Intermediate CAs|Leaf Only|
|SC-Is-L-Is-F|Issuing CA|Leaf Only|Issuing CA|Full Chain|
|SC-Is-L-Is-LIn|Issuing CA|Leaf Only|Issuing CA|Leaf + Intermediate CAs|
|SC-Is-L-Is-LIs|Issuing CA|Leaf Only|Issuing CA|Leaf + Issuing CA|
|SC-Is-L-Is-L|Issuing CA|Leaf Only|Issuing CA|Leaf Only|
|SC-Is-L-IIs-F|Issuing CA|Leaf Only|Incorrect Issuing CA|Full Chain|
|SC-Is-L-IIs-LIn|Issuing CA|Leaf Only|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-Is-L-IIs-LIs|Issuing CA|Leaf Only|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-Is-L-IIs-L|Issuing CA|Leaf Only|Incorrect Issuing CA|Leaf Only|
|SC-IIs-F-R-F|Incorrect Issuing CA|Full Chain|Root CA|Full Chain|
|SC-IIs-F-R-LIn|Incorrect Issuing CA|Full Chain|Root CA|Leaf + Intermediate CAs|
|SC-IIs-F-R-LIs|Incorrect Issuing CA|Full Chain|Root CA|Leaf + Issuing CA|
|SC-IIs-F-R-L|Incorrect Issuing CA|Full Chain|Root CA|Leaf Only|
|SC-IIs-F-RIn-F|Incorrect Issuing CA|Full Chain|Root CA + Intermediate CAs|Full Chain|
|SC-IIs-F-RIn-LIn|Incorrect Issuing CA|Full Chain|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-IIs-F-RIn-LIs|Incorrect Issuing CA|Full Chain|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-IIs-F-RIn-L|Incorrect Issuing CA|Full Chain|Root CA + Intermediate CAs|Leaf Only|
|SC-IIs-F-In-F|Incorrect Issuing CA|Full Chain|Intermediate CAs|Full Chain|
|SC-IIs-F-In-LIn|Incorrect Issuing CA|Full Chain|Intermediate CAs|Leaf + Intermediate CAs|
|SC-IIs-F-In-LIs|Incorrect Issuing CA|Full Chain|Intermediate CAs|Leaf + Issuing CA|
|SC-IIs-F-In-L|Incorrect Issuing CA|Full Chain|Intermediate CAs|Leaf Only|
|SC-IIs-F-Is-F|Incorrect Issuing CA|Full Chain|Issuing CA|Full Chain|
|SC-IIs-F-Is-LIn|Incorrect Issuing CA|Full Chain|Issuing CA|Leaf + Intermediate CAs|
|SC-IIs-F-Is-LIs|Incorrect Issuing CA|Full Chain|Issuing CA|Leaf + Issuing CA|
|SC-IIs-F-Is-L|Incorrect Issuing CA|Full Chain|Issuing CA|Leaf Only|
|SC-IIs-F-IIs-F|Incorrect Issuing CA|Full Chain|Incorrect Issuing CA|Full Chain|
|SC-IIs-F-IIs-LIn|Incorrect Issuing CA|Full Chain|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-IIs-F-IIs-LIs|Incorrect Issuing CA|Full Chain|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-IIs-F-IIs-L|Incorrect Issuing CA|Full Chain|Incorrect Issuing CA|Leaf Only|
|SC-IIs-LIn-R-F|Incorrect Issuing CA|Leaf + Intermediate CAs|Root CA|Full Chain|
|SC-IIs-LIn-R-LIn|Incorrect Issuing CA|Leaf + Intermediate CAs|Root CA|Leaf + Intermediate CAs|
|SC-IIs-LIn-R-LIs|Incorrect Issuing CA|Leaf + Intermediate CAs|Root CA|Leaf + Issuing CA|
|SC-IIs-LIn-R-L|Incorrect Issuing CA|Leaf + Intermediate CAs|Root CA|Leaf Only|
|SC-IIs-LIn-RIn-F|Incorrect Issuing CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Full Chain|
|SC-IIs-LIn-RIn-LIn|Incorrect Issuing CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-IIs-LIn-RIn-LIs|Incorrect Issuing CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-IIs-LIn-RIn-L|Incorrect Issuing CA|Leaf + Intermediate CAs|Root CA + Intermediate CAs|Leaf Only|
|SC-IIs-LIn-In-F|Incorrect Issuing CA|Leaf + Intermediate CAs|Intermediate CAs|Full Chain|
|SC-IIs-LIn-In-LIn|Incorrect Issuing CA|Leaf + Intermediate CAs|Intermediate CAs|Leaf + Intermediate CAs|
|SC-IIs-LIn-In-LIs|Incorrect Issuing CA|Leaf + Intermediate CAs|Intermediate CAs|Leaf + Issuing CA|
|SC-IIs-LIn-In-L|Incorrect Issuing CA|Leaf + Intermediate CAs|Intermediate CAs|Leaf Only|
|SC-IIs-LIn-Is-F|Incorrect Issuing CA|Leaf + Intermediate CAs|Issuing CA|Full Chain|
|SC-IIs-LIn-Is-LIn|Incorrect Issuing CA|Leaf + Intermediate CAs|Issuing CA|Leaf + Intermediate CAs|
|SC-IIs-LIn-Is-LIs|Incorrect Issuing CA|Leaf + Intermediate CAs|Issuing CA|Leaf + Issuing CA|
|SC-IIs-LIn-Is-L|Incorrect Issuing CA|Leaf + Intermediate CAs|Issuing CA|Leaf Only|
|SC-IIs-LIn-IIs-F|Incorrect Issuing CA|Leaf + Intermediate CAs|Incorrect Issuing CA|Full Chain|
|SC-IIs-LIn-IIs-LIn|Incorrect Issuing CA|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-IIs-LIn-IIs-LIs|Incorrect Issuing CA|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-IIs-LIn-IIs-L|Incorrect Issuing CA|Leaf + Intermediate CAs|Incorrect Issuing CA|Leaf Only|
|SC-IIs-LIs-R-F|Incorrect Issuing CA|Leaf + Issuing CA|Root CA|Full Chain|
|SC-IIs-LIs-R-LIn|Incorrect Issuing CA|Leaf + Issuing CA|Root CA|Leaf + Intermediate CAs|
|SC-IIs-LIs-R-LIs|Incorrect Issuing CA|Leaf + Issuing CA|Root CA|Leaf + Issuing CA|
|SC-IIs-LIs-R-L|Incorrect Issuing CA|Leaf + Issuing CA|Root CA|Leaf Only|
|SC-IIs-LIs-RIn-F|Incorrect Issuing CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Full Chain|
|SC-IIs-LIs-RIn-LIn|Incorrect Issuing CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-IIs-LIs-RIn-LIs|Incorrect Issuing CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-IIs-LIs-RIn-L|Incorrect Issuing CA|Leaf + Issuing CA|Root CA + Intermediate CAs|Leaf Only|
|SC-IIs-LIs-In-F|Incorrect Issuing CA|Leaf + Issuing CA|Intermediate CAs|Full Chain|
|SC-IIs-LIs-In-LIn|Incorrect Issuing CA|Leaf + Issuing CA|Intermediate CAs|Leaf + Intermediate CAs|
|SC-IIs-LIs-In-LIs|Incorrect Issuing CA|Leaf + Issuing CA|Intermediate CAs|Leaf + Issuing CA|
|SC-IIs-LIs-In-L|Incorrect Issuing CA|Leaf + Issuing CA|Intermediate CAs|Leaf Only|
|SC-IIs-LIs-Is-F|Incorrect Issuing CA|Leaf + Issuing CA|Issuing CA|Full Chain|
|SC-IIs-LIs-Is-LIn|Incorrect Issuing CA|Leaf + Issuing CA|Issuing CA|Leaf + Intermediate CAs|
|SC-IIs-LIs-Is-LIs|Incorrect Issuing CA|Leaf + Issuing CA|Issuing CA|Leaf + Issuing CA|
|SC-IIs-LIs-Is-L|Incorrect Issuing CA|Leaf + Issuing CA|Issuing CA|Leaf Only|
|SC-IIs-LIs-IIs-F|Incorrect Issuing CA|Leaf + Issuing CA|Incorrect Issuing CA|Full Chain|
|SC-IIs-LIs-IIs-LIn|Incorrect Issuing CA|Leaf + Issuing CA|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-IIs-LIs-IIs-LIs|Incorrect Issuing CA|Leaf + Issuing CA|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-IIs-LIs-IIs-L|Incorrect Issuing CA|Leaf + Issuing CA|Incorrect Issuing CA|Leaf Only|
|SC-IIs-L-R-F|Incorrect Issuing CA|Leaf Only|Root CA|Full Chain|
|SC-IIs-L-R-LIn|Incorrect Issuing CA|Leaf Only|Root CA|Leaf + Intermediate CAs|
|SC-IIs-L-R-LIs|Incorrect Issuing CA|Leaf Only|Root CA|Leaf + Issuing CA|
|SC-IIs-L-R-L|Incorrect Issuing CA|Leaf Only|Root CA|Leaf Only|
|SC-IIs-L-RIn-F|Incorrect Issuing CA|Leaf Only|Root CA + Intermediate CAs|Full Chain|
|SC-IIs-L-RIn-LIn|Incorrect Issuing CA|Leaf Only|Root CA + Intermediate CAs|Leaf + Intermediate CAs|
|SC-IIs-L-RIn-LIs|Incorrect Issuing CA|Leaf Only|Root CA + Intermediate CAs|Leaf + Issuing CA|
|SC-IIs-L-RIn-L|Incorrect Issuing CA|Leaf Only|Root CA + Intermediate CAs|Leaf Only|
|SC-IIs-L-In-F|Incorrect Issuing CA|Leaf Only|Intermediate CAs|Full Chain|
|SC-IIs-L-In-LIn|Incorrect Issuing CA|Leaf Only|Intermediate CAs|Leaf + Intermediate CAs|
|SC-IIs-L-In-LIs|Incorrect Issuing CA|Leaf Only|Intermediate CAs|Leaf + Issuing CA|
|SC-IIs-L-In-L|Incorrect Issuing CA|Leaf Only|Intermediate CAs|Leaf Only|
|SC-IIs-L-Is-F|Incorrect Issuing CA|Leaf Only|Issuing CA|Full Chain|
|SC-IIs-L-Is-LIn|Incorrect Issuing CA|Leaf Only|Issuing CA|Leaf + Intermediate CAs|
|SC-IIs-L-Is-LIs|Incorrect Issuing CA|Leaf Only|Issuing CA|Leaf + Issuing CA|
|SC-IIs-L-Is-L|Incorrect Issuing CA|Leaf Only|Issuing CA|Leaf Only|
|SC-IIs-L-IIs-F|Incorrect Issuing CA|Leaf Only|Incorrect Issuing CA|Full Chain|
|SC-IIs-L-IIs-LIn|Incorrect Issuing CA|Leaf Only|Incorrect Issuing CA|Leaf + Intermediate CAs|
|SC-IIs-L-IIs-LIs|Incorrect Issuing CA|Leaf Only|Incorrect Issuing CA|Leaf + Issuing CA|
|SC-IIs-L-IIs-L|Incorrect Issuing CA|Leaf Only|Incorrect Issuing CA|Leaf Only|
