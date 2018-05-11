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
 
## **Part 2**: Add Secondary IP Address in Linux (Ubuntu) VPS Hot Wallet

### <a href="https://www.vultr.com/?ref=7414835" target="_blank">Vultr</a> will be used as an example to add secondary IP address in a VPS. However, you may use other VPS provider and the instruction may be different.
 
