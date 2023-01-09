//SPDX-License-Identifier:MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; // importing directly from github

library PriceConverter{
    function getPrice() internal view returns(uint256){ //Used to find the lastest price of ethereum (in this using goerli test network)
        // whenever we work with the contract we need ABI and the address
        
        //ABI
        //Address
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e); // Goerli test network ETH to USD price
        (,int price,,,) = priceFeed.latestRoundData(); // Interface for us to communicate with the blockchain
        return uint256(price*1e10); // price is in 8 decimals
   
    }
    function getVersion() internal view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }
    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = getPrice(); // Get the price of ehthereum
        uint256 ethAmountInUsd = (ethAmount*ethPrice) / 1e18;
        return ethAmountInUsd;
    }
}




//It is goind to be a library that we are going to attach to uint256
