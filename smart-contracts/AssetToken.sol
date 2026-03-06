// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Compliance.sol";

contract AssetToken is ERC20 {

    address public issuer;
    Compliance public compliance;

    constructor(
        string memory name,
        string memory symbol,
        address complianceAddress
    ) ERC20(name, symbol) {
        issuer = msg.sender;
        compliance = Compliance(complianceAddress);
    }

    modifier onlyIssuer() {
        require(msg.sender == issuer, "Not issuer");
        _;
    }

    function mint(address investor, uint256 amount) public onlyIssuer {
        require(compliance.isWhitelisted(investor), "Investor not verified");
        _mint(investor, amount);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override {

        if(from != address(0)){
            require(compliance.isWhitelisted(to), "Receiver not KYC verified");
        }

        super._beforeTokenTransfer(from, to, amount);
    }
}
