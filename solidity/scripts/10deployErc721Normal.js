
const { ethers } = require('hardhat')
const { utils} = require('ethers')
const {
    deployERC721,
    writeConfig
} = require('./utils/helper')

const main = async () => {

    let chainId = await getChainId();
    [admin] = await ethers.getSigners()

    console.log("chainId is : " ,chainId," adddress",admin.address);

    dErc721Contract = await deployERC721("ERC721Normal","ERC721Normal","https://Normal.com",admin);
    console.log("ERC721Normal contract address : " + dErc721Contract.address);


    await writeConfig(1,1,"ERC721_ADDRESS",dErc721Contract.address);

}



main();

