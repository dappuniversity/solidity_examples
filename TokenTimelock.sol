pragma solidity ^0.5.1;

import "./Token.sol";

contract TokenTimelock {

  Token public token;
  address public beneficiary;
  uint256 public releaseTime;

  constructor(
    Token _token,
    address _beneficiary,
    uint256 _releaseTime
  )
    public
  {
    require(_releaseTime > block.timestamp);
    token = _token;
    beneficiary = _beneficiary;
    releaseTime = _releaseTime;
  }

  function release() public {
    require(block.timestamp >= releaseTime);

    uint256 amount = token.balanceOf(address(this));
    require(amount > 0);

    token.transfer(beneficiary, amount);
  }
}
