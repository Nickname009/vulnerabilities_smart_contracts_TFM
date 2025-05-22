// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReentrancySolved {
    mapping(address => uint256) public balances;

    // Depositar ETH en el contrato
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // Retirar ETH 
    function withdraw() public {
        require(balances[msg.sender] > 0, "No funds to withdraw");

        uint256 amount = balances[msg.sender];

        // Primero se actualiza el balance
        balances[msg.sender] = 0;

        // Ahora se envia el ETH
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed to send ETH");
    }

    // Ver saldo del usuario
    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }
}