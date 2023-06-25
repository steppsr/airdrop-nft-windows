# airdrop-nft-windows

---

__airdrop.ps1__ - a script to airdrop NFTs on Windows for the Chia Blockchain.

---

**How to Get the Script.**
You can just right-click on the **airdrop.ps1** file and choose _Save link as..._ Save this file into a directory on your machine that you want to keep the script. I would suggest creating a new directory under Documents. 

**\*** If you download the full Zip file, you will need to extract the files first and store them in a directory.

**How to Open Powershell.**
Type _powershell_ into the search box by the Windows Start button.
Right-click the Windows Powershell app and choose _Run as Administrator_

**Change your Execution Policy for Powershell.** You may need to change the ExecutionPolicy for Powershell so it will allow you to run a script.

```
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -NoLogo -NonInteractive -ExecutionPolicy Bypass
```

**Do you know your fingerprint?**
You will need the fingerprint of your wallet. If you don't know the fingerprint you can run the following command:

```
$ENV:LOCALAPPDATA\Programs\Chia\resources\app.asar.unpacked\daemon\chia keys show
```

**Now change to the script directory.**
Now to run the script, you will need change to the directory where you saved the file.

```
cd C:\Users\Steve\Documents\Chia\airdrop
```

Note: You will need to adjust some of the values in the top portion of the script for your setup. You will need to have a separate file containing your list of wallet addresses for the airdrop and the NFT ID of the nft to send to it.

__Required input file:__  _airdrop.csv_

The format should be one airdrop per line. Each line should have a wallet address, a comma, then one nft id to send to the address.

Example:
```
xch1mxuzqqte2kgu85he6jv8k52qcpynkfz9na4v69203y54uejgk3rsh6d2yr,nft1dqhcx6pundq0fmjxmc69p2m26m25rczz68yd9sjneg5hh0ut325s6c86dw
```

**And finally, run the script.**

```
.\airdrop
```
