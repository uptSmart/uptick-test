
const { ethers } = require('hardhat')
const { utils} = require('ethers')
const {
    deployERC721Uptick,
    writeConfig
} = require('./utils/helper')

const main = async () => {

    let chainId = await getChainId();
    [admin] = await ethers.getSigners()

    console.log("chainId is : " ,chainId," adddress",admin.address);

    dErc721Contract = await deployERC721Uptick(
            "ERC721Uptick",
            "EUPT",
            "cUri1",
            "cData1",
            "cDescription1",
            false,
            "cSchema1",
            false,
            "uriHash1",
            admin
        );
    console.log("ERC721Uptick contract address : " + dErc721Contract.address);
    await writeConfig(2,2,"ERC721_ADDRESS",dErc721Contract.address);

}



main();

