# Airdrop - a script to airdrop NFTs on Windows for the Chia Blockchain.
#
# You will need to adjust some of the values below for your setup. 
# You will need to have a separate file containing your list of wallet addresses for the airdrop and the NFT ID of the nft to send to it.
#
# [Required input file:  airdrop.csv] - The format should be one airdrop per line. Each line should have a wallet address, a comma, then one nft id to send to the address.
# Example:
# xch1mxuzqqte2kgu85he6jv8k52qcpynkfz9na4v69203y54uejgk3rsh6d2yr,nft1dqhcx6pundq0fmjxmc69p2m26m25rczz68yd9sjneg5hh0ut325s6c86dw
#

#                                                 #
# ----------- User configuration ---------------- #
#                                                 #

# This is the path & filename for the input file. You can leave the path off if the CSV file is in the same folder as this Powershell script.
$input_file = "airdrop.csv"

# This is the amount (in XCH) that you want to use as a fee for each transaction.
$fee_xch = "0.000000000001"

# This is the fingerprint for the wallet you want to use.
$fingerprint = "1177440315"

# This is the wallet_id containing the NFTs you want to send. (This script assumes all NFTs being airdropped are in the same wallet_id)
$nft_wallet_id = "2"

# This is the number of seconds to wait between each airdrop.
$seconds = 60

# This should be the path to the Chia daemon folder. This is likely already correct and won't need to be modified.
# $chia_path = "$ENV:LOCALAPPDATA\Programs\Chia\resources\app.asar.unpacked\daemon"
$chia_path = "$ENV:LOCALAPPDATA\Programs\Chia\resources\app.asar.unpacked\daemon"

#                                                 #
# ----- Do not modify below here ---------------- #
#                                                 #

$airdrops = Get-Content -Path $input_file
$num_drops = (Get-Content $input_file | Measure-Object -Line).Lines

$n = 1
foreach ($itm in $airdrops) {

    $add = $itm.Substring(0, 62)
    $nftid = $itm.Substring(63)
    Write-Host -NoNewline "$n "

    $coin_id = & $chia_path\chia wallet nft get_info -f $fingerprint -ni $nftid | Select-String "Current NFT coin ID" | ForEach-Object { $_.ToString().Substring(27) }
    & $chia_path\chia wallet nft transfer -f $fingerprint -i $nft_wallet_id -m $fee_xch -ni $coin_id -ta $add >$null 2>&1

    $secs = $seconds
    if ($n -lt $num_drops) {
        while ($secs -gt 0) {
            Write-Host -NoNewline "."
            Start-Sleep -Seconds 1
            $secs--
        }
        Write-Host
    }

    $n++
}
