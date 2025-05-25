// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReentrancySolved {
    // Variables
    mapping(address => uint256) public balances;

    //Función de deposito
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // Funcion de retirada
    function withdraw() public {
        //Comprobar fondos
        require(balances[msg.sender] > 0, "Not enough balance!");
        uint256 amount = balances[msg.sender];

        // Actualizar Créditos
        balances[msg.sender] = 0;

        // Enviar Créditos
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed to send Credit");
    }

    // Ver saldo del usuario
    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }
}