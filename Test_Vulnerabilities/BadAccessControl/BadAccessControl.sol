// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BadAccessControl {
    mapping(address => uint256) public balances;
    address public owner;
    
    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }


    function withdrawAll(address payable _to) public {
        _to.transfer(address(this).balance); // Llamada pública en la que no se verifica si la cartera que llama es el dueño del contrato
    }

    receive() external payable {}
}