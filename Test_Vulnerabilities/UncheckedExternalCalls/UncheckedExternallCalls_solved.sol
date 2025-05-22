// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UncheckedExternalCallSolved {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 amount = balances[msg.sender];

        // Llamada externa
        (bool sent, ) = msg.sender.call{value: amount}("");

        // El resultado se verifica
        require(sent, "Transfer failed");

        balances[msg.sender] = 0;
    }

    receive() external payable {}
}