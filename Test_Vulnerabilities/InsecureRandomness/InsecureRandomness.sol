// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsecureRandomness {
    address public winner;
    uint256 public prize;

    constructor() payable {
        prize = msg.value;
    }

    function play(uint256 i) public {
        // Supuesta "aleatoriedad" vulnerable
        uint256 random = uint256(keccak256(abi.encodePacked( block.timestamp + i, msg.sender))) % 100;

        // Gana si el número aleatorio es uperior a 90
        if (random > 90 ) {
            winner = msg.sender;
            payable(msg.sender).transfer(prize);
        }
    }
}