// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reentrancy {
    // Variables    
    mapping(address => uint256) public balances;

    // Funcion de deposito
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // Funcion de retirada
    function withdraw() public {
        require(balances[msg.sender] > 0, "Not enough balance!");
        uint256 amount = balances[msg.sender];

        // Enviar Créditos
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed to send Credit");

        // Actualizar Créditos
        balances[msg.sender] = 0;
    }

    // Ver saldo del usuario
    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }
}