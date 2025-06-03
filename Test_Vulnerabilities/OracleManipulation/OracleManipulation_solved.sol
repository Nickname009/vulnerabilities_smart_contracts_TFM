// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IOracle {
    function getPrice() external view returns (uint256);
}

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Token ERC20 sin cambios
contract VulnerableToken is ERC20 {
    constructor() ERC20("VulnerableToken", "VNT") {
        _mint(msg.sender, 1000000 ether);
    }
}

// Oráculo no confiable (para pruebas o entornos no seguros)
contract VulnerableOracle {
    uint256 private price = 1 ether;

    function setPrice(uint256 _price) external {
        price = _price;
    }

    function getPrice() external view returns (uint256) {
        return price;
    }
}

// Versión segura del contrato vulnerable
contract PriceOracleManipulationSolved is Ownable {
    // Variables
    IERC20 public token;
    IOracle public oracle;

    // Guardar ultima actualización
    uint256 public price;
    uint256 public lastUpdated;
    uint256 public updateInterval = 1 hours;

    // Constructor
    constructor(address _token, address _oracle) Ownable(msg.sender) {
        token = IERC20(_token);
        oracle = IOracle(_oracle);
    }


    // Actualizar el valor del token
    function updatePrice() external onlyOwner {
        require(block.timestamp >= lastUpdated + updateInterval, "Too soon to update price");
        price = oracle.getPrice();
        lastUpdated = block.timestamp;
    }

    // Comprar tokens
    function buyTokens() external payable {
        require(msg.value > 0, "Send Credits to buy tokens");
        require(price > 0, "Price not set");

       // Utilizar valor del token almacenado	
        uint256 tokensToBuy = (msg.value * 1 ether) / price;

        require(token.balanceOf(address(this)) >= tokensToBuy, "Not enough tokens in reserve");
        token.transfer(msg.sender, tokensToBuy);
    }

    // Vender tokens
    function sellTokens(uint256 tokenAmount) external {
        require(tokenAmount > 0, "Need to sell some tokens");
        require(price > 0, "Price not set");

        // Utilizar valor del token almacenado        		
        uint256 ethToReturn = (tokenAmount * price) / 1 ether;

        require(address(this).balance >= ethToReturn, "Need more Balance");
        require(token.transferFrom(msg.sender, address(this), tokenAmount), "Transfer failed");

        payable(msg.sender).transfer(ethToReturn);
    }

    receive() external payable {}
}
