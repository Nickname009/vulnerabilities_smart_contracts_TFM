// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract Overflow {
    mapping(address => uint8) public balances;

    constructor() {
        balances[msg.sender] = 250; // Casi el límite
        //Añado creditos extra para poder a posteriori realizar la transacción de overflow
        balances[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2]=250;
    }

    function transfer(address _to, uint8 _amount) public {
        require(balances[msg.sender] >= _amount, "Not enough balance");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount; // Posible Overflow
    }
}