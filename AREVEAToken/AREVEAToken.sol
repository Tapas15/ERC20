// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./SafeMath.sol";
import "./Ownable.sol";
import "./ERC20.sol";

/**
 * @title AREVEA tokenImplementation
 * @author Tapas Mahanandia  (dToken mechanics derived from Compound cTokens, ERC20 methods
 * derived from Open Zeppelin's ERC20 contract)
 * @notice This contract provides the  implementation of AREVEA token
 * it is an upgradeable, ERC20 token,and current one has tranfer , approval, tranferfrom  increasse decrease 
   allowance and mint and burn functionality 
 */
// AREVEAToken is ERC20,and Ownable
contract AREVEAToken is ERC20,Ownable{
    /** 
     @dev using safe math for mathmatical calculation 
    */
    using SafeMath for uint256;
   /**
     // Create a table so that we can map addresses
     // to the private  balances associated with them 
    */
    mapping (address => uint256) private _balances;
    /**
     // Create a table so that we can map addresses
     // to the private _allowances associated with them 
    */
    
    mapping (address => mapping (address => uint256)) private _allowances;
     /** 
    // Owner of this contract  
    */
    address private _owner; // it is the address of owner 
    // In this case, the total supply
    // Slot one tracks the total issued dTokens.
    uint256 private _totalSupply;   
   // it it the decimal value 
    uint8 public constant _decimals = 18; 
    uint256 public constant _initialSupply = 1000000 * (10 ** uint256(_decimals)); // this is initial supply
    uint256 private _maximusupply = 1000000000000 * (10 ** uint256(_decimals)); // this is maximum supply 
    
    /**
       @dev ERC20 token name and symbol 
       @dev minted with initial supply is total initial supply in circulation 
       @dev balance to check owners initial supply
       @dev initial supply is part of total supply 
       @dev balance to check owners total supply   
     */ 
    constructor() ERC20("AREVEA","AVA") {
         mint(msg.sender,_initialSupply);//it is mint function to mint intial supply
        _balances[msg.sender]=_initialSupply;// to check the balance of inititial supply 
        _totalSupply ==  _initialSupply +_totalSupply * (10 ** uint256(_decimals));// total supply in circulation
        _balances[msg.sender]=_totalSupply; // to check the avalable balance of total supply of users in circulation 
        
       }
    
    /**
     * @dev This is the function to give total maximumsupply in return
     */
    function maximusupply() public view virtual returns (uint256) {
    // Because our function signature
    // states that the returning variable
    // is "theMaximuSupply", we'll just set that variable
    // to the value of the instance variable " _maximusupply"
    // and return it  
    return _maximusupply;
    }
   /**
     * @dev This is the function to give totalsupply in return
     */
    function totalSupply() public view virtual override returns (uint256) {
    // Because our function signature
    // states that the returning variable
    // is "theTotalSupply", we'll just set that variable
    // to the value of the instance variable "_totalSupply"
    // and return it
        return _totalSupply;
    }
    /**
     * @dev This is the function to give initialsupply in return
     */
    function initialSupply() public view virtual returns (uint256) {
    // Because our function signature
    // states that the returning variable
    // is "theInitialSupply", we'll just set that variable
    // to the value of the instance variable "_initialSupply"
    // and return it  
        return _initialSupply;
    }

     /**
       @dev Mint function to mint token , only owner can mint 
       @dev total supply is the circulating amount  cannot go beyond maximum supply in circulation
       @dev in mint funcion when amount is minted is added to the total supply and with the owner balance 
     */
  /***
   * @notice Function mint  underlying tokens from `msg.sender` public onlyOwner
   * to this contract, use them to mint cTokens as backing, and mint dTokens to
   * `msg.sender`. Ensure that this contract has been approved to transfer the balance 
   *of token on behalf of the caller before calling this function.
   */ 
    function mint(address account, uint256 amount) public  onlyOwner  {
        require(account != address(0), "ERC20: mint to the zero address");//total balance not equal to zero means no negative value bal
        require(totalSupply().add(amount) <= _maximusupply,"Maximum supply reached");// total supply should not cross maximum supply 
        _mint(account, amount); // mint account and add amount 
        _beforeTokenTransfer(address(0), account, amount);
        _totalSupply = _totalSupply.add(amount); // total balance after added tranfer to total supply 
        _balances[account] = _balances[account].add(amount); //total balance after minted of user 
        emit Transfer(address(0), account, amount); 
        _afterTokenTransfer(address(0), account, amount);
    }
    /**
       @dev Burn function to reduce excess supply in circulation 
       
     */
    
       function burnFrom(address account, uint256 amount) public virtual    {
        require(account != address(0), "ERC20: mint to the zero address");
       // require(amount <= allowance[account][msg.sender]);
        _burn(account, amount);// burn addount and less amount 
        _beforeTokenTransfer(address(0), account, amount);
        _totalSupply -= amount; // total supply is reduced by amount 
        _balances[account] -= amount;// total balance is reduced by amount 
        emit Transfer(address(0), account, amount);
        _afterTokenTransfer(address(0), account, amount);
     }


}
