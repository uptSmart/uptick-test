
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

    dErc721Contract = await deployERC721("Cat","Cat","https://Cat.com");
    console.log("cat contract address : " + dErc721Contract.address);


    await writeConfig(0,0,"ERC721_ADDRESS",dErc721Contract.address);

}



main();

