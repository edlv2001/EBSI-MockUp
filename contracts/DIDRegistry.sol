// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DIDRegistry {

    mapping(string => string) private dids;
    string[] private didList;

    event DIDRegistered(string indexed did, string document);

    function registerDID(string memory did, string memory document) public {
        require(bytes(did).length == 32, "DID must be 32 characters long.");
        
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
}
