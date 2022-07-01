clear
home=$(echo ~)
read -p "please enter the name of the workspace folder " workspace

clear 
dns
echo "----------------------------------"
echo "-----------LOOT-------------------"
echo "----------------------------------"
echo ""
echo "1 - DNS Loot"
echo "2 - Valid Emails"
echo "3 - Compromised accounts(email spray)"
echo "4 - Open Ports & found services"
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
        clear;;
	2) clear
        echo "Valid Emails"
        echo "-------------------"
        read -n 1 -r -s -p "Press any key to return to Loot Menu" key
        clear;;
	3) clear
        echo "Compromised Emails"
        echo "-------------------"
        read -n 1 -r -s -p "Press any key to return to Loot Menu" key
        clear ;;
    4) clear
        echo "Open Ports and services Found"
        echo "-------------------"
        read -n 1 -r -s -p "Press any key to return to Loot Menu" key
        clear ;;
	8) /op/AutoRecon/scripts/AutoEnum.sh;;
	*) echo "Please Choose a number from the menu"
esac
