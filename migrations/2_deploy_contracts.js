// var ConvertLib = artifacts.require("./ConvertLib.sol");
// var MetaCoin = artifacts.require("./MetaCoin.sol");
const Voting = artifacts.require('./Voting.sol')

module.exports = function(deployer) {
  deployer.deploy(Voting, ['Rama', 'Nick', 'Jose'], { gas: 6700000 })
  // deployer.deploy(ConvertLib);
  // deployer.link(ConvertLib, MetaCoin);
  // deployer.deploy(MetaCoin);
};
