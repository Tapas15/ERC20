// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./SafeMath.sol";
import "./Ownable.sol";
import "./ERC20.sol";
/// @title AREVEA token is a special contract for crypto related services 
/// @author Tapas Mahanandia
/// @notice It does crypto related mint, burn, transfer services 
/// @dev its a special token

contract AREVEAToken is ERC20,Ownable{
    /** 
     @dev using safe math for mathmatical calculation 
    */
    using SafeMath for uint256;
   /** 
     @dev private balance is initialized with privat allowance 
    */
    mapping (address => uint256) private _balances;
    
    mapping (address => mapping (address => uint256)) private _allowances;
     /** 
     @dev private owner ,total supply maximumsupply variable initialized 
     @dev public constant decimals and initial supply initialized 
    */
    address private _owner; // it is the address of owner 
    uint256 private _totalSupply; // it is the total supply variable is init
    uint8 public constant _decimals = 18; // it it the decimal value 
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
    return _maximusupply;
    }
   /**
     * @dev This is the function to give totalsupply in return
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }
    /**
     * @dev This is the function to give initialsupply in return
     */
    function initialSupply() public view virtual returns (uint256) {
        return _initialSupply;
    }

     /**
       @dev Mint function to mint token , only owner can mint 
       @dev total supply is the circulating amount  cannot go beyond maximum supply in circulation
       @dev in mint funcion when amount is minted is added to the total supply and with the owner balance 
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
