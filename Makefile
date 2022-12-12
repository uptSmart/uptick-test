#!/usr/bin/make -f


###############################################################################
###                                Initialize                               ###
###############################################################################

init: kill-dev
	@echo "Initializing both blockchains..."
	./network/init.sh
	./network/start.sh

init-golang-rly: kill-dev
	@echo "Initializing both blockchains..."
	./network/init.sh
	./network/start.sh
	
	@echo "Initializing relayer..."
	./network/relayer/interchain-nft-config/rly.sh

start: 
	@echo "Starting up test network"
	./network/start.sh

start-rly:
	./network/hermes/start.sh

kill-dev:
	@echo "Killing uptickd and nftd removing previous data"
	-@rm -rf ./data
	-@killall nftd 2>/dev/null
	-@killall uptickd 2>/dev/null
