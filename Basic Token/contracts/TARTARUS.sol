// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract TARTARUS {


    string public constant name = "TARTARUS";
    string public constant symbol = "TART";
    uint8 public constant decimal = 18;


    uint256 _totalSupply;


    mapping (address => uint256) balances; 
    mapping (address => mapping(address => uint256)) allowed;


    event Transfer(address _from, address _to, uint256 _amount);
    event Approval(address _owner, address _spender, uint256 _amount);


    constructor() {
        _totalSupply = 10000000000000000000000000000;
        balances[msg.sender] = _totalSupply;
    }


    function balanceOf(address _owner) public view returns(uint256){
        return balances[_owner];
    }
    function allowance(address owner, address delegate) public view returns(uint256) {
        return allowed[owner][delegate];
    }
    function totalSupply()public view returns(uint256) {
        return _totalSupply;
    }



    function transfer(address _reciver, uint256 _amount) public returns(bool success){
        require(balances[msg.sender] >= _amount, "Owner does not have required amount of token");
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_reciver] = balances[_reciver] + _amount; 
        emit Transfer(msg.sender, _reciver, _amount);
        return true;
    }
    function approve(address _delegate, uint256 _amount) public returns(bool success){
        allowed[msg.sender][_delegate] = _amount;
        emit Approval(msg.sender, _delegate, _amount);
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _amount) public returns(bool success){
        require(balances[_from] >= _amount, "Sender does not have required amount of token");
        require(_amount <= allowed[_from][msg.sender], "Sender does not have required allowance");
        balances[_from] = balances[_from] - _amount;
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - _amount;
        balances[_to] = balances[_to] + _amount; 
        emit Transfer(_from, _to, _amount);
        return true;
    }
}