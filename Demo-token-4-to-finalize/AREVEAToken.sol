// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

// import "./IERC20.sol";
import "./SafeMath.sol";
import "./ReentrancyGuard.sol";
import "./Context.sol";
import "./Ownable.sol";
import "./Pausable.sol";
import "./ERC20.sol";

/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin guidelines: functions revert instead
 * of returning `false` on failure. This behavior is nonetheless conventional
 * and does not conflict with the expectations of ERC20 applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract AREVEAToken is ERC20,Ownable{
    
    using SafeMath for uint256;
    
    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;
    
    address private _owner;
    //uint256 private _initialSupply = 1000000 ;
    uint256 private _totalSupply= 1000;
    uint8 public constant DECIMALS = 0;
    uint256 public constant _initialSupply = 1000000 * (10 ** uint256(DECIMALS));
    uint256 private _maximusupply = 10000000 * (10 ** uint256(DECIMALS));
    //uint256 constant _maximusupply = 1000000 * (10 ** uint256(_decimals));
    
    string public _name ;
    string public _symbol;
    uint8 public _decimals;
   

    
    constructor() ERC20("AREVEA","AVA") {
        
        //_name = "AREVEA";
        //_symbol ="AVA";
        _decimals = 0;
        _mint(msg.sender,_initialSupply);
        _balances[msg.sender]=_initialSupply;
        _totalSupply ==  _initialSupply +_totalSupply * (10 ** uint256(_decimals));
        //_balances[msg.sender]=_totalSupply;
        
   }
    
   /**
     * @dev See {IERC20-totalSupply}.
     */
    function maximusupply() public view virtual returns (uint256) {
    return _maximusupply;
    }
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }
    function initialSupply() public view virtual returns (uint256) {
        return _initialSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
    * @dev Returns the token decimals.
    */
    // function decimals() public view virtual override returns (uint8) {
    //     return _decimals;
    // }

    /**
    * @dev Returns the token symbol.
    */
    // function symbol() public view virtual override returns (string memory) {
    //     return _symbol;
    // }

    /**
    * @dev Returns the token name.
    */
    // function name() public view virtual override returns(string memory) {
    //     return _name;
    // }
    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * Requirements:
     *
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
      function transferFrom(address from, address to, uint256 value) public override returns (bool) {
        _transfer(from, to, value);
        _approve(from, msg.sender, _allowances[from][msg.sender].sub(value));
        return true;
    }

    // function transferFrom(address sender, address recipient, uint256 amount) public whenNotPaused virtual override returns (bool) {
    //     _transfer(sender, recipient, amount);

    //     uint256 currentAllowance = _allowances[sender][_msgSender()];
    //     require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
    //     _approve(sender, _msgSender(), currentAllowance.sub(amount));

    //     return true;
    // }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    // function increaseAllowance(address spender, uint256 addedValue) public virtual override returns (bool) {
    //     address owner = _msgSender();
    //     _approve(owner, spender, allowance(owner, spender) + addedValue);
    //     return true;
    // }
    // function increaseAllowance(address spender, uint256 addedValue)  public virtual returns  (bool) {
    //     _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
    //     return true;
    // }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    //  function decreaseAllowance(address spender, uint256 subtractedValue) public virtual override  returns (bool) {
    //     address owner = _msgSender();
    //     uint256 currentAllowance = allowance(owner, spender);
    //     require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
    //     unchecked {
    //         _approve(owner, spender, currentAllowance - subtractedValue);
    //     }

    //     return true;
    // }
    // function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
    //     uint256 currentAllowance = _allowances[_msgSender()][spender];
    //     require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
    //     _approve(_msgSender(), spender, currentAllowance.sub( subtractedValue));

    //     return true;
    // }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal override virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        _balances[sender] = senderBalance.sub(amount);
        _balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     */
    function mint(address account, uint256 amount) public  onlyOwner  {
        require(account != address(0), "ERC20: mint to the zero address");
        require(totalSupply().add(amount) <= _maximusupply,"Maximum supply reached");
        _mint(account, amount);
        _beforeTokenTransfer(address(0), account, amount);
        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
        _afterTokenTransfer(address(0), account, amount);
    }
    //  function _mint(address account, uint256 amount) public onlyOwner {
    //     require(account != address(0), "ERC20: mint to the zero address");
    //     require(totalSupply().add(amount) <= _maximusupply,"Maximum supply reached");
    //     _beforeTokenTransfer(address(0), account, amount);
        
    //     _totalSupply = _totalSupply.add(amount);
    //     _balances[account] += amount;
    //     emit Transfer(address(0), account, amount);
    //     _afterTokenTransfer(address(0), account, amount);
    // }
    // function _mint(address account, uint256 amount)internal virtual override {
    //     require(account != address(0), "ERC20: mint to the zero address");
    //     //require(_totalSupply <= _maximusupply,"Maximum supply reached");
    //     require(totalSupply().add(amount) <= _maximusupply,"Maximum supply reached");
    //     _mint(account, amount);
    //     _beforeTokenTransfer(address(0), account, amount);
    //     //_totalSupply = _totalSupply.add(amount);
    //     _totalSupply += amount;
    //     _balances[account] += amount;
    //     emit Transfer(address(0), account, amount);
    //     _afterTokenTransfer(address(0), account, amount);
    // }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual override {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        _balances[account] = accountBalance.sub(amount);
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);
    }
    function burn(address account, uint256 amount) public onlyOwner {  
    _burn(account, amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual override {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be to transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override { }
    uint256[45] private __gap;
}