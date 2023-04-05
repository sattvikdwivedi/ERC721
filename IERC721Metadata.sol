// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC721.sol";

abstract contract  IERC721Metadata is IERC721 {
  
    function name() external view virtual returns (string memory);
    function symbol() external view virtual returns (string memory);
    function tokenURI(uint256 tokenId) external view  virtual returns (string memory);
}