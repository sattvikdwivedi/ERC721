// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ERC721.sol";
import "./IERC721Metadata.sol";
import "./introsecption/ERC165.sol";
contract ERC721Metadata is ERC165,ERC721,IERC721Metadata{
    string private _name;
    string private _symbol;
    mapping(uint=>string) private _tokenURI;
    bytes4 private constant _INTERFACE_ID_ERC721METADATA=0x5b5e139f;
    constructor(string memory name,string memory symbol){
       _name=name;
       _symbol=symbol;
       _registerInterface(_INTERFACE_ID_ERC721METADATA);
    }
    function name() external view override returns(string memory){
        return _name;
    }
     function symbol() external view override returns(string memory){
        return _symbol;
    }
    function tokenURI(uint tokenId) external view override returns(string memory){
    require(_exists(tokenId));
    return _tokenURI[tokenId];
    }
    function setTokenURI(uint tokenId,string memory uri) external {
        require(_exists(tokenId));
        _tokenURI[tokenId]=uri;
    } 
    

}
