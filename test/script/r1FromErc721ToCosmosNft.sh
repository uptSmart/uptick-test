#!/bin/bash

#0x7c4663d780EfA75dAF623a4E79D505df8be88CDC
#uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d
valWallet="uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d"
contractAddress=""
tokenId=""
classId=""
nftId=""
receiver=""

contractAddress=$1
tokenId=$2

if [ $# -eq 3 ];then
    classId=$3
elif [ $# -eq 4 ];then
    classId=$3
    nftId=$4
elif [ $# -eq 5 ];then
    classId=$3
    nftId=$4
    receiver=$5
elif [ $# -eq 6 ];then
    classId=$3
    nftId=$4
    receiver=$5
    valWallet=$6
fi

if [ -z $receiver ] ; then
    uptickd tx erc721 convert-erc721 "$contractAddress" "$tokenId" "$classId" "$nftId" \
    --from $valWallet --chain-id uptick_7000-1 \
    --keyring-dir ./data/uptick_7000-1 --gas auto \
    --keyring-backend=test -b block --node tcp://127.0.0.1:16657 -y
else
    uptickd tx erc721 convert-erc721 "$contractAddress" "$tokenId" "$classId" "$nftId" "$receiver" \
    --from $valWallet --chain-id uptick_7000-1 \
    --keyring-dir ./data/uptick_7000-1 --gas auto \
    --keyring-backend=test -b block --node tcp://127.0.0.1:16657 -y
fi
