// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./AssetToken.sol";

contract Exchange {

    struct Order {
        address trader;
        uint256 amount;
        uint256 price;
        bool isBuy;
    }

    AssetToken public token;

    Order[] public orders;

    constructor(address tokenAddress) {
        token = AssetToken(tokenAddress);
    }

    function placeBuyOrder(uint256 amount, uint256 price) public payable {

        require(msg.value >= amount * price, "Not enough funds");

        orders.push(
            Order(msg.sender, amount, price, true)
        );
    }

    function placeSellOrder(uint256 amount, uint256 price) public {

        require(token.balanceOf(msg.sender) >= amount, "Not enough tokens");

        token.transfer(address(this), amount);

        orders.push(
            Order(msg.sender, amount, price, false)
        );
    }

}
