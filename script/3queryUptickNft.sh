#!/bin/bash

#0x7c4663d780EfA75dAF623a4E79D505df8be88CDC
#uptick103rx84uqa7n4mtmz8f88n4g9m7973rxutrtn7d

# uptickd query nft class "erc721/0x49860A6772c1DB9F8fE9E5e2aa725Fdec498d699" 0x49860A6772c1DB9F8fE9E5e2aa725Fdec498d699|1 --node tcp://127.0.0.1:26657

uptickd query nft nfts --class-id "erc721-0x49860A6772c1DB9F8fE9E5e2aa725Fdec498d699" \
--node tcp://127.0.0.1:26657