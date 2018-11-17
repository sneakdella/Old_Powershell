# Powershell

1.) Pull_all_OU_members


    For this script you will have to change a couple of lines.
      Get-ADGroup -Filter 'Name -like "*"' -SearchBase "OU=<CUSTOM_OU_HERE>, DC=<YOUR_DC_HERE>, DC=com"
      C:\Users\Administrator.... (obviously a different file path.)
      
2.) Search_for_comps

    SCRIPT AUTHOR: Jacob Yuhas

    INTENT OF SCRIPT: 
    Lookup Domain Computer's FQDN faster. 
    Also - Search by the beginning computer number 
    or grab a list of computers by room number.
    
    If your namespace is like "3000DT600" - 
    "COMPUTERNUMBER (3000) -DESKTOP/LAPTOP/TABLET (DT) -ROOM NUMBER (600)"
    This script will work perfectly.
    
    Use the "simple" to create a list of computers just by FQDN
    Then save it to a text file when prompted.
    Then use that text file for option 6 (which is to grab Dell or HP Service Tags)


More scripts to hopefully come in the future.
