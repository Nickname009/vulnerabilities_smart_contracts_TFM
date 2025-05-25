// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITokenLackOfInputValidation{
    function transfer(address _to, uint256 _amount) external;
}

contract LackOfInputValidationAttack {
    // Variables
    ITokenLackOfInputValidation public target;

    // Constructor
    constructor(address _target) {
        target = ITokenLackOfInputValidation(_target);
    }

    //Función de Ataque
    function attack() public {
        target.transfer(address(0), 500); // Los 500 tokens se queman
    }
}