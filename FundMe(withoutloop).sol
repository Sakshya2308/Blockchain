// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;
    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders; // maintains array of funders as their address
    mapping(address => uint256) public addressToAmountFunded; // how much money is each user sending
    function fund() public payable{
            //Want to be able to set a minimum fund amount in USD
            //1. How do we send ETH to this contract?
            
            require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough"); // 1e18 = 1*10**18 The amount of etherium we are inputing (wei)
            // 18 decimals

            //What is reverting?
            // Undo any action before, and send remaining gas back
            funders.push(msg.sender);
            addressToAmountFunded[msg.sender] = msg.value;
    }
    
}
