require('@nomiclabs/hardhat-ethers')
require('@nomiclabs/hardhat-waffle')
require('@openzeppelin/hardhat-upgrades')
require('hardhat-deploy')

module.exports = {
  networks: {

    //0x7c4663d780EfA75dAF623a4E79D505df8be88CDC
    //0xa831771c99e1efa52eb89dc22d65b814959c198dba1dcbf35e48c1fc0cce4f26
    local: {
      url: `http://127.0.0.1:8545/`,
      accounts: [
        "0xa831771c99e1efa52eb89dc22d65b814959c198dba1dcbf35e48c1fc0cce4f26"
      ]
    },

    //lrc004web
    bsc: {
      url: `https://data-seed-prebsc-1-s1.binance.org:8545/`,
      accounts: [
        "0xa16542516a3e32598cc2f5ce6a11977fc5b267d8c44d001bd721da67ad317d5c",
        "0x1dce924bdebd3485eaf9663c5a5c134bc73d33cbf704ac551a1a02395b8ebcf2",
        "0x78cdc272d0599ff0b2962cc0c4aad5d93474d497a7c4974a9d53523e217e8609",
        "0xbe0707249333d1f785e4f15c238f60cc393a2c3b8fef85df8384a105057240b7"
      ]
    },


    poly: {
      url: `https://rpc-mumbai.maticvigil.com/`,
      accounts: [
        "0xc03b0a988e2e18794f2f0e881d7ffcd340d583f63c1be078426ae09ddbdec9f5",
        "0x54e6e01600b66af71b9827429ff32599383d7694684bc09e26c3b13d95980650",
        "0xcb93f47f4ae6e2ee722517f3a2d3e7f55a5074f430c9860bcfe1d6d172492ed0",
        "0x06f8fb3c6251f0491e2e7abc40f33ae601eaeeb3de444f77d5a5774149ff22a2",
        "0x64cbfcd7052f3ce2e1160e73370fd4f5e8a087d749d687c2695a92e9a6fa6ed8",
      ]
    },
    

    hardhat: {
      chainId:100,
      accounts: [
        {privateKey:"0xc03b0a988e2e18794f2f0e881d7ffcd340d583f63c1be078426ae09ddbdec9f5",balance:"10000000000000000000000"},
        {privateKey:"0x54e6e01600b66af71b9827429ff32599383d7694684bc09e26c3b13d95980650",balance:"10000000000000000000000"},
        {privateKey:"0xcb93f47f4ae6e2ee722517f3a2d3e7f55a5074f430c9860bcfe1d6d172492ed0",balance:"10000000000000000000000"},
        {privateKey:"0x06f8fb3c6251f0491e2e7abc40f33ae601eaeeb3de444f77d5a5774149ff22a2",balance:"10000000000000000000000"},
        {privateKey:"0x64cbfcd7052f3ce2e1160e73370fd4f5e8a087d749d687c2695a92e9a6fa6ed8",balance:"10000000000000000000000"}
      ]
    }

  },
  solidity: '0.8.0',
  namedAccounts: {
    deployer: 0
  },
}
