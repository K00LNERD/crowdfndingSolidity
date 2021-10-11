// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "./transferhelper.sol";

contract campaign{
    address tokenadder;
    uint id;
    mapping(uint => uint) raiseAmountOFThisID;
    mapping(uint => address) messageSenderOFThisID;
    mapping(uint => uint) raisedAmountOFThisID;
    struct campaign{
        uint raiseAmountOFThisID;
        address messageSenderOFThisID;
        uint raisedAmountOFThisID;
    }
    mapping(uint=>campaign) public test;
    
    constructor(address _tokenadder){
        tokenadder = _tokenadder;
    }
    
    function registerCampaign( uint _raiseAmount, uint _stakeAmount ) public{
        id++;
        raiseAmountOFThisID[id]= _raiseAmount;
        messageSenderOFThisID[id]= msg.sender;
        TransferHelper.safeTransferFrom(tokenadder,msg.sender,address(this), _stakeAmount );
    }
    
    function donate(uint _id) public payable {
        require(raisedAmountOFThisID[_id] + msg.value <= raiseAmountOFThisID[_id], "funds exceeded");
        raisedAmountOFThisID[_id] += msg.value;
        TransferHelper.safeTransfer(tokenadder,msg.sender, msg.value);
        address payable a = payable(messageSenderOFThisID[_id]);
        a.transfer(msg.value);
    }
    

}