// SPDX-License-Identifier: MIT

// Attempt for Ethereum Blockchain Developer Bootcamp With Solidity (2021) Udemy course
// Allows an owner to deposit ether, designate other users to withdraw, and once designated they can withdraw
pragma solidity ^0.8.0;

contract SharedWallet {
    
    address public owner;
    mapping(address => bool) public addressWithdrawalPermissions;
    
    constructor () {
        owner = msg.sender;
        addressWithdrawalPermissions[owner] = true;
    }
    
    function depositFunds() public payable onlyOwner {
        // Doesn't have to be onlyOwner if we want to let other people deposit regardless
    }
    
    function grantWithdrawalPermission(address _address) public onlyOwner {
        addressWithdrawalPermissions[_address] = true;
    }
    
    function revokeWithdrawalPermission(address _address) public onlyOwner {
        require(_address != owner, "You cannot revoke the owner's withdrawal permission");
        delete addressWithdrawalPermissions[_address];
    }
    
    function withdrawFunds(uint _amount) public {
        require(_amount <= address(this).balance, "You cannot withdraw that much");
        require(addressWithdrawalPermissions[msg.sender] == true, "You do not have permission to withdraw");
        
        payable(msg.sender).transfer(_amount);
    }
    
    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
    
    
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner, "You are not the owner");
        _;
    }
}