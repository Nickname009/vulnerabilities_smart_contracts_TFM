// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IOracle {
    function getPrice() external view returns (uint256);
}

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


// Tokens del contrato
contract VulnerableToken is ERC20 {
    constructor() ERC20("VulnerableToken", "VNT") {
        _mint(msg.sender, 1000000 ether); // 1 millón de tokens al deployer
    }
}

// Oraculo no confiable
contract VulnerableOracle {
    uint256 private price = 1 ether; // 1 token = 1 USD (simulado en wei)

    function setPrice(uint256 _price) external {
        price = _price;
    }

    function getPrice() external view returns (uint256) {
        return price;
    }
}

contract PriceOracleManipulation {
    // Variables
    IERC20 public token;
    IOracle public oracle;
    address public owner;

    // Constructor
    constructor(address _token, address _oracle) {
        token = IERC20(_token);
        oracle = IOracle(_oracle);
        owner = msg.sender;
    }

    // Comprar tokens
    function buyTokens() external payable {
        require(msg.value > 0, "Send Credits to buy tokens");
        
        // Calcular precio para comprar
        uint256 price = oracle.getPrice(); 
        uint256 tokensToBuy = (msg.value * 1 ether) / price;

        require(token.balanceOf(address(this)) >= tokensToBuy, "Not enough tokens in reserve");
        token.transfer(msg.sender, tokensToBuy);
    }

    // Vender tokens
    function sellTokens(uint256 tokenAmount) external {
        require(tokenAmount > 0, "Need to sell some tokens");

        // Calcular precio para vender
        uint256 price = oracle.getPrice();
        uint256 ethToReturn = (tokenAmount * price) / 1 ether;

        require(address(this).balance >= ethToReturn, "Need more Balance");
        require(token.transferFrom(msg.sender, address(this), tokenAmount), "Transfer failed");

        payable(msg.sender).transfer(ethToReturn);
    }

    // Recibir ETH
    receive() external payable {}
}
