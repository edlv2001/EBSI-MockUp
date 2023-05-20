// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DIDRegistry {

    mapping(string => string) private dids;
    string[] private didList;

    event DIDRegistered(string indexed did, string document);

    function registerDID(string memory did, string memory document) public {
        require(bytes(did).length == 32, "DID must be 32 characters long.");
        require(keccak256(abi.encodePacked(substring(did, 0, 9))) == keccak256("did:ebsi:"), "DID must start with 'did:ebsi:'.");
        
        dids[did] = document;
        didList.push(did);
        emit DIDRegistered(did, document);
    }

    function searchDIDDocument(string memory did) public view returns (string memory document) {
        string storage didDocument = dids[did];
        require(bytes(didDocument).length > 0, "DID not found.");
        return didDocument;
    }

    function getAllDIDs() public view returns (string[] memory) {
        return didList;
    }

    function substring(string memory _base, uint256 _begin, uint256 _length) internal pure returns (string memory) {
        bytes memory _baseBytes = bytes(_base);
        uint256 _end = _begin + _length;
        require(_end <= _baseBytes.length, "The end index must be within the bounds of the string.");

        bytes memory _tempBytes = new bytes(_length);
        for (uint256 i = 0; i < _length; i++) {
            _tempBytes[i] = _baseBytes[_begin + i];
        }
        return string(_tempBytes);
    }
}
