## SmartSpace Coin (SMRT): MasterNode Frequently Asked Questions

 
### 1. There is no response when I try 'Open Masternode Configuration File' ?

Locate your data directory, then look for `masternode.conf` file and edit.
 
By default, data directory is located in `%AppData%\SMRT`.<br>
However, we suggested to configure to `C:\WalletData\SMRT` directory in guideline unless you have changed to other directory.
 
---

### 2. How do I make sure my masternode is running ?
 
Perform the following steps :-
 
a. Launch Windows Cold wallet, go to Masternodes tab and ensure the following
```
- 'Status' column is ENABLED
- 'Active' column is more than 0m:00s
```
 
b. Login to Linux (Ubuntu) VPS via PuTTY and run following command;
```
smrt-cli masternode status
```
It shall return `Masternode successfully started`
 
OR
 
Check your masternode status in [https://masternodes.online/monitoring](https://masternodes.online/monitoring) by enter your VPS IP address or masternode wallet address information.
 
 
---

Some useful commands for further troubleshoot if MasterNode stop working :-
 
>  `smrtd --daemon"` : START the wallet application

>  `ps aux | grep smrtd | grep -v grep` : Check current SMRTD service
 
>  `smrt-cli stop` : STOP the wallet application
 
>  `smrt-cli getinfo` : Check current wallet application status
 
>  `smrt-cli getblockcount` : Check current sync block status
 
>  `smrt-cli masternode status` : Check current MasterNode status
