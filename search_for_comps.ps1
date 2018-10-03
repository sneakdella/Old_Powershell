<# 
SCRIPT AUTHOR: Sneakdella

INTENT OF SCRIPT: Lookup Domain Computers faster. Search by the beginning computer number or grab a list of computers by room number.

#>

Write-Host "
`n########################################################
`nSCRIPT AUTHOR: Sneakdella
`n
`nINTENT OF SCRIPT: 
`n`tLookup Domain Computer's FQDN faster. 
`n`tAlso - Search by the beginning computer number 
`n`tor grab a list of computers by room number.
`n########################################################
"

#################################################################################################################

# Search by '3112' or '3112DT' to figure out a computer's room number or full FQDN ---- FULL ---
# or search by '31' to grab all computers 3100 to 3199.
function AD-search-number ($compname) {
    #Append input to include wildcard after
    $compname_full = "$compname*"
    #Set to variable to prep to passthrough to Print_lines_question() -- Jump to Print_lines_question()
    $a_cmd = Get-ADComputer -Filter {name -like $compname_full} -Property * | Format-Table Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion -Wrap –Auto
    Print_lines_question($a_cmd)
}

# Search by '3112' or '3112DT' to figure out a computer's room number or full FQDN --- SIMPLE----
# or search by '31' to grab all computers 3100 to 3199.
function AD-search-number-simple ($compname) {
    $compname_full = "$compname*"
    $a_cmd = Get-ADComputer -Filter {name -like $compname_full} -Property * | Format-Table Name -Wrap –Auto
    Print_lines_question($a_cmd)
}

# Search by room number. I.E. '308' or '524' ---- FULL -----
function AD-search-room ($roomname) {
    $child_list = @()
    $roomname_full = "*$roomname"
    $a_cmd = Get-ADComputer -Filter {name -like $roomname_full} -Property * | Format-Table Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion -Wrap –Auto
    Print_lines_question($a_cmd)
}

# Search by room number. I.E. '308' or '524' ---- SIMPLE -----
function AD-search-room-simple ($roomname) {
    $roomname_full = "*$roomname"
    $a_cmd = Get-ADComputer -Filter {name -like $roomname_full} -Property * | Format-Table Name -Wrap –Auto
    Print_lines_question($a_cmd)
}
####################################################################################################################

function Print_lines_question ($outputs) {
    # 1 = keep looping; 0 = User Made Valid Decision
    $do_while_switch = 1
    # Print $outputs to screen ($a_cmd is the input to this parameter).
    Write-Output $outputs
    $usr_inp = Read-Host -Prompt "Would you like to output the results to a file? [y/n]: "
    DO
    {
        If ($usr_inp -eq 'y') {
            $filename = Read-Host -Prompt "Name your file without extension: "
            # Take input, redirect to file output
            $outputs > .\$filename.txt
            # Do/While Switch to '0' to break loop.
            $do_while_switch = 0
        } ElseIf ($usr_inp -eq 'n') {
            # I.E. Pass
            Write-Host "Continuing without saving results."
            $do_while_switch = 0
        } Else {
            Write-Host 'Invalid Response.'
        }
    } While ($do_while_switch -eq 1)
}
######################################################################################################################

# Menu Text, and prompts user
$a = Read-Host -Prompt "
`n1.) Search by FQDN Number - Full Summary (FQDN, OS, OS Service Pack, OS Version)
`n2.) Search by FQDN Number - Just Name
`n3.) Search by Room Number - Full Summary (FQDN, OS, OS Service Pack, OS Version)
`n4.) Search by Room Number - Just Name
`n5.) Exit
`nPlease select a number "

# CASE statement based on the input of $a from the user
switch($a){

    # User chooses AD-search-number FULL SUMMARY
    1{$b = Read-Host "Please enter the first four letters or numbers: "
        AD-search-number($b)}
    # User chooses AD-search-number FQDN Only (perfect for lists)
    2{$b = Read-Host "Please enter the first four letters or numbers: "
        AD-search-number-simple($b)}
    # User chooses AD-search-room FULL SUMMARY
    3{$c = Read-Host "Please enter the room number: "
        AD-search-room($c)}
    # User chooses AD-search-room FQDN Only (perfect for lists)
    4{$c = Read-Host "Please enter the room number: "
        AD-search-room-simple($c)}
    # Exits the script
    5{exit}
}

try{
  Stop-Transcript|Out-Null
}
catch [System.InvalidOperationException]{}
