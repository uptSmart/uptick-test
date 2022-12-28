#!/bin/bash

valWallet="uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d"

uptickd tx nft issue cdemon2 --name=cName2 --uri=cUri2 --data=cData2 --schema=cSchema2 --uri-hash=uriHash2 \
--description=cDescription2 --symbol=cSymbol2 --mint-restricted=false --update-restricted=false \
--from $valWallet --chain-id uptick_7000-1 \
--keyring-dir ./data/uptick_7000-1 --gas auto \
--keyring-backend=test -b block --node tcp://127.0.0.1:26657 -y
