const { ethers, upgrades,getChainId } = require('hardhat'); 
const {
    attachERC721,
    readConfig
} = require('./utils/helper')



const main = async () => {

    let gasPrice = 0x02540be400;
    let gasLimit = 0x7a1200;

    let chainId = await getChainId();
    [admin] = await ethers.getSigners()

    console.log("chainId is : " ,chainId," adddress",admin.address);
    let erc721Address = await readConfig(0,"ERC721_ADDRESS")
    console.log("erc721Address is ",erc721Address);
    let erc721Contract = await attachERC721(admin,erc721Address);

    let res = await erc721Contract.mint(admin.address);
    let recipt = await res.wait();
    if(recipt.status == 1){
        console.log("mint OK !");
    }else{
        console.log("mint failed ! ");
    }
   
}



main();

