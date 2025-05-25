// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BadValidationSolved {
    // Variables    
    mapping(address => uint256) public balances;

    // Constructor
    constructor() {
        balances[msg.sender] = 1000;
    }
	
    //Función de transferencia
    function transfer(address _to, uint256 _amount) public {
        // Validar si _to es una dirección nula
        require(_to != address(0), "Cannot send to zero address"); 
        // Validar si _to es la misma dirección del emisor 
        require(_to != msg.sender, "Cannot send credits to yourself");
        // Validar si _amount es mayor que 0
        require(_amount > 0, "Cannot send to zero credits"); 

        // Validar si el emisor dispone de saldo
        require(balances[msg.sender] >= _amount, "Not enough balance");


        //Actualización de saldo 
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}