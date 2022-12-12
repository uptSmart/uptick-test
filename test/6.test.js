
const { 
    clearData,startChain,sleep,deploy721,mint,
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
    //3.deploy contract
    await deploy721();

    await sleep(2000);
    //4.mint
    await mint();

}

async function runAndCheckEvm2Cosmos(){

    //5.run test case
    await runFromErc721ToCosmosNft("0x432FDd12f13F3D03a8429687db3102e65dBE3060",1,"","","uptick1ehh5503n2rhpz8evfqpsa62kfqc58c5g02kjhd");

    //6.check result
    let exceptedTitles =["owner"]
    //6.1 evm owner
    let exceptedResults = ["0xaA5faecf9acC9eA895886847fA4558dc41562Bb7"];
    await checkCaseOwner(exceptedTitles,exceptedResults);
    //6.2 cosmos demon
    exceptedTitles =["creator","data","description","id","mint_restricted","name","schema","symbol","update_restricted","uri","uri_hash"]
    exceptedResults = [
        "uptick14f06anu6ej0239vgdprl532cm3q4v2ahvz9w8h","cData1","cDescription1","uptick-432FDd12f13F3D03a8429687db3102e65dBE3060","false",
        "ERC721Uptick","cSchema1","EUPT","false","cUri1","uriHash1"
    ];
    await checkCaseDemon("uptick-432FDd12f13F3D03a8429687db3102e65dBE3060",exceptedTitles,exceptedResults);
    //6.3 cosmos class
    exceptedTitles =["data","id","name","owner","uri","uri_hash"]
    exceptedResults = [
        "data1","uptick1","name1","uptick1ehh5503n2rhpz8evfqpsa62kfqc58c5g02kjhd","uri1","uriHash1"
    ];
    await checkCaseNFT("uptick-432FDd12f13F3D03a8429687db3102e65dBE3060","uptick1",exceptedTitles,exceptedResults);

}

async function runAndCheckCosmos2Evm(){

    //cosmos -> evm
    //7.run test case
    await runCaseFromCosmosToErc721("uptick-432FDd12f13F3D03a8429687db3102e65dBE3060","uptick1","","","0x41eA6aD88bbf4E22686386783e7817bB7E82c1ed","uptick1ehh5503n2rhpz8evfqpsa62kfqc58c5g02kjhd");

    //8.check result
    let exceptedTitles =["owner"]
    //8.1 evm owner
    let exceptedResults = ["0x41eA6aD88bbf4E22686386783e7817bB7E82c1ed"];
    await checkCaseOwner(exceptedTitles,exceptedResults);
    //8.2 cosmos demon
    exceptedTitles =["creator","data","description","id","mint_restricted","name","schema","symbol","update_restricted","uri","uri_hash"]
    exceptedResults = [
        "uptick14f06anu6ej0239vgdprl532cm3q4v2ahvz9w8h","cData1","cDescription1","uptick-432FDd12f13F3D03a8429687db3102e65dBE3060","false",
        "ERC721Uptick","cSchema1","EUPT","false","cUri1","uriHash1"
    ];
    await checkCaseDemon("uptick-432FDd12f13F3D03a8429687db3102e65dBE3060",exceptedTitles,exceptedResults);
    //8.3 cosmos class
    exceptedTitles =["data","id","name","owner","uri","uri_hash"]
    exceptedResults = [
        "data1","uptick1","name1","uptick14f06anu6ej0239vgdprl532cm3q4v2ahvz9w8h","uri1","uriHash1"
    ];
    await checkCaseNFT("uptick-432FDd12f13F3D03a8429687db3102e65dBE3060","uptick1",exceptedTitles,exceptedResults);

}

async function main(){

    await preRun();
    await runAndCheckEvm2Cosmos();
    await runAndCheckCosmos2Evm();

}
 

main();










