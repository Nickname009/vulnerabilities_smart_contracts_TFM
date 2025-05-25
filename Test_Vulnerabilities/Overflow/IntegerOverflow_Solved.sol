// SPDX-License-Identifier: MIT
// La versión del compilador comprueba automaticamente el overflow
pragma solidity ^0.8.0;

contract OverflowSolved {
    // Variables    
    mapping(address => uint8) public balances;

    // Constructor
    constructor() {
        balances[msg.sender] = 250; // Casi el límite

        //Se añaden creditos extra a una cuenta secundaria para poder realizar la transacción de overflow
        balances[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2]=250;
    }

    // Funcion de transferencia
    function transfer(address _to, uint8 _amount) public {
        require(balances[msg.sender] >= _amount, "Not enough balance");
        balances[msg.sender] -= _amount;

        // Posible Overflow (Corregido con la version 0.8 Solidity)
        balances[_to] += _amount;  
    }
}