
const { 
    clearData,startChain,sleep,deploy721Normal,mintNormal,
    runFromErc721ToCosmosNft,runCaseFromCosmosToErc721,
    checkCaseOwner,checkCaseDemon,checkCaseNFT
} = require('./base/helper')

async function preRun(){

    //1.clear data
    await clearData();

    //2.start chain
    await startChain();

    await sleep(20000);

    //evm -> cosmos
    //3.deploy deploy721Normal
    await deploy721Normal();

    await sleep(2000);
    //4.mintNormal
    await mintNormal();

}

async function runAndCheckEvm2Cosmos(){

    //5.run test case
    await runFromErc721ToCosmosNft("0x432FDd12f13F3D03a8429687db3102e65dBE3060",1,"","");

    //6.check result
    let exceptedTitles =["owner"]
    //6.1 evm owner
    let exceptedResults = ["0xaA5faecf9acC9eA895886847fA4558dc41562Bb7"];
    await checkCaseOwner(exceptedTitles,exceptedResults);
    //6.2 cosmos demon
    exceptedTitles =["creator","data","description","id","mint_restricted","name","schema","symbol","update_restricted","uri","uri_hash"]
    exceptedResults = [
        "uptick14f06anu6ej0239vgdprl532cm3q4v2ahvz9w8h","\"\"","\"\"","uptick-432FDd12f13F3D03a8429687db3102e65dBE3060","false",
        "ERC721Normal","\"\"","ERC721Normal","false","\"\"","\"\""
    ];
    await checkCaseDemon("uptick-432FDd12f13F3D03a8429687db3102e65dBE3060",exceptedTitles,exceptedResults);
    //6.3 cosmos class
    exceptedTitles =["data","id","name","owner","uri","uri_hash"]
    exceptedResults = [
        "\"\"","uptick1","\"\"","uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d","\"\"","\"\""
    ];
    await checkCaseNFT("uptick-432FDd12f13F3D03a8429687db3102e65dBE3060","uptick1",exceptedTitles,exceptedResults);

}

async function runAndCheckCosmos2Evm(){

    //cosmos -> evm
    //7.run test case
    await runCaseFromCosmosToErc721("uptick-432FDd12f13F3D03a8429687db3102e65dBE3060","uptick1","","","");

    //8.check result
    let exceptedTitles =["owner"]
    //8.1 evm owner
    let exceptedResults = ["0x7c4663d780EfA75dAF623a4E79D505df8be88CDC"];
    await checkCaseOwner(exceptedTitles,exceptedResults);
    //8.2 cosmos demon
    exceptedTitles =["creator","data","description","id","mint_restricted","name","schema","symbol","update_restricted","uri","uri_hash"]
    exceptedResults = [
        "uptick14f06anu6ej0239vgdprl532cm3q4v2ahvz9w8h","\"\"","\"\"","uptick-432FDd12f13F3D03a8429687db3102e65dBE3060","false",
        "ERC721Normal","\"\"","ERC721Normal","false","\"\"","\"\""
    ];
    await checkCaseDemon("uptick-432FDd12f13F3D03a8429687db3102e65dBE3060",exceptedTitles,exceptedResults);
    //8.3 cosmos class
    exceptedTitles =["data","id","name","owner","uri","uri_hash"]
    exceptedResults = [
        "\"\"","uptick1","\"\"","uptick14f06anu6ej0239vgdprl532cm3q4v2ahvz9w8h","\"\"","\"\""
    ];
    await checkCaseNFT("uptick-432FDd12f13F3D03a8429687db3102e65dBE3060","uptick1",exceptedTitles,exceptedResults);

}

async function main(){

    await preRun();
    await runAndCheckEvm2Cosmos();
    await runAndCheckCosmos2Evm();

}
 

main();










