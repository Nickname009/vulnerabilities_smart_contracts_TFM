// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BadAccessControlSolved {
    // Variables    
    mapping(address => uint256) public balances;
    address public owner;
    
    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Funcion de deposito
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // Funcion de retirada
    function withdrawAll(address payable _to) public {
        // Si no es el dueño se revierte la transacción
        require(msg.sender == owner, "Not the owner!");
        _to.transfer(address(this).balance);
    }

    receive() external payable {}
}