// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BadValidation {
    // Variables
    mapping(address => uint256) public balances;
    
    // Constructor
    constructor() {
        balances[msg.sender] = 1000;
    }

    function transfer(address _to, uint256 _amount) public {
        // Falta validar si _to es una dirección nula
        // Falta validar si _to es la misma dirección del emisor
        // Falta validar si _amount es 0 tokens

        // Validar si el emisor dispone de saldo
        require(balances[msg.sender] >= _amount, "Not enough balance");

        //Actualización de saldo 
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}