// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract Underflow {
    mapping(address => uint256) public balances;

    constructor() {
        balances[msg.sender] = 100;
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] - _amount >= 0, "Underflow!");
        balances[msg.sender] -= _amount; // Posible underflow
    }
}

