// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DenialOfService {
    address public highestBidder;
    uint public highestBid;

    function bid() external payable {
        require(msg.value > highestBid, "Too low");

        // Reembolsar al anterior ganador
        if (highestBid != 0) {
            (bool success, ) = payable(highestBidder).call{value: highestBid}("");
            require(success, "Refund failed");
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }
}