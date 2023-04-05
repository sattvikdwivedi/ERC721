// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721.sol";
import "./IERC721Enumerable.sol";


abstract contract ERC721Enumerable is ERC721, IERC721Enumerable {
    mapping(address=>uint[]) private _ownedTokens;
    mapping(uint =>uint) private _ownedTokensIndex;
    uint[]private _allTokens;
    bytes4 private constant _INTERFACE_ID_ERC721ENUMERABLE= 0x780e9d63;
    constructor(){
        _registerInterface(_INTERFACE_ID_ERC721ENUMERABLE);
    }
    function tokenOfOwnerByIndex(address owner,uint index) public view override returns(uint){
        return  _ownedTokens[owner][index];
    }
    function totalSupply() public view override returns(uint){
        return _allTokens.length;
    }
    function tokenByIndex(uint tokenId) public view override returns(uint){
        return _ownedTokensIndex[tokenId];
    }


}