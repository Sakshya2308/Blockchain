// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; // importing directly from github
contract FundMe {
    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders; // maintains array of funders as their address
    mapping(address => uint256) public addressToAmountFunded; // how much money is each user sending
    function fund() public payable{
            //Want to be able to set a minimum fund amount in USD
            //1. How do we send ETH to this contract?
    
            require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough"); // 1e18 = 1*10**18 The amount of etherium we are inputing (wei)
            // 18 decimals

            //What is reverting?
            // Undo any action before, and send remaining gas back
            funders.push(msg.sender);
            addressToAmountFunded[msg.sender] = msg.value;
    }
    function getPrice() public view returns(uint256){ //Used to find the lastest price of ethereum (in this using goerli test network)
        // whenever we work with the contract we need ABI and the address
        
        //ABI
        //Address
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e); // Goerli test network ETH to USD price
        (,int price,,,) = priceFeed.latestRoundData(); // Interface for us to communicate with the blockchain
        return uint256(price*1e10); // price is in 8 decimals
   
    }
    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }
    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice(); // Get the price of ehthereum
        uint256 ethAmountInUsd = (ethAmount*ethPrice) / 1e18;
        return ethAmountInUsd;
    }
}
