// SPDX-License-Identifier:MIT
pragma solidity >=0.5.0 <0.9.0;
import "./IERC165.sol";
    contract ERC165 is IERC165{
        bytes4 private  constant  _INTERFACE_ID_ERC165=0x01ffc9a7;
        mapping (bytes4=>bool) private _supportedInterfaces; 
        constructor(){
            _registerInterface(_INTERFACE_ID_ERC165);
        }
        function _registerInterface( bytes4 interfaceId) internal{
            require(interfaceId!=0xffffffff);
            _supportedInterfaces[interfaceId]=true;
        }
        function supportsInterface(bytes4 interfaceId) external  override view returns(bool){
            return _supportedInterfaces[interfaceId];
        }

    }