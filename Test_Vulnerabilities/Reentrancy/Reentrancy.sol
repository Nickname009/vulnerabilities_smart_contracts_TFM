// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reentrancy {
    mapping(address => uint256) public balances;

    // Depositar ETH en el contrato
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // Retirar ETH
    function withdraw() public {
        require(balances[msg.sender] > 0, "No funds to withdraw");

        uint256 amount = balances[msg.sender];

        // Se envía ETH antes de actualizar el balance
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed to send ETH");

        // El balance se actualiza después del envío
        balances[msg.sender] = 0;
    }

    // Ver saldo del usuario
    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }
}