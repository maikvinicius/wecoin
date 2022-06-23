const WeCoin = artifacts.require("WeCoin");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("WeCoin", function (accounts) {
  it("should assert true", async function () {
    await WeCoin.deployed();
    return assert.isTrue(true);
  });
  it("should wallet init with 1000", async function () {
    const instance = await WeCoin.deployed();
    const totalSupply = await instance.totalSupply();

    assert.equal(totalSupply.toNumber(), 1000);
  });
  it("should tranfer coins to another account", async function () {
    const instance = await WeCoin.deployed();
    const sender = accounts[0];
    const receiver = accounts[1];
    const amount = 10;

    const senderBalanceOld = await instance.balanceOf(sender);

    await instance.transfer(receiver, amount);

    const senderBalance = await instance.balanceOf(sender);

    assert.equal(senderBalanceOld.toNumber() - amount, senderBalance.toNumber());
  });
});
