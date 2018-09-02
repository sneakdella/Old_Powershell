<# WRITTEN BY JACOB YUHAS #>

<# This script will #>
<# Retrieve all Security Groups of a specific OU #>
<# Then list all the group members of each Security Group #>
<# Then it writes it to a TXT file in ASCII #>
<# ---------------------------------------------------------#>
<# The main intent of this script is to grab security groups#>
<# Then create a file for each security group and place the #>
<# members of the group into that text file, so that it can #>
<# be imported into Remote Desktop Connection Manager 2.7!  #>
$ou_list = @()

Get-ADGroup -Filter 'Name -like "*"' -SearchBase "OU=ComputerGroups,DC=sneakdella,DC=com" | select name | ForEach-Object {$ou_list += $_}

ForEach ($grp in $ou_list) {
    $filename = $grp.name
    Write-Host $grp.name
    Write-Host "--------"
    $child_list = @()
    Get-ADGroupMember -Identity $grp.name | select name | ForEach-Object {$child_list += $_}
    ForEach ($child in $child_list) {
        $lechild = $child.name
        Write-Host "$lechild"
        "$lechild" | Out-File -append -Encoding Ascii C:\Users\Administrator.sneakdella\Desktop\$filename.txt
    }
    Write-Host ""
}
