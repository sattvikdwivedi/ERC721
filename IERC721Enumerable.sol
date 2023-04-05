// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC721/extensions/IERC721Enumerable.sol)

pragma solidity ^0.8.0;

import "../IERC721.sol";
abstract contract  IERC721Enumerable is IERC721 {
  
    function totalSupply() public view virtual returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) public view  virtual returns (uint256);
    function tokenByIndex(uint256 index) public view virtual returns (uint256);
}   