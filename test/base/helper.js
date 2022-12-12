const fs = require('fs')
const path = require('path')
require('dotenv').config();
const { execSync } = require('child_process')    

let cmd = "",showInfo="",result="",no = 0;

const writeConfig = async (fromFile,toFile,key, value) => {

    let fromFullFile = path.resolve(getConfigPath(), './' + fromFile + '.json')
    let contentText = fs.readFileSync(fromFullFile,'utf-8');
    let data = JSON.parse(contentText);
    data[key] = value;

    let toFullFile = path.resolve(getConfigPath(), './' + toFile + '.json')
    fs.writeFileSync(toFullFile, JSON.stringify(data, null, 4), { encoding: 'utf8' }, err => {})

}

const readConfig = async (fromFile,key) => {

    let fromFullFile = path.resolve(getConfigPath(), './' + fromFile + '.json')
    let contentText = fs.readFileSync(fromFullFile,'utf-8');
    let data = JSON.parse(contentText);
    return data[key];

}

function sleep(ms) {

    return new Promise(resolve => setTimeout(resolve, ms));
}

const getConfigPath = () => {
    //return "scripts/config"
    return path.resolve(__dirname, '.') + "/config"
}

const isTxSuccess = async (resultObj) =>{

    let repObj = await resultObj.wait();  
    //console.log(repObj);
    return repObj.status == 1 ? true:false

}


function hex2a(hexx) {
    var hex = hexx.toString();//force conversion
    var str = '';
    for (var i = 0; i < hex.length; i += 2)
        str += String.fromCharCode(parseInt(hex.substr(i, 2), 16));
    return str;
}
  
async function runCmd(isShowInfo=true) {

    try{
        result = await execSync(cmd, {encoding: 'utf8'});
 
        if(isShowInfo){
            no ++;
            let strShowInfo = `step ${no} : ${showInfo} `
            console.log(strShowInfo);
        }
        return result;
    }catch(err){
        console.log("xxl runCmd ",err);
        throw new Error(err);
    }

}

async function printCurTimeForTest(){
    let date_ob = new Date();
    // current hours
    let hours = date_ob.getHours();
    // current minutes
    let minutes = date_ob.getMinutes();
    // current seconds
    let seconds = date_ob.getSeconds();
    console.log(hours + ":" + minutes + ":" + seconds);

}

async function showCheckResult(exceptedTitles,exceptedResults){

    try{ 
        let result = await runCmd()
        let len = exceptedTitles.length;
        for(var i = 0 ;i < len ;i ++){
            let realResult = getValueFromKey(result,exceptedTitles[i]);

            if(exceptedResults[i] == realResult){
                console.log("\x1b[32m","✔ " + exceptedTitles[i] + " : " + realResult,"\x1b[37m");
            }else{
                console.log("\x1b[31m","✘ " + exceptedTitles[i] + " : " + realResult + " -> " + exceptedResults[i],"\x1b[37m");
            }
        
        }
    }catch(err){}
}


function getValueFromKey(data,key){

    dataArray = data.split('\n')
    for(var i = 0 ;i < dataArray.length ; i++){
        //console.log(dataArray[i]);
        let arrData = dataArray[i].split(":");
        if(arrData.length == 2){
            if(arrData[0].trim() == key){
                return arrData[1].trim();
            }
        }
    }
    return "";
}

//#1 clear data
async function clearData(){
    
    //clear data
    cmd = `./test/script/p3ClearData.sh`
    showInfo = "clear data [chain]";
    try{ await runCmd()}catch(err){}

}

//#2 start chain
async function startChain(){
    
    //clear data
    cmd = `./test/script/p1StartUptick.sh > /dev/null 2>&1 `
    showInfo = "start chain [chain]";
    try{ await runCmd()}catch(err){}

}

//#3 start chain
async function deploy721(){
    
    //clear data
    cmd = `cd solidity && yarn scripts scripts/20deployErc721Uptick.js --network local > /dev/null 2>&1 `
    showInfo = "deploy contract [erc721]";
    try{ await runCmd()}catch(err){}

}

//#4 mint 
async function mint(){
    
    //mint
    cmd = `cd solidity && yarn scripts scripts/21mintErc721Uptick.js --network local > /dev/null 2>&1 `
    showInfo = "deploy mint [erc721]";
    try{ await runCmd()}catch(err){}

}

//#3 start chain
async function deploy721Normal(){
    
    //clear data
    cmd = `cd solidity && yarn scripts scripts/10deployErc721Normal.js --network local > /dev/null 2>&1 `
    showInfo = "deploy normal [erc721]";
    try{ await runCmd()}catch(err){}

}

//#4 mint 
async function mintNormal(){
    
    //mint
    cmd = `cd solidity && yarn scripts scripts/11mintErc721Normal.js --network local > /dev/null 2>&1 `
    showInfo = "mint normal [erc721]";
    try{ await runCmd()}catch(err){}

}


//#5 issue
async function issue(){

    //issue
    cmd = `./test/script/p4CreateClass.sh  `
    showInfo = "deploy issue [cosmos]";
    try{ await runCmd()}catch(err){}
}

//#5 issue
async function mintCosmosNFT(){

    //issue
    cmd = `./test/script/p5CreateNFT.sh  `
    showInfo = "deploy mint NFT [cosmos]";
    try{ await runCmd()}catch(err){}
}


//#5 runCase1 
async function runFromErc721ToCosmosNft(contractAddress,tokenId,clasId,nftId,receiver=""){
   
    if(receiver == "" ){
        cmd = `./test/script/r1FromErc721ToCosmosNft.sh ${contractAddress} ${tokenId} "${clasId}" "${nftId}" ${receiver} `
    }else{
        cmd = `./test/script/r1FromErc721ToCosmosNft.sh ${contractAddress} ${tokenId} "${clasId}" "${nftId}" ${receiver} `
    }

    showInfo = "erc721 To cosmos [FromErc721ToCosmosNft]";
    try{ await runCmd()}catch(err){}

}

//#6 checkCase1 
async function checkCaseOwner(exceptedTitles,exceptedResults){
    
    //check owner
    cmd = `cd solidity && yarn scripts scripts/22ownerOfUptick.js --network local 2>/dev/null `
    showInfo = "check owner[evm] ";

    await showCheckResult(exceptedTitles,exceptedResults);

}

async function checkCaseEvmInfo(exceptedTitles,exceptedResults){
    
    //check owner
    cmd = `cd solidity && yarn scripts scripts/23getEnhanceInfo.js --network local 2>/dev/null `
    showInfo = "check evm info [evm] ";

    await showCheckResult(exceptedTitles,exceptedResults);

}


async function checkCaseDemon(calssId,exceptedTitles,exceptedResults){

    //checkDemon
    cmd = `./test/script/q1QueryUptickClass.sh ${calssId}`
    showInfo = "check demon[cosmos] ";

    await showCheckResult(exceptedTitles,exceptedResults);

}

async function checkCaseNFT(calssId,nftId,exceptedTitles,exceptedResults){

    //checkCase1NFT
    cmd = `./test/script/q2QueryUptickNft.sh ${calssId} ${nftId}`
    showInfo = "check class[cosmos] ";

    await showCheckResult(exceptedTitles,exceptedResults);

}


//#7 runCaseFromCosmosToErc721 
async function runCaseFromCosmosToErc721(clasId,nftId,contractAddress,tokenId,receiver="",from=""){
    
    // cmd = `./test/script/r1FromErc721ToCosmosNft.sh 0x432FDd12f13F3D03a8429687db3102e65dBE3060 1 "" ""  > /dev/null 2>&1`
    if(receiver == ""){
        cmd = `./test/script/r2FromCosmosNftToErc721.sh "${clasId}" "${nftId}" "${contractAddress}" "${tokenId}" ` 
    }else{
        cmd = `./test/script/r2FromCosmosNftToErc721.sh "${clasId}" "${nftId}" "${contractAddress}" "${tokenId}" "${receiver}" "${from}"`
    }

    console.log("xxl cmd : ",cmd);

    showInfo = "cosmos to erc721 [CaseFromCosmosToErc721]";
    try{ await runCmd()}catch(err){}

}

module.exports = {
    writeConfig,
    readConfig, 
    sleep,

    isTxSuccess,
    hex2a,
    runCmd,
    printCurTimeForTest,

    clearData,
    startChain,
    deploy721,
    mint,
    deploy721Normal,
    mintNormal,
    issue,
    mintCosmosNFT,

    runFromErc721ToCosmosNft,
    runCaseFromCosmosToErc721,
    checkCaseEvmInfo,
    checkCaseOwner,
    checkCaseDemon,
    checkCaseNFT,


}