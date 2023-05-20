var DIDRegistry = artifacts.require("DIDRegistry");
var TrustedIssuerRegistry = artifacts.require("TrustedIssuerRegistry");
var TrustedSchemaRegistry = artifacts.require("TrustedSchemaRegistry");


module.exports = function (deployer) {
  deployer.deploy(DIDRegistry);
  deployer.deploy(TrustedIssuerRegistry);
  deployer.deploy(TrustedSchemaRegistry);
};
