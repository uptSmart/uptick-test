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
    let erc721Address = await readConfig(1,"ERC721_ADDRESS")
    console.log("erc721Address is ",erc721Address,nftId);
    let erc721Contract = await attachERC721(admin,erc721Address);

    let res = await erc721Contract.mint(admin.address,nftId);
    let recipt = await res.wait();
    if(recipt.status == 1){
        console.log("mint OK !");
    }else{
        console.log("mint failed ! ");
    }
   
}



main();

