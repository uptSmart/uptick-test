#!/bin/bash

#0x7c4663d780EfA75dAF623a4E79D505df8be88CDC
#uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d
valWallet="uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d"
demo2Wallet="cosmos10h9stc5v6ntgeygf5xf945njqq5h32r53uquvw"
classId="erc721-0x49860A6772c1DB9F8fE9E5e2aa725Fdec498d699"
ibcCode="B7DBB08D72E8CAB9EFD08BF97C269126EE057D8106D20067D7A0CACB4B631042"
tokenId="Cat-1"

nftd tx nft transfer nft-transfer channel-0 \
$valWallet ibc/$ibcCode \
$tokenId --from $demo2Wallet \
--chain-id test-2 --keyring-dir ./data/test-2 --fees=1stake \
--keyring-backend=test -b block --node tcp://127.0.0.1:26657 \
--packet-timeout-height 2-10000 -y