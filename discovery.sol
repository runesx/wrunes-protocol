/**
 *Submitted for verification at BscScan.com on 2021-05-23
*/

// PancakeSwap Core: https://github.com/pancakeswap/pancake-swap-core
interface IPancakeRouterLike {
  function getAmountsOut(uint256 amountIn, address[] calldata path) external view returns (uint256[] memory amounts);
}


// PancakeSwap Core: https://github.com/pancakeswap/pancake-swap-core
interface IPancakePairLike {
  function token0() external view returns (address);

  function token1() external view returns (address);

  function totalSupply() external view returns (uint256);

  function getReserves()
    external
    view
    returns (
      uint112 reserve0,
      uint112 reserve1,
      uint32 blockTimestampLast
    );
}


interface IFarm {
  /**
   * @dev Gets the total number of NEP allocated to be distributed as reward
   */
  function _totalRewardAllocation() external view returns (uint256);

  /**
   * @dev Gets the summary of the Cake Farm
   * @param account Account to obtain summary of
   * @param values[0] rewards Your pending rewards
   * @param values[1] staked Your liquidity token balance
   * @param values[2] nepPerTokenPerBlock NEP token per liquidity token unit per block
   * @param values[3] totalTokensLocked Total liquidity token locked
   * @param values[4] totalNepLocked Total NEP locked
   * @param values[5] maxToStake Total tokens to be staked
   * @param values[6] myNepRewards Sum of NEP rewareded to the account in this farm
   * @param values[7] totalNepRewards Sum of all NEP rewarded in this farm
   */
  function getInfo(address account) external view returns (uint256[] memory values);
}


interface IPool {
  /**
   * @dev Gets the total number of NEP allocated to be distributed as reward
   */
  function _totalRewardAllocation() external view returns (uint256);

  /**
   * @dev Gets the summary of the given token farm for the gven account
   * @param token The farm token in the pool
   * @param account Account to obtain summary of
   * @param values[0] rewards Your pending rewards
   * @param values[1] staked Your liquidity token balance
   * @param values[2] nepPerTokenPerBlock NEP token per liquidity token unit per block
   * @param values[3] totalTokensLocked Total liquidity token locked
   * @param values[4] totalNepLocked Total NEP locked
   * @param values[5] maxToStake Total tokens to be staked
   * @param values[6] myNepRewards Sum of NEP rewareded to the account in this farm
   * @param values[7] totalNepRewards Sum of all NEP rewarded in this farm
   */
  function getInfo(address token, address account) external view returns (uint256[] memory values);
}


interface IBondPool {
  /**
   * @dev Gets the total number of NEP allocated to be distributed as reward
   */
  function _totalRewardAllocation() external view returns (uint256);

  /**
   * @dev Gets the bond market information information
   * @param token The token address to get the information
   * @param account Enter your account address to get the information
   * @param values[0] poolTotalNepPaired Returns the total amount of NEP paired with the given token
   * @param values[1] totalLocked Returns the total amount of the token locked/staked in this pool
   * @param values[2] releaseDate Returns the release date of the account (if any bond)
   * @param values[3] nepAmount Returns the account's active NEP reward that was bonded with the suppplied token
   * @param values[4] bondTokenAmount Returns the accounts's token amount that was bonded with NEP
   * @param values[5] liquidity Returns the account's liquidity that was created and locked in the PancakeSwap exchange
   * @param values[6] myNepRewards Returns the account's sum total NEP reward in this pool
   */
  function getInfo(address token, address account) external view returns (uint256[] memory values);
}





/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


abstract contract Recoverable is Ownable {
  /**
   * @dev Recover all Ether held by the contract to the owner.
   */
  function recoverEther() external onlyOwner {
    address owner = super.owner();
    payable(owner).transfer(address(this).balance);
  }

  /**
   * @dev Recover all BEP-20 compatible tokens sent to this address.
   * @param token BEP-20 The address of the token contract
   */
  function recoverToken(address token) external onlyOwner {
    address owner = super.owner();
    IERC20 bep20 = IERC20(token);

    uint256 balance = bep20.balanceOf(address(this));
    bep20.transfer(owner, balance);
  }
}


contract Discovery is Recoverable {
  IPancakeRouterLike public _pancakeRouter;
  IFarm public _farm;
  IPool public _pool;
  IBondPool public _bondPool;

  address public _busd;
  address public _nep;

  uint256 private constant BLOCK_IN_A_YEAR = 10512000;

  constructor(
    address pancakeRouter,
    address busd,
    address nep,
    address cakeFarm,
    address pool,
    address bondPool
  ) {
    _pancakeRouter = IPancakeRouterLike(pancakeRouter);
    _busd = busd;
    _nep = nep;
    _farm = IFarm(cakeFarm);
    _pool = IPool(pool);
    _bondPool = IBondPool(bondPool);
  }

  function setRouter(address pancakeRouter) external onlyOwner {
    require(pancakeRouter != address(0), "Invalid address");
    _pancakeRouter = IPancakeRouterLike(pancakeRouter);
  }

  function setFarm(address farm) external onlyOwner {
    require(farm != address(0), "Invalid address");
    _farm = IFarm(farm);
  }

  function setPool(address pool) external onlyOwner {
    require(pool != address(0), "Invalid address");
    _pool = IPool(pool);
  }

  function setBondPool(address bondPool) external onlyOwner {
    require(bondPool != address(0), "Invalid address");
    _bondPool = IBondPool(bondPool);
  }

  function setBUSD(address busd) external onlyOwner {
    require(busd != address(0), "Invalid address");
    _busd = busd;
  }

  function setNEP(address nep) external onlyOwner {
    require(nep != address(0), "Invalid address");
    _nep = nep;
  }

  function getTokenAmountInBUSD(address token, uint256 multiplier) public view returns (uint256) {
    if (token == _busd) {
      return multiplier;
    }

    address[] memory pair = new address[](2);

    pair[0] = token;
    pair[1] = _busd;

    uint256[] memory amounts = _pancakeRouter.getAmountsOut(multiplier, pair);
    return amounts[amounts.length - 1];
  }

  function getPairLiquidityInBUSD(
    IPancakePairLike pair,
    uint256 liquidity,
    uint256 multiplier
  ) public view returns (uint256) {
    (uint112 reserve0, uint112 reserve1, ) = pair.getReserves();
    uint256 supply = pair.totalSupply();

    if (pair.token0() == address(_busd)) {
      return (reserve0 * 2 * liquidity) / supply;
    }

    return (((reserve1 * 2 * liquidity) * multiplier) / supply) * multiplier;
  }

  function getNEPPrice(uint256 multiplier) public view returns (uint256) {
    return getTokenAmountInBUSD(address(_nep), multiplier);
  }

  function getPairAmountInBUSD(IPancakePairLike pair, uint256 multiplier) public view returns (uint256) {
    (uint112 reserve0, uint112 reserve1, ) = pair.getReserves();

    if (pair.token0() == address(_busd)) {
      return (reserve0 * 2 * multiplier) / reserve1;
    }

    if (pair.token1() == address(_busd)) {
      return (reserve1 * 2 * multiplier) / reserve0;
    }

    return 0;
  }

  function getTvl(
    address token,
    uint256 multiplier,
    uint256 totalLocked,
    uint256 poolTotalNepPaired
  ) public view returns (uint256) {
    uint256 tokenPrice = getTokenAmountInBUSD(token, multiplier);
    uint256 nepPrice = getNEPPrice(multiplier);

    return ((totalLocked * tokenPrice) / multiplier) + ((poolTotalNepPaired * nepPrice) / multiplier);
  }

  /**
   * @dev Gets the bond market information information
   * @param token The token address to get the information
   * @param account Enter your account address to get the information
   * @param values[0] poolTotalNepPaired Returns the total amount of NEP paired with the given token
   * @param values[1] totalLocked Returns the total amount of the token locked/staked in this pool
   * @param values[2] releaseDate Returns the release date of the account (if any bond)
   * @param values[3] nepAmount Returns the account's active NEP reward that was bonded with the suppplied token
   * @param values[4] bondTokenAmount Returns the accounts's token amount that was bonded with NEP
   * @param values[5] liquidity Returns the account's liquidity that was created and locked in the PancakeSwap exchange
   * @param values[6] myNepRewards Returns the account's sum total NEP reward in this pool
   */
  function getBondSummary(
    address token,
    address account,
    uint256 multiplier
  ) public view returns (uint256[] memory values) {
    values = copyArray(_bondPool.getInfo(token, account), 1);

    uint256 poolTotalNepPaired = values[0];
    uint256 totalLocked = values[1];

    uint256 tvl = getTvl(token, multiplier, totalLocked, poolTotalNepPaired);
    values[7] = tvl;
  }

  /**
   * @dev Gets the summary of the given token farm for the gven account
   * @param token The farm token in the pool
   * @param account Account to obtain summary of
   * @param isLPToken Specify if the address is an LP token
   * @param values[0] rewards Your pending rewards
   * @param values[1] staked Your liquidity token balance
   * @param values[2] nepPerTokenPerBlock NEP token per liquidity token unit per block
   * @param values[3] totalTokensLocked Total liquidity token locked
   * @param values[4] totalNepLocked Total NEP locked
   * @param values[5] maxToStake Total tokens to be staked
   * @param values[6] myNepRewards Sum of NEP rewareded to the account in this farm
   * @param values[7] totalNepRewards Sum of all NEP rewarded in this farm
   * @param values[8] tvl Total value locked
   * @param values[9] apy Annual percentage yield
   * @param values[10] tokenPrice The price of supplied token in BUSD
   */
  function getPoolSummary(
    address token,
    address account,
    bool isLPToken,
    uint256 multiplier
  ) public view returns (uint256[] memory values) {
    values = copyArray(_pool.getInfo(token, account), 3);

    uint256 nepPerTokenPerBlock = values[2];
    uint256 totalTokensLocked = values[3];
    uint256 totalNepLocked = values[4];

    uint256 tokenPrice = isLPToken ? getPairAmountInBUSD(IPancakePairLike(token), multiplier) : getTokenAmountInBUSD(token, multiplier);
    uint256 nepPrice = getNEPPrice(multiplier);

    uint256 tvl = ((totalTokensLocked * tokenPrice) / multiplier) + ((totalNepLocked * nepPrice) / multiplier);
    uint256 apy = tokenPrice > 0 ? (nepPerTokenPerBlock * BLOCK_IN_A_YEAR * nepPrice) / tokenPrice : 0;

    values[8] = tvl;
    values[9] = apy;
    values[10] = tokenPrice;
  }

  /**
   * @dev Gets the summary of the Cake Farm
   * @param token Enter CAKE token address
   * @param account Account to obtain summary of
   * @param values[0] rewards Your pending rewards
   * @param values[1] staked Your liquidity token balance
   * @param values[2] nepPerTokenPerBlock NEP token per liquidity token unit per block
   * @param values[3] totalTokensLocked Total liquidity token locked
   * @param values[4] totalNepLocked Total NEP locked
   * @param values[5] maxToStake Total tokens to be staked
   * @param values[6] myNepRewards Sum of NEP rewareded to the account in this farm
   * @param values[7] totalNepRewards Sum of all NEP rewarded in this farm
   */
  function getFarmSummary(
    address token,
    address account,
    uint256 multiplier
  ) public view returns (uint256[] memory values) {
    values = copyArray(_farm.getInfo(account), 3);

    uint256 staked = values[1];
    uint256 nepPerTokenPerBlock = values[2];
    uint256 totalNepLocked = values[4];

    uint256 tokenPrice = getTokenAmountInBUSD(token, multiplier);
    uint256 nepPrice = getNEPPrice(multiplier);

    uint256 tvl = ((staked * tokenPrice) / multiplier) + ((totalNepLocked * nepPrice) / multiplier); // TVL in BUSD
    uint256 apy = (nepPerTokenPerBlock * BLOCK_IN_A_YEAR * nepPrice) / tokenPrice; // APY

    values[8] = tvl;
    values[9] = apy;
    values[10] = tokenPrice;
  }

  function totalBurned() external view returns (uint256) {
    IERC20 nep = IERC20(_nep);

    uint256 zeroX = nep.balanceOf(0x0000000000000000000000000000000000000000);
    uint256 zeroOne = nep.balanceOf(0x0000000000000000000000000000000000000001);

    return zeroX + zeroOne;
  }

  function totalNepSupply() external view returns (uint256) {
    IERC20 nep = IERC20(_nep);

    uint256 zeroOne = nep.balanceOf(0x0000000000000000000000000000000000000001);
    uint256 totalSupply = nep.totalSupply();

    return totalSupply - zeroOne;
  }

  function totalRewardAllocation() external view returns (uint256) {
    uint256 inFarm = _farm._totalRewardAllocation();
    uint256 inPool = _pool._totalRewardAllocation();
    uint256 inBonds = _bondPool._totalRewardAllocation();

    return inFarm + inPool + inBonds;
  }

  function copyArray(uint256[] memory source, uint256 increment) private pure returns (uint256[] memory) {
    uint256[] memory copy = new uint256[](source.length + increment);

    for (uint256 i = 0; i < source.length; i += 1) {
      copy[i] = source[i];
    }

    return copy;
  }
}
