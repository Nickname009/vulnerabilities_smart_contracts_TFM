// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BadValidation {
    mapping(address => uint256) public balances;

    constructor() {
        balances[msg.sender] = 1000;
    }

    function transfer(address _to, uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Not enough balance");
        balances[msg.sender] -= _amount; // Falta validar si _to es la dirección cero, el mismo usuario, se mandan tokens>0
        balances[_to] += _amount;
    }
}