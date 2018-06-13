#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install git -y
sudo apt-get install nano -y
sudo apt-get install curl -y
sudo apt-get install pwgen -y
sudo apt-get install wget -y
sudo apt-get install build-essential libtool automake autoconf -y
sudo apt-get install autotools-dev autoconf pkg-config libssl-dev -y
sudo apt-get install libgmp3-dev libevent-dev bsdmainutils libboost-all-dev -y
sudo apt-get install libzmq3-dev -y
sudo apt-get install libminiupnpc-dev -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update -y
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
cd
#get wallet files
wget https://github.com/smrt-crypto/smrt/releases/download/v1.1.0.5/smrt-cli-lin64 && wget https://github.com/smrt-crypto/smrt/releases/download/v1.1.0.5/smrtd-lin64
mv smrt-cli-lin64 smrt-cli && mv smrtd-lin64 smrtd && chmod +x smrt*
cp smrt* /usr/local/bin



#masternode input

echo -e "${GREEN}Now paste your Masternode key by using right mouse click ${NONE}";
read MNKEY

EXTIP=`wget -qO- eth0.me`
PASSW=`pwgen -1 20 -n`

echo -e "${GREEN}Preparing config file ${NONE}";

rm -rf $HOME/.smrt
sudo mkdir $HOME/.smrt

printf "addnode=45.77.52.239:52310\naddnode=31.171.251.72:52310\naddnode=167.99.70.168:52310\naddnode=144.202.78.25:52310\naddnode=149.28.37.210:52310\naddnode=74.108.58.91:52310\naddnode=206.189.186.158:52310\naddnode=107.174.250.215:52310\n\nrpcuser=smartuser\nrpcpassword=$PASSW\nrpcport=52311\nrpcallowip=127.0.0.1\ndaemon=1\nlisten=1\nserver=1\nmaxconnections=256\nexternalip=$EXTIP:52310\nmasternode=1\nmasternodeprivkey=$MNKEY" >  $HOME/.smrt/smrt.conf


smrtd -daemon
watch smrt-cli getinfo

