// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./AssetToken.sol";

contract Governance {

    AssetToken public token;

    struct Proposal {
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        bool executed;
    }

    Proposal[] public proposals;

    mapping(uint256 => mapping(address => bool)) public voted;

    constructor(address tokenAddress) {
        token = AssetToken(tokenAddress);
    }

    function createProposal(string memory description) public {

        proposals.push(
            Proposal(description,0,0,false)
        );
    }

    function vote(uint256 proposalId, bool support) public {

        require(!voted[proposalId][msg.sender], "Already voted");

        uint256 votingPower = token.balanceOf(msg.sender);
        require(votingPower > 0, "No voting power");

        voted[proposalId][msg.sender] = true;

        if(support){
            proposals[proposalId].votesFor += votingPower;
        } else {
            proposals[proposalId].votesAgainst += votingPower;
        }
    }
}
