// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrustedSchemaRegistry {
    
    mapping(string => string) private schemas;

    event SchemaRegistered(string indexed schemaId, string schemaJson);

    function registerSchema(string memory schemaId, string memory schemaJson) public {
        require(bytes(schemaId).length > 0, "Schema ID must not be empty.");
        require(bytes(schemaJson).length > 0, "Schema JSON must not be empty.");

        schemas[schemaId] = schemaJson;
        emit SchemaRegistered(schemaId, schemaJson);
    }

    function getSchema(string memory schemaId) public view returns (string memory schemaJson) {
        string storage storedSchema = schemas[schemaId];
        require(bytes(storedSchema).length > 0, "Schema ID not found.");
        return storedSchema;
    }
}
