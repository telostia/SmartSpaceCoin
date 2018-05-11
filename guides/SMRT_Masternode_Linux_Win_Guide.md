## SmartSpace Coin (SMRT): Linux MasterNode Hot Wallet & Windows Cold Wallet Install Guide

**IMPORTANT:**<br>
**1. Strongly suggest that not to run a masternode (Hot wallet) at home. It's not safe as your IP address can be traced back to your home.**<br>
**2. However, you can still run a Cold wallet at home.**

---

## Requirements
* Windows 7 or higher (as your Cold wallet)
* Linux VPS (Ubuntu 16.04 64 bit) that running 24/7 such as <a href="https://www.vultr.com/?ref=7414835" target="_blank">Vultr (stable and cheap host)</a>, or other VPS provider (as your Hot wallet)
* Static IP Address
* Basic Linux skills
* SSH client, to connect to Linux VPS. Recommend [PuTTY](https://putty.org)

---

## **Part 1**: Windows Cold Wallet Installation
 
NOTED:<br>
* Required to send 5,000 SMRT into this wallet as MasterNode collateral
* This wallet will be the one that receive the MasterNode rewards
* It DOES NOT need to run 24/7
 
### 1. Install and run the SMRT-Qt wallet on your Windows machine.

#### a. Download the latest wallet, smrt-qt-win64.exe (if Windows in 64 bit) or smrt-qt-win32.exe (if Windows in 32 bit), from https://github.com/smrt-crypto/smrt/releases/ or http://smrtcoin.org/
#### b. Double click on smrt-qt-win64.exe or smrt-qt-win32.exe
#### c. Click "Yes" button if you get 'unknown publisher' warning as per below:
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-windows-install-warning.png "Install Unknown Publisher Warning")
#### d. If you first time run the wallet, a pop-up screen will prompt for Data Directory. By default, it will store in `%AppData%\SMRT\` directory. Recommend you to enter **C:\WalletData\SMRT** directory insteads as it will be easier for you to find the wallet config and data files
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-windows-data-directory.png "Wallet Data Directory prompt")
#### e. Let the wallet sync until you see the tick symbol on the right bottom
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-windows-wallet-sync.png "Wallet Sync status")

> IMPORTANT: It's recommend that you encrypt your wallet with long and strong passphrase. Jot down the passphrase and keep it safe. Do not reveal your password as this is your key to access your wallet and able to perform SmartSpace coin transaction.<br>
To encrypt the wallet, go to Settings -> Encrypt Wallet. Enter the passphrase, then click "OK" button to activate.

---

### 2. Create a wallet address and send SMRT coin to the address for your MasterNode collateral.

#### a. From the top menu, go to File -> Receiving addresses
#### b. Click on "New" button, enter a label (for example, MN1) and click on "OK" button
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-windows-wallet-create-address.png "New Wallet Address")
#### c. Select on the newly created wallet address from the list and then click on "Copy" button to copy the address into the clipboard
#### d. Send exactly 5,000 SMRT coins to the address that you just copied. Ensure the address is correct before you send out the coin.
#### e. After coin is sent out, you can verify the balance in the 'Transactions' tab and wait for at least 16 confirmations to validate your transaction (it usually takes about half an hour).

---

### 3. Obtain MasterNode private key and transaction of the collateral transfer information.
#### a. From the top menu, go to Tools -> Debug console
#### b. Run the following command: 'masternode genkey'
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-windows-wallet-genkey.png "Wallet masternode genkey")
A long private key will be displayed (example as per below) and required for both Cold and Hot wallet configuration later on:
```
93HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg
```

#### c. Continue to run following command: 'masternode outputs'
'txhash' (Transaction Id) and 'outputidx' information will be displayed (example as per below) and required for Cold wallet configuration later on:
```
[
  {
     "txhash" : "2bcd3c84c84f87eaa86e4e56834c92927a07f9e18718810b92e0d0324456a67c",
     "outputidx" : 0
  }
]
```

> NOTE: In case your masternode outputs is BLANK, it could be following reasons :-
> * You may not sent EXACTLY 5,000 SMRT in a single transaction. Therefore, you can send all the coins to another address within your wallet.
> * The transaction is less than 16 confirmation and you would need to wait until 16 confirmation.

---
 
## **Part 2**: Subscribe VPS for Hot Wallet server

NOTED:<br>
* TCP port 52310 must be opened 
* It REQUIRED to run 24/7
* Since running 24/7, strongly suggest not store any fund in this wallet to avoid losing fund in case server is attack.
 
### You can subscribe VPS from provider like <a href="https://www.vultr.com/?ref=7414835" target="_blank">Vultr (stable and cheap host)</a>, or other similar providers with following requirements;
* Linux VPS (Ubuntu 16.04 64 bit)
* Static IP Address (dedicated Public IP)
* At least 1GB of RAM
 
#### a. Register an account <a href="https://www.vultr.com/?ref=7414835" target="_blank">Vultr</a>, then click on "+" button from the dashboard
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-vultr-vps-creation-1.png "Vultr.com create VPS")
#### b. Select any 'Server Location' follow by `Ubuntu 16.04 x64` for 'Server Type' and `$5/mo with 25 GB SSD` for 'Server Size'
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-vultr-vps-creation-2.png "Vultr.com create VPS")
#### c. Leave 'Additional Features' optins uncheck
#### d. Enter a Hostname and Label for your VPS (for example, `SMRT_MN`)
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-vultr-vps-creation-3.png "Vultr.com create VPS")
#### e. After successfully install the VPS, click on the server from the list to jot down `IP Address` and root's `Password`
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-vultr-vps-ip-password.png "Vultr.com VPS IP & Password")

---

## **Part 3**: Linux (Ubuntu) Hot Wallet Installation

NOTED:<br>
* You may use SSH client to connect the VPS. Recommend [PuTTY](https://putty.org)
* Copy and paste the commands below *LINE* by *LINE* to install and update the packages
* *DO NOT* copy the entire commands and paste, it will not work
 
### 1. Launch PuTTY application and login into VPS as root. Install and update all the pre-requisite packages

```
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y install wget nano git unrar unzip
sudo apt-get -y install build-essential libtool autotools-dev automake autoconf pkg-config libssl-dev software-properties-common
sudo apt-get -y install libzmq3-dev libgmp3-dev libminiupnpc-dev libevent-dev bsdmainutils libboost-all-dev
 
sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo apt-get -y update
 
sudo apt-get -y install libdb4.8-dev libdb4.8++-dev
sudo apt-get -y install libdb5.3-dev libdb5.3++-dev
```

### 2. Swap setup to avoid running out of memory, swap 1.5 GB

```
sudo fallocate -l 1500M /mnt/1500MB.swap
sudo dd if=/dev/zero of=/mnt/1500MB.swap bs=1024 count=1572864
sudo mkswap /mnt/1500MB.swap
sudo swapon /mnt/1500MB.swap
sudo chmod 600 /mnt/1500MB.swap
echo '/mnt/1500MB.swap none swap sw 0 0' >> /etc/fstab
free -h
```

### 3. Enable firewall and allow SSH (22) and 52310 ports only

```
sudo ufw allow 22/tcp
sudo ufw limit 22/tcp
sudo ufw allow 52310/tcp
sudo ufw logging on
sudo ufw --force enable
sudo ufw status
```

### 4. Download SmartSpace client and daemon into 'smrt' directory. Always check for the latest [release](https://github.com/smrt-crypto/smrt/releases)

```
sudo mkdir smrt
cd smrt
 
sudo wget https://github.com/smrt-crypto/smrt/releases/download/v1.1.0.5/smrtd-lin64
sudo wget https://github.com/smrt-crypto/smrt/releases/download/v1.1.0.5/smrt-cli-lin64
cd ~
```

### 5. Create new user and copy SmartSpace client and daemon into new user's home dir.

>sudo useradd -m $USERNAME -s /bin/bash<br>
>sudo passwd $USERNAME<br>
> 
>sudo mkdir /home/$USERNAME/smrt<br>
>sudo cp ~/smrt/smrtd-lin64 /home/$USERNAME/smrt/smrtd<br>
>sudo cp ~/smrt/smrt-cli-lin64 /home/$USERNAME/smrt/smrt-cli<br>
>
>sudo chmod 777 /home/$USERNAME/smrt/smrtd<br>
>sudo chmod 777 /home/$USERNAME/smrt/smrt-cli<br>

Example commands, by replace *$USERNAME* syntax with `mn1` as new user
```
sudo useradd -m mn1 -s /bin/bash
sudo passwd mn1

sudo mkdir /home/mn1/smrt
sudo cp ~/smrt/smrtd-lin64 /home/mn1/smrt/smrtd
sudo cp ~/smrt/smrt-cli-lin64 /home/mn1/smrt/smrt-cli

sudo chmod 777 /home/mn1/smrt/smrtd
sudo chmod 777 /home/mn1/smrt/smrt-cli
```

### 6. Run the SmartSpace client and daemon via newly created user login

>su - $USERNAME -c "~/smrt/smrtd --daemon"

Example commands, by replace *$USERNAME* syntax with `mn1` as new user
```
su - mn1 -c "~/smrt/smrtd --daemon"
```
 
#### a. You will get an error when start the wallet, `Error: To use smrtd, or the -server option to smrt-qt, you must set an rpcpassword in the configuration file...`. That is correct behaviour as you do not have any config file yet
#### b. The service will create the initial data directory(~/.smrt/).

### 7. Edit MasterNode wallet configure file

>sudo nano /home/$USERNAME/.smrt/smrt.conf

Example commands, by replace *$USERNAME* syntax with `mn1` as new user
```
sudo nano /home/mn1/.smrt/smrt.conf
```

#### a. Enter following configuration details and change `[$rpc_user]`, `[$rpc_password]`, `[$vps_ip_address]` & `[$cold_wallet_masternode_genkey]` (from Part 1, step 3) accordingly
```
rpcuser=[$rpc_user]
rpcpassword=[$rpc_password]
rpcallowip=127.0.0.1
rpcport=52311
listen=1
server=1
daemon=1
listenonion=0
externalip=[$vps_ip_address]
bind=[$vps_ip_address]:52310
masternode=1
masternodeprivkey=[$cold_wallet_masternode_genkey]
```
 
#### b. Exit the editor by hit CTRL + X and then hit Y follow by 'ENTER' to commit the configuration changes

Below are the example configuration for smrt.conf file
```
pcuser=smrtrpcuser
rpcpassword=Long&StrongPASSWORD123$%^
rpcallowip=127.0.0.1
rpcport=52311
listen=1
server=1
daemon=1
listenonion=0
externalip=45.77.52.239
bind=45.77.52.239:52310
masternode=1
masternodeprivkey=93HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg
```

### 8. Re-run the smrtd and wait until the wallet is synced with latest block

>su - $USERNAME -c "~/smrt/smrtd --daemon"

Example commands, by replace *$USERNAME* syntax with `mn1` as new user
```
su - mn1 -c "~/smrt/smrtd --daemon"
```

Run the following command every few mins until the block count is match with [SMRT Explorer](http://explorer.smrtcoin.org)
>su - $USERNAME -c "~/smrt/smrt-cli getinfo"

Example commands, by replace *$USERNAME* syntax with `mn1` as new user
```
su - mn1 -c "~/smrt/smrt-cli getinfo"
```

---

## **Part 4**: Masternode Configuration and Activation
 
### 1. Configure and enable masternode.

#### a. Launch your Cold Wallet from Windows machine. From the top menu, go to Tools -> Open Masternode Configuration File
#### b. You will be prompted to choose a program to run masternode.conf, select notepad.exe
#### c. Append on new line in masternode.conf file with follong setting;
> masternode.conf setting syntax;
```
address_label vps_ip_address:52310 masternode_genkey masternode_outputs-txhash masternode_outputs-outputidx
```

> Example setting syntax;
```
MN1 45.77.52.239:52310 93HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg 2bcd3c84c84f87eaa86e4e56834c92927a07f9e18718810b92e0d0324456a67c 0
```
>  address_label = `MN1`, the label name that enter earlier when create new wallet address
 
>  vps_ip_address = `45.77.52.239`, the public IP of your VPS
 
>  masternode_genkey = `93HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg`, the masternode's private key from `masternode genkey`
 
>  masternode_outputs-txhash = `2bcd3c84c84f87eaa86e4e56834c92927a07f9e18718810b92e0d0324456a67c`, the masternode's txhash from `masternode outputs`
 
>  masternode_outputs-outputidx = `0`, the masternode's outputidx from `masternode outputs`. It could be either '0' or '1', both value are just fine.
 
#### d. Close and re-launch the SMRT-Qt wallet to take effect on the latest change on MasterNode configuration
#### e. Go to 'Masternodes' tab and check if your newly added MasterNode is in the listing. The newly added MasterNode would be in `MISSING` status
#### f. Select the newly added MasterNode and click on "Start alias" button to enable the MasterNode
 
> If could not start the MasterNode, you may run following command in Debug Console: 'startmasternode alias false MN1`

---

### 2. Check whether your MasterNode is enabled
 
#### Go back to the Linux VPS console and run the following command to check the MasterNode status
 
>su - $USERNAME -c "~/smrt/smrt-cli masternode status"

Example commands, by replace *$USERNAME* syntax with `mn1` as new user
```
su - mn1 -c "~/smrt/smrt-cli masternode status"
```
The status shall display `Masternode successfully started` if all the steps above are follow correctly.
 
It may take at least 5 hours or longer to get the first rewards, depend on the current blocks and number of active masternodes in the network.

---
 
## Tips
 
### 1. Follow the guide below if you would like add second MasterNode in the same Linux VPS (Ubuntu);
 [SmartSpace Multi-MasterNode in One Linux Server Guide](SMRT_Masternode_Linux_Multi_MN_Guide.md)

### 2. Following are some useful commands for you to troubleshoot if your MasterNode stop working :-
 
> `su - $USERNAME -c "~/smrt/smrtd --daemon"` : START the wallet application
> 
> `ps aux | grep smrtd | grep -v grep` : Check current SMRTD service
> 
> `su - $USERNAME -c "~/smrt/smrt-cli stop"` : STOP the wallet application
> 
> `su - $USERNAME -c "~/smrt/smrt-cli getinfo"` : Check current wallet application status
> 
> `su - $USERNAME -c "~/smrt/smrt-cli getblockcount"` : Check current sync block status
> 
> `su - $USERNAME -c "~/smrt/smrt-cli masternode status"` : Check current MasterNode status
 
> You may check your MasterNode(s) rewards transaction on this blockchain explorer: [http://explorer.smrtcoin.org](http://explorer.smrtcoin.org)
 
------
 
## Donations:

If the guideline above help you and you love me, any donation is greatly appreciated!

**SMRT**: STj7L6LpaB5rYn12b1eZhdksTuSS1xTy47<br>
**BTC**: 1CUAt6wa9MVVvxfX2wBgjsmQCgHdrQ3tP3<br>
**LTC**: LTakDgFyrSeztb8DYHSTNnY8BDSVqPmJxU<br>
**ETH**: 0xbe6337bb3967b4d6d7d2931e7f2b523ff63ecf19
