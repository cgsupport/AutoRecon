clear
home=$(echo ~)
read -p "please enter the name of the workspace folder " workspace
clear 
echo "----------------------------------"
echo "-----------LOOT-------------------"
echo "----------------------------------"
echo ""
echo "1 - DNS Loot"
echo "2 - Valid Emails"
echo "3 - Compromised accounts(email spray)"
echo "4 - Open Ports & found services (to be completed)"
echo "5 - Package loot to zip(to be completed)"
echo "8 - Main Menu"
read options;
case $options in 
	1) clear
        echo "DNS Records"
        echo "-------------------------"     
        cat $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
        echo ""
        echo "-------------------------"
        echo ""
        echo "-------------------------"
        echo "Zone Transfer"
        echo "-------------------------"
        cat $home/workspaces/$workspace/DNSInfo/DNSZoneTransfer.txt
        echo ""
        echo "-------------------------"
        echo ""
        echo "-------------------------"
        echo "Subdomain Bruteforce Results"
        echo "-------------------------"
        cat $home/workspaces/$workspace/DNSInfo/SubBrute.txt
        read -n 1 -r -s -p "press any key to return to loot menu" key
        /opt/AutoRecon/scripts/loot.sh
        clear ;;
	2) clear
        validaccountfile=$(ls $home/workspaces/$workspace/Users/emails | grep -E "enum_valid*")
        echo "Valid Emails"
        echo "-------------------"
        echo "first 10 Emails in list"
        head -10 $home/workspaces/$workspace/Users/emails/$validaccountfile
        read -n 1 -r -s -p "Press any key to return to Loot Menu" key
        clear ;;
	3) clear
        validsprayfile=$(ls $home/workspaces/$workspace/Users/emails | grep -E "enum_spray*")
        echo "Compromised Emails"
        echo "-------------------"
        cat $home/workspaces/$workspace/Users/emails/spray/$validsprayfile
        read -n 1 -r -s -p "Press any key to return to Loot Menu" key
        clear ;;
    4) clear
        echo "Open Ports and services Found"
        echo "-------------------"
        echo "to be completed when nmap scanning file is comeplete"
        read -n 1 -r -s -p "Press any key to return to Loot Menu" key
        clear ;;
    5) clear 
        validsprayfile=$(ls $home/workspaces/$workspace/Users/emails | grep -E "enum_spray*")
        echo "creating zip file"
        zip $home/workspaces/$workspace/loot/Loot.zip $home/workspaces/$workspace/Users/emails/spray/$validsprayfile $home/workspaces/$workspace/Users/emails/$validaccountfile $home/workspaces/$workspace/DNSInfo/SubBrute.txt $home/workspaces/$workspace/DNSInfo/DNSZoneTransfer.txt $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
        echo "Zipfile located in $home/workspaces/$workspace/loot"
        read -n 1 -r -s -p "Press any key to return to Loot Menu" key
        clear ;;
	8) /opt/AutoRecon/scripts/AutoEnum.sh ;;

	*) echo "Please Choose a number from the menu";;

esac
