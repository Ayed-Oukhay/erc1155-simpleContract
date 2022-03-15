// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/interfaces/IERC2981.sol";

contract Pokemons is ERC1155, IERC2981, Ownable {

    string public name;
    string public symbol;

    mapping(uint => string) public tokenURI;

    uint96 royaltyFees; //This variable will contain the royalty fees in Bips using this format exp: 250 meaning 2.5%
    string public contractURI; //This variable will allow us to specify the uri for our COLLECTION metadata
    address royaltyReceiver; //This variable allows us to specify the address of the receiver of the royalties

    //https://gateway.pinata.cloud/ipfs/Qmcj8W68bpKhvymQZad3U4cfPFz2GCY9nPXtZWB4KrfvQ1/{id}.json

    constructor(uint96 _royaltyFees, string memory _contractURI) ERC1155(""){
        name = "Pokemons"; //contract name
        symbol = "POK"; //contract symbol
        royaltyReceiver = msg.sender; //royalty receiver address
        royaltyFees = _royaltyFees; //royalty amount (exp: 250)
        contractURI = _contractURI; //COLLECTION metadata uri
    }

    // -------------- Creating Tokens ----------------------------
    function mint(address _to, uint256 _id, uint256 _amount, bytes memory data) public virtual { 
        //require(hasRole(MINTER_ROLE, _msgSender()), "ERC1155PresetMinterPauser: must have minter role to mint");
        _mint(_to, _id, _amount, data);
    }
    // ------------------------------------------------------------

    // ------------------- Setting token Metadata --------------------
    function setURI(uint _id, string memory _uri) external onlyOwner { 
        tokenURI[_id] = _uri;
        emit URI(_uri, _id);
    }

    function uri(uint _id) public override view returns (string memory) {
        return tokenURI[_id];
    }
    // ------------------------------------------------------------

    // ------------------- Setting Royalty infos --------------------
    function royaltyInfo(uint256 _tokenId, uint256 _salePrice) external override view returns (address receiver, uint256 royaltyAmount) {
        return (royaltyReceiver, calculateRoyalty(_salePrice));
    }

    function calculateRoyalty(uint256 _salePrice) view public returns (uint256){ //Calculating royalties
        return (_salePrice / 10000) * royaltyFees; // because 100% royalties == 10000 Bips
    }

    function setRoyaltyInfo (address _receiver, uint96 _royaltyFees) public onlyOwner{
        royaltyReceiver = _receiver;
        royaltyFees = _royaltyFees;
    }
    // ------------------------------------------------------------

    // ------------------- Setting contract uri (if we need to change it again) --------------------
    function setContractURI(string calldata _contractURI) public onlyOwner {
        contractURI = _contractURI;
    }
    // ------------------------------------------------------------
}