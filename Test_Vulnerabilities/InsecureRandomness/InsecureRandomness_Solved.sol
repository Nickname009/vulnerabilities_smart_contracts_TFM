// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsecureRandomness {
    address public winner;
    uint256 public prize;
    
    address private owner;

    constructor() payable {
        prize = msg.value;
        owner = msg.sender;
    }

    function play(uint256 i) public {
        // Se tiene en cuenta la semilla del cliente
        uint256 random = uint256(keccak256(abi.encodePacked( owner, i))) % 100;

        // Gana si el número aleatorio es mayor de 90
        if (random > 90) {
            winner = msg.sender;
            payable(msg.sender).transfer(prize);
        }
    }
}