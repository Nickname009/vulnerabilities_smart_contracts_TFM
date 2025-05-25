// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UncheckedExternalCallSolved {
    // Variables
    mapping(address => uint256) public balances;

    //Función de deposito
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    //Función de retirada
    function withdraw() public {
        uint256 amount = balances[msg.sender];

        // Llamada externa
        (bool sent, ) = msg.sender.call{value: amount}("");

        // El resultado se verifica
        require(sent, "Transfer failed");

        balances[msg.sender] = 0;
    }

    receive() external payable {}
}