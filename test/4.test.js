
const { 
    clearData,startChain,sleep,deploy721,mint,issue,
    runFromErc721ToCosmosNft,runCaseFromCosmosToErc721,
    checkCaseOwner,checkCaseDemon,checkCaseNFT,checkCaseEvmInfo
} = require('./base/helper')

async function preRun(){

    //1.clear data
    await clearData();

    //2.start chain
    await startChain();

    await sleep(20000);

    //evm -> cosmos
    //3.deploy contract
    await deploy721();

    //4.mint
    await mint();

    //5.issue
    await issue()
}

async function runAndCheckEvm2Cosmos(){

    //5.run test case
    await runFromErc721ToCosmosNft("0x432FDd12f13F3D03a8429687db3102e65dBE3060",1,"cdemon2","");

    //6.check result
    let exceptedTitles =["owner"]
    //6.1 evm owner
    let exceptedResults = ["0xaA5faecf9acC9eA895886847fA4558dc41562Bb7"];
    await checkCaseOwner(exceptedTitles,exceptedResults);
    //6.2 cosmos demon
    exceptedTitles =["creator","data","description","id","mint_restricted","name","schema","symbol","update_restricted","uri","uri_hash"]
    exceptedResults = [
        "uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d","cData2","cDescription2","cdemon2","false",
        "cName2","cSchema2","cSymbol2","false","cUri2","uriHash2"
    ];
    await checkCaseDemon("cdemon2",exceptedTitles,exceptedResults);
    //6.3 cosmos class
    exceptedTitles =["data","id","name","owner","uri","uri_hash"]
    exceptedResults = [
        "data1","uptick1","name1","uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d","uri1","uriHash1"
    ];
    await checkCaseNFT("cdemon2","uptick1",exceptedTitles,exceptedResults);
}

async function runAndCheckCosms2Evm(){

    //cosmos -> evm
    //7.run test case
    await runCaseFromCosmosToErc721("cdemon2","uptick1","","");

    //8.check result
    let exceptedTitles =["owner"]
    //8.1 evm owner
    let exceptedResults = ["0x7c4663d780EfA75dAF623a4E79D505df8be88CDC"];
    await checkCaseOwner(exceptedTitles,exceptedResults);

    exceptedTitles =["name","uri","data","uriHash"]
    exceptedResults = ["name1","uri1","data1","uriHash1"];
    await checkCaseEvmInfo(exceptedTitles,exceptedResults);

    //8.2 cosmos demon
    exceptedTitles =["creator","data","description","id","mint_restricted","name","schema","symbol","update_restricted","uri","uri_hash"]
    exceptedResults = [
        "uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d","cData2","cDescription2","cdemon2","false",
        "cName2","cSchema2","cSymbol2","false","cUri2","uriHash2"
    ];
    await checkCaseDemon("cdemon2",exceptedTitles,exceptedResults);
    //8.3 cosmos class
    exceptedTitles =["data","id","name","owner","uri","uri_hash"]
    exceptedResults = [
        "data1","uptick1","name1","uptick14f06anu6ej0239vgdprl532cm3q4v2ahvz9w8h","uri1","uriHash1"
    ];
    await checkCaseNFT("cdemon2","uptick1",exceptedTitles,exceptedResults);

}

async function main(){

    await preRun();

    await runAndCheckEvm2Cosmos();
    await runAndCheckCosms2Evm();

}
 

main();










