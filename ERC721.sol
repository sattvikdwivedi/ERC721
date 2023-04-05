// SPDX-License-Identifier:MIT
pragma solidity >=0.5.0 <0.9.0;
 import "./IERC721.sol";
 import "./IERC721Receiver.sol";
 import "./utils/Address.sol";
 import "./introsecption/ERC165.sol";
 contract ERC721 is ERC165,IERC721{
     using Address for address;
     bytes4 private constant _ERC721_RECEIVED=0x150b7a02;
     bytes4 private constant _INTERFACE_ID_ERC721=0x80ac58cd;
        mapping(uint256 => address) private _tokenowners;
    mapping(address => uint256) private _ownedTokensCount;
    mapping(uint256 => address) private _tokenApprovals;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    constructor(){
        _registerInterface(_INTERFACE_ID_ERC721);
    }
    function balanceOf(address owner) public override view returns(uint){
        require(owner!=address(0));
        return _ownedTokensCount[owner];
    }
    function ownerOf(uint256 tokenId)public override view returns(address){
        address owner=_tokenowners[tokenId];    
        require(owner!=address(0));
        return owner;

    }
    function approve(address to,uint tokenId ) public override {
          address owner=ownerOf(tokenId);
          require(owner!=to);
          require(msg.sender==owner || isApprovedForAll(owner,msg.sender));
          _tokenApprovals[tokenId]=to;
          emit Approval(owner,to,tokenId);
    }
    function getApproved(uint tokenId) public override view returns(address){
        require(_exists(tokenId));
        return _tokenApprovals[tokenId];
    }
    function setApprovalForAll(address to, bool approved) public override{
        require(to!=msg.sender);
        _operatorApprovals[msg.sender][to]=approved;
        emit ApprovalForAll(msg.sender,to,approved);
    }
    function transferFrom(address from ,address to,uint tokenId) public override{
        require(_isApprovedOrOwner(msg.sender,tokenId));
        _transferFrom(from,to,tokenId);

    }
    function safeTransferFrom(address from ,address to,uint tokenId, bytes memory _data) public override{
        transferFrom(to,from,tokenId);
        require(_checkOnERC721Recieved(from,to,tokenId,_data));
    }
    function safeTransferFrom(address from,address to,uint tokenId )public override{
       safeTransferFrom(from,to,tokenId,"");
    }
    function _exists(uint tokenId)internal view returns(bool){
        address owner= _tokenowners[tokenId];
        return owner!=address(0);
    }
    function _isApprovedOrOwner(address spender,uint tokenId) public view returns(bool){
        address owner=ownerOf(tokenId);
        return(spender==owner || getApproved(tokenId)==spender|| isApprovedForAll(spender,owner));
    }
    function mint(address to,uint tokenId) internal{
        require(to!=address(0));
        require(!_exists(tokenId));
        _tokenowners[tokenId]=to;
        _ownedTokensCount[to]=_ownedTokensCount[to]+1;
        emit Transfer(address(0),to,tokenId);
    }
    function burn(address owner,uint tokenId) internal{
        require(ownerOf(tokenId)==owner);
        _clearApproval(tokenId);
        _ownedTokensCount[owner]=_ownedTokensCount[owner]-1;
        _tokenowners[tokenId]=address(0);
        emit Transfer(owner,address(0),tokenId);
    }
    function burn(uint tokenId) internal{
        burn(ownerOf(tokenId),tokenId);
    }
     function _transferFrom(address from, address to,uint tokenId) internal{
       require(from==ownerOf(tokenId));
       require(to!=address(0));
       _clearApproval(tokenId);
       _ownedTokensCount[from]=_ownedTokensCount[from]-1;
       _ownedTokensCount[to]=_ownedTokensCount[to]+1;
       _tokenowners[tokenId]=to;
       emit Transfer(from,to,tokenId);
    }
    function _checkOnERC721Recieved(address from ,address to,uint tokenId,bytes memory _data) internal returns(bool){
       if(!to.isContract()){
           return true;
       }
       bytes4 retval=IERC721Receiver(to).onERC721Received (msg.sender,from,tokenId,_data);
       return (retval==_ERC721_RECEIVED);
    }
    function _clearApproval(uint tokenId) private {
        if(_tokenApprovals[tokenId]!=address(0)){
            _tokenApprovals[tokenId]=address(0);
        }
    }
    function isApprovedForAll(address spender,address operator) public override view returns(bool){
            return _operatorApprovals[spender][operator];
    }




 }  