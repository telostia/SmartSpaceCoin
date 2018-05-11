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

#### b. Paste the lines of code into file and ctrl x to save file

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
ifup ens3:0
```

#### e. Restart your VPS take effect on latest network configurations

```
sudo reboot
```

---
 
