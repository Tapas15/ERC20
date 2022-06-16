 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract AREVAERC20Token {
    // Track how many tokens are owned by each address.
    mapping (address => uint256) public balanceOf;
    //variable initialized
    string public name = "AREVEA";
    string public symbol = "AVA";
    uint8 public decimals = 18;
    // maximum supply of contract and units 
    uint256 public totalSupply = 1000000000000 * (uint256(10) ** decimals);
    //event to transfer balance 
    event Transfer(address indexed from, address indexed to, uint256 value);
    //function to check balance  
    function AREVEAToken() public {
        // Initially assign all tokens to the contract's creator.
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }
    // function to transfer 
    function transfer(address to, uint256 value) public returns (bool success) {
        require(balanceOf[msg.sender] >= value);

        balanceOf[msg.sender] -= value;  // deduct from sender's balance
        balanceOf[to] += value;          // add to recipient's balance
        emit Transfer(msg.sender, to, value);
        return true;
    }
    //Approval of transaction 
    event Approval(address indexed owner, address indexed spender, uint256 value);

    mapping(address => mapping(address => uint256)) public allowance;

    function approve(address spender, uint256 value)
        public
        returns (bool success)
    {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    //function to get from 
    function transferFrom(address from, address to, uint256 value)
        public
        returns (bool success)
    {
        require(value <= balanceOf[from]);
        require(value <= allowance[from][msg.sender]);

        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }
}
