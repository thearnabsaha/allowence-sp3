// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract allowencesWallet{
    //contract wallet stuffs
    receive() external payable{}
    function checkContractBalence() public view returns(uint){
        return address(this).balance;
    }
    //owner wallet stuffs
    address public owner;
    constructor(){
        owner=msg.sender;
    }
    //give allowences stuffs
    mapping(address=>uint) public allowences;
    function giveAllowence(address payable _to,uint _amount) public{
        require(owner==msg.sender,"you are not the owner!!!");
        allowences[_to]+=_amount;
        _to.transfer(_amount);
    }
    //use allowences stuffs
        event why(uint _amount,address _to,string _description);
    function useAllowence(uint _amount,address payable _to,string memory _description) public{
        require(allowences[msg.sender]>=_amount,"sorry you haven't enough money!!");
        require(_to!=msg.sender,"sorry you can't send money to youself");
        _to.transfer(_amount);
        allowences[msg.sender]=allowences[msg.sender]-_amount;
        emit why(_amount,_to,_description);
    }
}