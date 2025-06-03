// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DenialOfServiceSolved {
    address public highestBidder;
    uint public highestBid;
    mapping(address => uint) public refunds;

    function bid() external payable {
        require(msg.value > highestBid, "Too low");

        // Acumula el reembolso en vez de enviarlo
        if (highestBid != 0) {
            refunds[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    function withdraw() external {
        uint amount = refunds[msg.sender];
        refunds[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}