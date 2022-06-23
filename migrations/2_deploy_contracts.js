var WeCoin = artifacts.require("./WeCoin.sol");

module.exports = function (deployer) {
  deployer.deploy(WeCoin);
}