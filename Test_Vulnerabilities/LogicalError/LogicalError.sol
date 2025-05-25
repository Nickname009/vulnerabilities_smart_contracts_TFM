// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LogicalError {
    mapping(address => uint256) public balances;

    // Funcion de deposito
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // Funcion de retirada
    function withdraw() external {
        uint256 amount = balances[msg.sender];

        // Calcular interés e importe a devolver
        uint256 interest = amount / 10;
        uint256 totalAmount = amount + interest;

        
        //require(address(this).balance >= totalAmount, "Not enough balance in contract");
	   
        // Pagar interes y devolver creditos al cliente
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(totalAmount);
    }

    receive() external payable {}
}