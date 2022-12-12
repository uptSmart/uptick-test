const { ethers, upgrades,getChainId } = require('hardhat'); 
const {
    attachERC721,
    readConfig
} = require('./utils/helper')



const main = async () => {

    let chainId = await getChainId();
    [admin] = await ethers.getSigners()

    console.log("chainId is : " ,chainId," adddress",admin.address);
    let erc721Address = await readConfig(0,"ERC721_ADDRESS")
    console.log("erc721Address is ",erc721Address);
    let erc721Contract = await attachERC721(admin,erc721Address);

    let tokenId = 10;
    let res = await erc721Contract.ownerOf(tokenId);
    console.log("erc721 %d ower is %s ",tokenId,res);
   
}



main();

