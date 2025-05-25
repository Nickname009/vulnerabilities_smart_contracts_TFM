// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract Underflow {
    // Variables
    mapping(address => uint256) public balances;

    // Constructor
    constructor() {
        balances[msg.sender] = 100;
    }
    
    //Función de retirada
    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] - _amount >= 0, "Underflow!");
        balances[msg.sender] -= _amount; // Posible underflow
    }
}

