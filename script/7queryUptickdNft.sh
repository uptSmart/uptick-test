#!/bin/bash

#0x7c4663d780EfA75dAF623a4E79D505df8be88CDC
#uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d
valWallet="uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d"
demo2Wallet="cosmos10h9stc5v6ntgeygf5xf945njqq5h32r53uquvw"
classId="erc721-0x49860A6772c1DB9F8fE9E5e2aa725Fdec498d699"
tokenId="Cat-1"

uptickd query nft owner $classId $tokenId --node tcp://127.0.0.1:16657

##https://github.com/bianjieai/ibc-go/blob/develop/modules/apps/nft-transfer/types/keys.go#L45
