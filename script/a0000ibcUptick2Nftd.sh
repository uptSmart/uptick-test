#!/bin/bash

demowallet1="uptick1ehh5503n2rhpz8evfqpsa62kfqc58c5g02kjhd"
demowallet2="cosmos10h9stc5v6ntgeygf5xf945njqq5h32r53uquvw"

uptickd tx nft transfer nft-transfer channel-0 $demowallet2 \
cat xiaopi --from $demowallet1 --chain-id uptick_7000-1 \
--keyring-dir ./data/uptick_7000-1 --fees=1auptick --keyring-backend=test \
-b block --node tcp://127.0.0.1:16657 --packet-timeout-height 2-10000 -y