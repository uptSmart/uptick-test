#!/bin/bash

demowallet1="uptick1ehh5503n2rhpz8evfqpsa62kfqc58c5g02kjhd"
demowallet2="cosmos10h9stc5v6ntgeygf5xf945njqq5h32r53uquvw"

nftd tx nft transfer nft-transfer channel-0 $demowallet1 \
ibc/943B966B2B8A53C50A198EDAB7C9A41FCEAF24400A94167846679769D8BF8311 \
xiaopi --from $demowallet2 --chain-id \
test-2 --keyring-dir ./data/test-2 --fees=1stake \
--keyring-backend=test -b block --node tcp://127.0.0.1:26657 \
--packet-timeout-height 2-10000 -y