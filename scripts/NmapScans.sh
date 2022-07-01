home=$(echo ~)
echo "Available workspaces"
ls $home/workspaces
echo "======================="
read -p "enter Company name: " COMPANYNAME

if ! [ -f $home/workspaces/$COMPANYNAME ]; then
	        read "Workspace does not exist please set up workspace first"
		    /opt/AutoRecon/scripts/AutoEnum.sh
			exit  
				
fi
echo "Workspace does exist. Continuing to NMAP Menu"
sleep 2
clear 



echo "====================================="
echo "----------NMAP Main Menu-------------"
echo "====================================="
echo "Current Scans running:"
echo "====================================="
echo "Target(s): "
echo "Excluded Host(s): "
echo "Firewalls found:"
echo "setting "
echo "====================================="
echo "Choose An Option"
echo "----------------"
echo "1) Firewall Detection"
echo "2) Default Scans"
echo "3) Port Scan"
echo "4) Service Scan"
echo "5) "
read wordlistChoice;
case $wordlistChoice in 
	1) wordlist="Domain-small.txt";;
	2) wordlist="Domain-medium.txt";;
	3) wordlist="Domain-large.txt";;
	4) wordlist="Domain-massive.txt";;
	*) wordlist="Domain-small.txt";;
esac




EXTADDR=$(cat $home/workspaces/$COMPANYNAME/NMAP/External/extTargets.txt)
########### Perform Ext Scan ####################
echo "Starting External NMAP scan"
echo " running nmap against target $EXTADDR"
echo""
nmap -T2 -p- -iL $home/workspaces/$COMPANYNAME/NMAP/External/extTargets.txt -oA $home/workspaces/$COMPANYNAME/NMAP/External/externaltcp -Pn &>/dev/null & 
nmap -T2 -sU -iL $home/workspaces/$COMPANYNAME/NMAP/External/extTargets.txt -oA $home/workspaces/$COMPANYNAME/NMAP/External/externaludp -Pn &>/dev/null &
echo ""
echo "Scans running in background"
echo ""
echo "created files"
tree $home/workspaces/$COMPANYNAME/NMAP/External
echo""
echo"---------------------------------------"

read -n 1 -r -s -p " Press any key to Continue to main Menu" key

/opt/AutoRecon/scripts/AutoEnum.sh

