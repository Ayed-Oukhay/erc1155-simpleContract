// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Pokemons is ERC1155, Ownable {

    string public name;
    string public symbol;
    /*uint256 public constant CHARIZARD = 0;
    uint256 public constant FLAREON = 1;
    uint256 public constant KAIMINUS = 2;
    uint256 public constant PIKACHU = 3;*/

    mapping(uint => string) public tokenURI;


    //https://gateway.pinata.cloud/ipfs/Qmcj8W68bpKhvymQZad3U4cfPFz2GCY9nPXtZWB4KrfvQ1/{id}.json
    constructor() ERC1155(""){
        /*_mint(msg.sender, CHARIZARD, 50, "");
        _mint(msg.sender, PIKACHU, 50, "");
        _mint(msg.sender, KAIMINUS, 50, "");
        _mint(msg.sender, FLAREON, 50, "");*/
        name = "Pokemons";
        symbol = "POK";
    }

    function mint(address _to, uint256 _id, uint256 _amount, bytes memory data) public virtual {
        //require(hasRole(MINTER_ROLE, _msgSender()), "ERC1155PresetMinterPauser: must have minter role to mint");
        _mint(_to, _id, _amount, data);
    }

    function setURI(uint _id, string memory _uri) external onlyOwner {
        tokenURI[_id] = _uri;
        emit URI(_uri, _id);
    }

    function uri(uint _id) public override view returns (string memory) {
        return tokenURI[_id];
    }

    /*function uri(string memory newuri, uint256 _tokenId) override public view returns (string memory){
        return string( abi.encodePacked(
            newuri,
            Strings.toString(_tokenId),
            ".json"
        )
    );
    }*/

    /*function setTokenUri(uint256 _tokenId, string memory uri) public onlyOwner {
        require(bytes(_uris[_tokenId]).length == 0, "Cannot set uri twice");
        _uris[_tokenId] = uri;
    }*/

    /*function contractURI(string memory _newuri) public pure returns (string memory) {
        //return _newuri;
        return "https://gateway.pinata.cloud/ipfs/QmU6KBycbAqgjTkgUyDx6nA5ezksmKvxGTNzQh8uPbqDTY";
    }*/

}