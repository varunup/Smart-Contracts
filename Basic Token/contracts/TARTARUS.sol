// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract TARTARUS {
    string public constant name = "TARTARUS";
    string public constant symbol = "TART";
    uint8 public constant decimal = 18;
    uint256 public constant totalSupply = 10000000000000000000000000000;

    mapping(address => uint256)balance; 

    event Transfer(address _from, address _to, uint256 _amount);

    constructor() payable {
        balance[msg.sender] = totalSupply;
    }

    function balanceOf(address _owner) public view returns(uint256){
        return balance[_owner];
    }

    function transfer(address _reciver, uint256 _amount) public payable returns(bool){
        require(balance[msg.sender] >= _amount, "Owner does not have required amount of token");
        balance[msg.sender] = balance[msg.sender] - _amount;
        balance[_reciver] = balance[_reciver] + _amount; 
        emit Transfer(msg.sender, _reciver, _amount);
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _amount) public payable returns(bool){
        require(balance[_from] >= _amount, "Sender does not have required amount of token");
        balance[_from] = balance[_from] - _amount;
        balance[_to] = balance[_to] + _amount; 
        emit Transfer(_from, _to, _amount);
        return true;
    }
}