// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BadValidationSolved {
    mapping(address => uint256) public balances;

    constructor() {
        balances[msg.sender] = 1000;
    }

    function transfer(address _to, uint256 _amount) public {
        require(_to != address(0), "Cannot send to zero address"); // Comprobación dirección no nula
        require(_to != msg.sender, "Cannot send to yourself"); // Comprobación de no enviar a la misma dirección
                                                               // para quemar créditos por repetición
        require(balances[msg.sender] >= _amount, "Not enough balance");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}