// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BadAccessControlSolved {
    mapping(address => uint256) public balances;
    address public owner;
    
    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }


    function withdrawAll(address payable _to) public {
        require(msg.sender == owner, "Not the owner!"); // Si no es el dueño se revierte la transacción
        _to.transfer(address(this).balance); // se verifica previamente si la cartera que llama es el dueño del contrato
    }

    receive() external payable {}
}