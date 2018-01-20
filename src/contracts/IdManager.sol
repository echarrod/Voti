pragma solidity ^0.4.18;

import "./Ownable.sol";

contract IdManager is Ownable {

    struct ID {
        bool exists;
        uint rememberMeId;
        bytes32 name;
        bytes32 region;
    }

    mapping(address => ID) public idMap;

    // Entity that controls Id verification would instantiate the contract - therefore becoming "owner"
    function IdManager() public {}

    // "onlyOwner" modifier only allows the controlling entity to register an id
    function registerId(address _address, uint _rememberMeId, bytes32 _name, bytes32 _region) public onlyOwner {
        require(!idMap[_address].exists);
        ID storage theId = idMap[_address];
        theId.exists = true;
        theId.rememberMeId = _rememberMeId;
        theId.name = _name;
        theId.region = _region;
    }

    function removeId(address _address) public onlyOwner { // test this!
        delete idMap[_address];
    }

    function isValidId(address _address) public view returns (bool) {
        return idMap[_address].exists;
    }
}