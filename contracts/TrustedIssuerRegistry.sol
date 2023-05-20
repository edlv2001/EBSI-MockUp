// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrustedIssuerRegistry {

    mapping(string => string[]) private trustedIssuers;

    event TrustedIssuerRegistered(string indexed primaryDID, string validatorDID);

    function registerTrustedIssuer(string memory primaryDID, string memory validatorDID) public {
        require(bytes(primaryDID).length > 0, "Primary DID must not be empty.");

        bool alreadyAdded;
        if (bytes(validatorDID).length == 0) {
            validatorDID = "0";
        }

        // Comprueba si el validador ya está en la lista de validadores del DID
        for (uint256 i = 0; i < trustedIssuers[primaryDID].length; i++) {
            if (keccak256(abi.encodePacked(trustedIssuers[primaryDID][i])) == keccak256(abi.encodePacked(validatorDID))) {
                alreadyAdded = true;
                break;
            }
        }

        // Si el validador no está en la lista, añádelo
        if (!alreadyAdded) {
            trustedIssuers[primaryDID].push(validatorDID);
            emit TrustedIssuerRegistered(primaryDID, validatorDID);
        }
    }

    function getValidators(string memory primaryDID) public view returns (string[] memory validators) {
        string[] storage validatorsList = trustedIssuers[primaryDID];
        require(validatorsList.length > 0, "Primary DID not found.");
        return validatorsList;
    }
}
