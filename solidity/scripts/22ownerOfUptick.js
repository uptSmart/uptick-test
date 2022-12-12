const { ethers, upgrades,getChainId } = require('hardhat'); 
const {
    attachERC721,
    readConfig
} = require('./utils/helper')


const main = async () => {

    let nftId = 1;

    let chainId = await getChainId();
    [admin] = await ethers.getSigners()
    console.log("chainId is : " ,chainId," adddress",admin.address);
    let erc721Address = await readConfig(2,"ERC721_ADDRESS")
    console.log("erc721Address is ",erc721Address);
    let erc721Contract = await attachERC721(admin,erc721Address);

    let res = await erc721Contract.ownerOf(nftId);
    console.log("owner:",res);
   
}



main();

