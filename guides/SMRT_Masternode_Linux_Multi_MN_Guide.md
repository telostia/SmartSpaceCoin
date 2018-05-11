## SmartSpace Coin (SMRT): Multi-MasterNode in One Linux Server Install Guide

**IMPORTANT:**<br>
**You must follow instruction below first before move on multi-masternode installation;**<br>
**[SmartSpace Linux MasterNode Hot Wallet & Windows Cold Wallet Install Guide](SMRT_Masternode_Linux_Win_Guide.md)**
 
---
 
## **Part 1**: Create Wallet Address for Subsequent MasterNode Collateral

### 1. Create a wallet address for second MasterNode and send SMRT coin to the address for your MasterNode collateral.

#### a. From the top menu, go to File -> Receiving addresses
#### b. Click on "New" button, enter a label (for example, MN2) and click on "OK" button
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-windows-wallet-second-address.png "Second Wallet Address")
#### c. Select on the newly created wallet address from the list and then click on "Copy" button to copy the address into the clipboard
#### d. Send exactly 5,000 SMRT coins to the address that you just copied. Ensure the address is correct before you send out the coin.
#### e. After coin is sent out, you can verify the balance in the 'Transactions' tab and wait for at least 16 confirmations to validate your transaction (it usually takes about half an hour).

---

### 2. Obtain MasterNode private key and transaction of the collateral transfer information.
#### a. From the top menu, go to Tools -> Debug console
#### b. Run the following command: 'masternode genkey'
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-windows-wallet-genkey.png "Wallet masternode genkey")
A long private key will be displayed (example as per below) and required for both Cold and Hot wallet configuration later on:
```
86Vh9t1mJMJN7quwEzyiFcc12Y1EWaKikiy6Mgc36Z4Ux7BbmN2
```

#### c. Continue to run following command: 'masternode outputs'
'txhash' (Transaction Id) and 'outputidx' information will be displayed (example as per below) and required for Cold wallet configuration later on:
```
[
  {
     "txhash" : "8bf27e99efe8ccfd0g486019de25531fe7088a2fd24dd647e56eac39ce75557f",
     "outputidx" : 0
  }
]
```

---
 
## **Part 2**: Add and Configure Additional IP Address in Linux (Ubuntu) VPS Hot Wallet

> <a href="https://www.vultr.com/?ref=7414835" target="_blank">Vultr</a> will be used as an example to add additional IP address in a VPS. However, you may use other VPS provider and the instruction may be different.
 
### 1. Add Additional IP Address
 
#### a. Logon to <a href="https://www.vultr.com/?ref=7414835" target="_blank">Vultr</a>, click on the server that would like add secondary IP address from the dashboard
#### b. Go to `Settings` tab, click on "Add Another IPv4 Address" button follow by "Add IPv4 Address" button
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-vultr-vps-add-secondary-ip-1.png "Vultr.com create secondary IP")
#### c. Jot down the secondary IP address, then click on `networking configuration` hyperlink
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-vultr-vps-add-secondary-ip-2.png "Vultr.com new secondary IP")
#### d. Look for correct OS (for example, if VPS on Ubuntu 16.04 x64 then scroll to `Ubuntu 16.xx, Ubuntu 17.04` section), copy the lines of code
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-vultr-vps-secondary-ip-command.png "Vultr.com secondary IP commands")
 
### 2. Configure the newly added Additional IP Address
 
#### a. Launch PuTTY application and login into VPS as root. Edit the network configuration

```
sudo nano /etc/network/interfaces
```

#### b. Paste the lines of code into the editor
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-vultr-vps-interfaces-configuration.png "VPS Interfaces Configuration")

Below are the example of the network configuration codes
```
auto lo
iface lo inet loopback
 
auto ens3
iface ens3 inet static
	address 45.32.184.54
	netmask 255.255.254.0
	gateway 45.32.184.1
	dns-nameservers 108.61.10.10
	post-up ip route add 169.254.0.0/16 dev ens3
 
 
auto ens3:1
iface ens3:1 inet static
	address 108.61.188.28
	netmask 255.255.254.0
```

#### c. Exit the editor by hit CTRL + X and then hit Y follow by 'ENTER' to commit the configuration changes
#### d. Activate the alias network

```
ifup ens3:1
```

#### e. Restart your VPS take effect on latest network configurations

```
sudo reboot
```

---
 
## **Part 3**: Linux (Ubuntu) Hot Wallet Installation on Subsequent User

### 1. Create subsequent user and copy SmartSpace client and daemon into new user's home dir.

>sudo useradd -m $USERNAME -s /bin/bash<br>
>sudo passwd $USERNAME<br>
> 
>sudo mkdir /home/$USERNAME/smrt<br>
>sudo cp ~/smrt/smrtd-lin64 /home/$USERNAME/smrt/smrtd<br>
>sudo cp ~/smrt/smrt-cli-lin64 /home/$USERNAME/smrt/smrt-cli<br>
>
>sudo chmod 777 /home/$USERNAME/smrt/smrtd<br>
>sudo chmod 777 /home/$USERNAME/smrt/smrt-cli<br>

Example commands, by replace *$USERNAME* syntax with `mn2` as new user
```
sudo useradd -m mn2 -s /bin/bash
sudo passwd mn2

sudo mkdir /home/mn2/smrt
sudo cp ~/smrt/smrtd-lin64 /home/mn2/smrt/smrtd
sudo cp ~/smrt/smrt-cli-lin64 /home/mn2/smrt/smrt-cli

sudo chmod 777 /home/mn2/smrt/smrtd
sudo chmod 777 /home/mn2/smrt/smrt-cli
```

### 2. Run the SmartSpace client and daemon via newly created user login

>su - $USERNAME -c "~/smrt/smrtd --daemon"

Example commands, by replace *$USERNAME* syntax with `mn2` as new user
```
su - mn2 -c "~/smrt/smrtd --daemon"
```
 
#### a. You will get an error when start the wallet, `Error: To use smrtd, or the -server option to smrt-qt, you must set an rpcpassword in the configuration file...`. That is correct behaviour as you do not have any config file yet
#### b. The service will create the initial data directory(~/.smrt/).

### 3. Edit MasterNode wallet configure file

>sudo nano /home/$USERNAME/.smrt/smrt.conf

Example commands, by replace *$USERNAME* syntax with `mn2` as new user
```
sudo nano /home/mn2/.smrt/smrt.conf
```

#### a. Enter following configuration details and change `[$rpc_user]`, `[$rpc_password]`, `[$vps_ip_address]` & `[$cold_wallet_masternode_genkey]` (from Part 1, step 2) accordingly
```
rpcuser=[$rpc_user]
rpcpassword=[$rpc_password]
rpcallowip=127.0.0.1
rpcport=52312
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
rpcport=52312
listen=1
server=1
daemon=1
listenonion=0
externalip=108.61.188.28
bind=108.61.188.28:52310
masternode=1
masternodeprivkey=86Vh9t1mJMJN7quwEzyiFcc12Y1EWaKikiy6Mgc36Z4Ux7BbmN2
```
> NOTE: `rpcport` value can not be repeated from previous user in one VPS. For example, if you use `52311` for `MN1` user then you can increase the port no by 1, `52312` for `MN2` user.

### 3. Re-run the smrtd and wait until the wallet is synced with latest block

>su - $USERNAME -c "~/smrt/smrtd --daemon"

Example commands, by replace *$USERNAME* syntax with `mn2` as new user
```
su - mn2 -c "~/smrt/smrtd --daemon"
```

Run the following command every few mins until the block count is match with [SMRT Explorer](http://explorer.smrtcoin.org)
>su - $USERNAME -c "~/smrt/smrt-cli getinfo"

Example commands, by replace *$USERNAME* syntax with `mn2` as new user
```
su - mn2 -c "~/smrt/smrt-cli getinfo"
```

---

## **Part 4**: Subsequent Masternode Configuration and Activation
 
### 1. Configure and enable masternode.

#### a. Launch your Cold Wallet from Windows machine. From the top menu, go to Tools -> Open Masternode Configuration File
#### b. *Append* on new line in masternode.conf file with follong setting;
> masternode.conf setting syntax;
```
address_label vps_ip_address:52310 masternode_genkey masternode_outputs-txhash masternode_outputs-outputidx
```

> Example setting syntax;
```
MN2 108.61.188.28:52310 86Vh9t1mJMJN7quwEzyiFcc12Y1EWaKikiy6Mgc36Z4Ux7BbmN2 8bf27e99efe8ccfd0g486019de25531fe7088a2fd24dd647e56eac39ce75557f 0
```
>  address_label = `MN2`, the label name that enter earlier when create new wallet address
 
>  vps_ip_address = `108.61.188.28`, the additional public IP of your VPS
 
>  masternode_genkey = `86Vh9t1mJMJN7quwEzyiFcc12Y1EWaKikiy6Mgc36Z4Ux7BbmN2`, the masternode's private key from `masternode genkey`
 
>  masternode_outputs-txhash = `8bf27e99efe8ccfd0g486019de25531fe7088a2fd24dd647e56eac39ce75557f`, the masternode's txhash from `masternode outputs`
 
>  masternode_outputs-outputidx = `0`, the masternode's outputidx from `masternode outputs`. It could be either '0' or '1', both value are just fine.
 
#### c. Close and re-launch the SMRT-Qt wallet to take effect on the latest change on MasterNode configuration
#### d. Go to 'Masternodes' tab and check if your newly added MasterNode is in the listing. The newly added MasterNode would be in `MISSING` status
#### e. Select the newly added MasterNode and click on "Start alias" button to enable the MasterNode
 
---

### 2. Check whether your MasterNode is enabled
 
#### Go back to the Linux VPS console and run the following command to check the MasterNode status
 
>su - $USERNAME -c "~/smrt/smrt-cli masternode status"`

Example commands, by replace *$USERNAME* syntax with `mn2` as new user
```
su - mn2 -c "~/smrt/smrt-cli masternode status"`
```
The status shall display `Masternode successfully started` if all the steps above are follow correctly.
 
------
 
## Donations:

If the guideline above help you and you love me, any donation is greatly appreciated!

**SMRT**: STj7L6LpaB5rYn12b1eZhdksTuSS1xTy47<br>
**BTC**: 1CUAt6wa9MVVvxfX2wBgjsmQCgHdrQ3tP3<br>
**LTC**: LTakDgFyrSeztb8DYHSTNnY8BDSVqPmJxU<br>
**ETH**: 0xbe6337bb3967b4d6d7d2931e7f2b523ff63ecf19
