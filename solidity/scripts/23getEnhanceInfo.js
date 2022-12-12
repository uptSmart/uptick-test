const { ethers, upgrades,getChainId } = require('hardhat'); 
const {
    attachERC721Uptick,
    readConfig
} = require('./utils/helper')


const main = async () => {

    let nftId = 1;

    let chainId = await getChainId();
    [admin] = await ethers.getSigners()

    console.log("chainId is : " ,chainId," adddress",admin.address);
    let erc721Address = await readConfig(2,"ERC721_ADDRESS")
    console.log("erc721Address is ",erc721Address);
    let erc721Contract = await attachERC721Uptick(admin,erc721Address);

    let res = await erc721Contract.getNFTEnhanceInfo(nftId);
    // console.log(Object.keys(res));
    let len = Object.keys(res).length
    let keys = Object.keys(res);

    for(var i = len/2 ; i < len ;i ++){
        console.log(keys[i] + " : " + res[keys[i]] );
    }

    // console.log("erc721 %d ower is % ",nftId,res);
   
}


main();

