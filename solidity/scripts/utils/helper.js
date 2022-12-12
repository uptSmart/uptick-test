const fs = require('fs')
const path = require('path')
const { ethers,upgrades } = require("hardhat");

const ADDRESS_ZERO = '0x0000000000000000000000000000000000000000';


const writeConfig = async (fromFile,toFile,key, value) => {

    let fromFullFile = getPath(fromFile);
    let contentText = fs.readFileSync(fromFullFile,'utf-8');
    let data = JSON.parse(contentText);
    data[key] = value;

    let toFullFile = getPath(toFile);
    fs.writeFileSync(toFullFile, JSON.stringify(data, null, 4), { encoding: 'utf8' }, err => {})

}

const readConfig = async (fromFile,key) => {

    let fromFullFile = getPath(fromFile);
    let contentText = fs.readFileSync(fromFullFile,'utf-8');
    let data = JSON.parse(contentText);
   
    return data[key];

}

function getPath(fromFile){
    return  path.resolve(__dirname, '../config/' + fromFile + '.json');
}

const log = (msg) => console.log(`${msg}`)

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

//
let gasPrice = 0x02540be400;
let gasLimit = 0x7a1200;

async function deployERC721(name,symbol,baseUri,account){

    //constructor(string memory _name, string memory _symbol,uint256 amount,uint8 decimals) 
    const dErc721Factory = await ethers.getContractFactory("ERC721Normal",account);
    const dErc721Contract = await dErc721Factory.deploy(
        name,symbol,baseUri,
        { gasPrice: gasPrice, gasLimit: gasLimit}
    )
    return dErc721Contract;

}

async function deployERC721Uptick(name,symbol,baseUri,data,description,mint_restricted,schema,update_restricted,uri_hash,account){

    //constructor(string memory _name, string memory _symbol,uint256 amount,uint8 decimals) 
    const dErc721Factory = await ethers.getContractFactory("ERC721Uptick",account);
    const dErc721Contract = await dErc721Factory.deploy(
        name,symbol,baseUri,data,description,mint_restricted,schema,update_restricted,uri_hash,
        { gasPrice: gasPrice, gasLimit: gasLimit}
    )
    return dErc721Contract;

}

async function attachERC721(account,address){

    const dErc721Factory = await ethers.getContractFactory("ERC721Normal",account);
    const dErc721Contract = await dErc721Factory.attach(
        address,
        { gasPrice: gasPrice, gasLimit: gasLimit}
    )
    return dErc721Contract;

}

async function attachERC721Uptick(account,address){

    const dErc721Factory = await ethers.getContractFactory("ERC721Uptick",account);
    const dErc721Contract = await dErc721Factory.attach(
        address,
        { gasPrice: gasPrice, gasLimit: gasLimit}
    )
    return dErc721Contract;

}

async function deployErc1155Tradable(name,symbol,uri,proxyRegistryAddress,account){

    const tradableFactory = await ethers.getContractFactory("ERC1155Tradable",account);
    const tradableContract = await tradableFactory.deploy(
        name,symbol,uri,proxyRegistryAddress,
        { gasPrice: gasPrice, gasLimit: gasLimit}
    )
    return tradableContract;

}

async function attachErc1155Tradable(address,account){

    const tradableFactory = await ethers.getContractFactory("ERC1155Tradable",account);
    const tradableContract = await tradableFactory.attach(
        address,{ gasPrice: gasPrice, gasLimit: gasLimit}
    )
    return tradableContract;

}


async function deployService(name,token20Address,token1155Address,version,account){


    const serviceFactory = await ethers.getContractFactory(name,account);
    const initName = "__" + name + "_init"
    const serviceContract = await upgrades.deployProxy(
        serviceFactory,
        [
            name,token20Address,token1155Address,version
        ],
        {
            initializer: initName,
            unsafeAllowLinkedLibraries: true,
        },
        { gasPrice: gasPrice, gasLimit: gasLimit}
    );
    return serviceContract;

}

async function deployPowerPool(name,token20Address,version,account){


    const powerPoolFactory = await ethers.getContractFactory(name,account);
    const initName = "__" + name + "_init"
    const powerPoolContract = await upgrades.deployProxy(
        powerPoolFactory,
        [
            token20Address,version
        ],
        {
            initializer: initName,
            unsafeAllowLinkedLibraries: true,
        },
        { gasPrice: gasPrice, gasLimit: gasLimit}
    );
    return powerPoolContract;

}




const {
    PLANET_PARAM,
    TOOL_PARAM
} = require("./const")
const { utils } = require('ethers')

async function setup(admin){

    let amount = utils.parseEther("1000");
    dmcnContract = await deployDMCN("DMCN","DMCN",amount,18,admin);
    
    //2.deploy planet 
    planetNft = await deployErc1155Tradable(
                                    PLANET_PARAM.NAME,
                                    PLANET_PARAM.SYMBOL,
                                    PLANET_PARAM.BASE_URI,
                                    ADDRESS_ZERO,
                                    admin);
    
    //3.deploy element 
    toolNft = await deployErc1155Tradable(
                                    TOOL_PARAM.NAME,
                                    TOOL_PARAM.SYMBOL,
                                    TOOL_PARAM.BASE_URI,
                                    ADDRESS_ZERO,
                                    admin);
    
    //4.deploy planet service
    //async function deployService(name,token20Address,token1155Address,version,account){
    planetService = await deployService(
                                // "BaseService",
                                "PlanetService",
                                dmcnContract.address,
                                planetNft.address,
                                "v1.0.0",
                                admin);
    await planetNft.setPlatformAddress(planetService.address);

    toolService = await deployService(
                                "ToolService",
                                dmcnContract.address,
                                toolNft.address,
                                "v1.0.0",
                                admin);
    await toolNft.setPlatformAddress(toolService.address);


    powerPool = await deployPowerPool(
                                "PowerPool",
                                dmcnContract.address,
                                "v1.0.0",
                                admin);

    var Web3 = require('web3');
    var provider = 'https://data-seed-prebsc-1-s1.binance.org:8545';
    var web3Provider = new Web3.providers.HttpProvider(provider);
    web3 = new Web3(web3Provider);

    return {
        dmcnContract,planetNft,toolNft,planetService,toolService,powerPool,web3
    }
}

module.exports = {
    ADDRESS_ZERO,

    writeConfig,
    readConfig, 
    sleep,
    log,

    deployERC721,
    attachERC721,

    deployERC721Uptick,
    attachERC721Uptick,


    deployErc1155Tradable,
    attachErc1155Tradable,
    deployService,
    deployPowerPool,
    setup

}