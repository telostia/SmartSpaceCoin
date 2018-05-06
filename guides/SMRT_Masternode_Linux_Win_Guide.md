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
#### d. If you first time run the wallet, a pop-up screen will prompt for Data Directory. By default, it will store in [%AppData%]\Roaming\SMRT\ directory. Recommend you to enter **C:\WalletData\SMRT** directory insteads as it will be easier for you to find the wallet config and data files
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-windows-data-directory.png "Wallet Data Directory prompt")
#### e. Let the wallet sync until you see the tick symbol on the right bottom
![Alt text](https://github.com/ButterX/SmartSpaceCoin/blob/master/images/smrt-windows-wallet-sync.png "Wallet Sync status")

> IMPORTANT: It's recommend that you encrypt your wallet with long and strong passphrase. Jot down the passphrase and keep it safe. Do not reveal your password as this is your key to access your wallet and perform SmartSpace coin transaction.<br>
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

### 4. Configure masternode.

#### a. From the top menu, go to Tools -> Open Masternode Configuration File
#### b. You will be prompted to choose a program to run masternode.conf, select notepad.exe
#### c. Append on new line in masternode.conf file with follong setting;
> masternode.conf setting syntax;
```
address_label vps_ip_address:52310 masternode_genkey masternode_outputs-txhash masternode_outputs-outputidx
```

> Example setting syntax;
```
MN1 198.8.66.9:52310 93HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg 2bcd3c84c84f87eaa86e4e56834c92927a07f9e18718810b92e0d0324456a67c 0
```
>  address_label = `MN1`, the label name that enter earlier when create new wallet address
 
>  vps_ip_address = `198.8.66.9`, the public IP of your VPS
 
>  masternode_genkey = `93HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg`, the masternode's private key from `masternode genkey`
 
>  masternode_outputs-txhash = `2bcd3c84c84f87eaa86e4e56834c92927a07f9e18718810b92e0d0324456a67c`, the masternode's txhash from `masternode outputs`
 
>  masternode_outputs-outputidx = `0`, the masternode's outputidx from `masternode outputs`. It could either '0' or '1'
