// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BadAccessControl {
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
         // No se comprueba quien esta llamando a la funcion
        _to.transfer(address(this).balance);
    }

    receive() external payable {}
}