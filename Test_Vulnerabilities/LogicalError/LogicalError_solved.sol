

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LogicalErrorSolved {
    // Variables
    mapping(address => uint256) public balances;
    mapping(address => uint256) public depositTimestamps;
    uint256 public constant MIN_WAIT_TIME = 10 seconds;

    // Funcion de deposito
    function deposit() external payable {
        balances[msg.sender] += msg.value;
        depositTimestamps[msg.sender] = block.timestamp;
    }

    // Funcion de retirada
    function withdraw() external {
        uint256 amount = balances[msg.sender];

        //Restriccion de tiempo
        require(
            block.timestamp >= depositTimestamps[msg.sender] + MIN_WAIT_TIME,
            "Withdrawal not yet allowed"
        );

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