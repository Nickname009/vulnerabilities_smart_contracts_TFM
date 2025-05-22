// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UncheckedExternalCall {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 amount = balances[msg.sender];
        
        // El resultado no se verifica
        msg.sender.call{value: amount}("");

        balances[msg.sender] = 0; // Esto se ejecuta aunque el envío haya fallado
    }

    receive() external payable {}
}