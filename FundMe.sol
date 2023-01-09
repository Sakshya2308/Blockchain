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
    
    address public owner;
    //using constructor so that the withdraw can only be used by the owner.
  constructor(){ // after calling this constructor we became the owner of the contract
      owner = msg.sender;
  }
  
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
    function withdraw() public onlyOwner{
           
        //    require(msg.sender == owner, "Sender is not owner");
           // reset all the contracts
            for(uint256 fundersIndex = 0; fundersIndex < funders.length; fundersIndex++){
                address funder = funders[fundersIndex];
                addressToAmountFunded[funder] = 0;
            }

            //another way of resetting
            funders = new address[](0); // funders variable now equals to new address array with 0 objects in it to start.
            // 3 ways, transfer, send, call. Can check in solidity by example website
            // msg.sender = address
            // payable(msg.sender) = payable address
            // payable(msg.sender).transfer(address[this].balance);

            // // send
            // bool sendSuccess = payable(msg.sender).send(address[this].balance);
            // require(sendSucess, "Send Failed");

            // // call
    
            // (bool callSucess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}("");
            (bool callSucess, ) = payable(msg.sender).call{value: address(this).balance}("");
            require(callSucess, "Call Failed");
    
    }
    modifier onlyOwner {
        require(msg.sender == owner, "Sender is not owner");
        _; // before the withdraw function look below in the onlyOwner and then doing the rest of the code.
        // _ means doing the rest of the code.
    }
}
