# vulnerabilities_smart_contracts_TFM
Study of the main vulnerabilities in smart contracts for a master's thesis on data security and privacy.

The TFM shows the main vulnerabilities included in the TOP 10 OWASP Vulnerability [ https://owasp.org/www-project-smart-contract-top-10/ ].

Each vulnerability is composed of three files:
{Vulnerability}.sol: The contract with vulnerability.
{Vulnerability}_solved.sol: The contract with the solved vulnerability.
{Vulnerability}_attack.sol: The contract that exploits the vulnerability.

To test one of the vulnerabilities is neccesary to deploy {Vulnerability}.sol and {Vulnerability}_attack.sol
To deploy correctly both contracts is neccesary to deploy {Vulnerability}_attack.sol with the direcction of contract deployed by {Vulnerability}.sol. For this reason, it is neccesary to deploy first {Vulnerability}.sol.

In order to test the solved version, it is the same proccess, but it is necessary to swap the contract {Vulnerability}.sol for {Vulnerability}_solved.sol.
