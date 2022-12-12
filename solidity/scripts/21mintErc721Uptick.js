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
    console.log("erc721Address is ",erc721Address,nftId);
    let erc721Contract = await attachERC721Uptick(admin,erc721Address);

    // function mintEnhance(address to, uint256 id,
    // string memory name,string memory uri,string memory data,string memory uriHash) public virtual {
    let res = await erc721Contract.mintEnhance(
        admin.address,
        nftId,
        "name"+nftId,
        "uri"+nftId,
        "data"+nftId,
        "uriHash"+nftId
    );
    
    let recipt = await res.wait();
    if(recipt.status == 1){
        console.log("mint OK !");
    }else{
        console.log("mint failed ! ");
    }
   
}



main();

