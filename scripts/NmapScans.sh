home=$(echo ~)

echo "Available workspaces"
ls $home/workspaces
echo "======================="
read -p "Enter Company name: " workspace


if [ ! -d $home/workspaces/$workspace ]; then
	read "Workspace does not exist please set up workspace first"
	/opt/AutoRecon/scripts/AutoEnum.sh  
	exit			
fi

echo "Workspace does exist. Continuing to NMAP Menu"
sleep 2
clear 

FirewallStatus=false
EXTADDR=$(cat $home/workspaces/$workspace/NMAP/External/extTargets.txt)
echo "====================================="
echo "----------NMAP Main Menu-------------"
echo "====================================="
echo "Current Scans running:"
echo "====================================="
echo "Target(s): $EXTADDR "
echo "Excluded Host(s): 'cat $home/workspaces/$workspace/NMAP/External/excludedhosts.TXT'  "
echo "Firewall:$FirewallStatus"
echo "Ports Open"
egrep -v "^#|Status: Up" | cut -d' ' -f4- | sed -n -e 's/Ignored.*//p' | tr ',' '\n' | sed -e 's/^[ \t]*//' 
echo "====================================="
echo "Choose An Option"
echo "----------------"
echo "0) Exclude Hosts"
echo "1) Firewall Detection"
echo "2) Default Scans"
echo "3) Port Scan"
echo "4) Service Scan"
read NmapChoice;
case $NmapChoice in 
	0) clear 
		
		echo "Excluding hosts"
		read -p "please enter the IP address of the host you want to exclude" ExHosts
		echo "$ExtHosts" > $home/workspaces/$workspace/NMAP/External/excludedhosts.TXT
		EXFLAG="--excludefile $home/workspaces/$workspace/NMAP/External/excludedhosts.txt"
		echo "Excluded Host(s): 'cat $home/workspaces/$workspace/NMAP/External/excludedhosts.TXT'"		
		ExtFlagIO="true"
		
		clear ;;
	1) clear 
		echo "NMAP Firewall scan"
		echo "Testing Target for Firewall"
		$nmapcheck=$(nmap -sW $EXTADDR )
		if [[ "$nmapcheck" == *"are filtered"* ]]; then
			FirewallStatus=true
			echo "Firewall Enabled"
		fi
		
		echo "Firewall Disabled"
		clear ;;
	2) clear 
		########### Perform Ext Scan ####################
		echo "Starting External NMAP scan"
		echo " running nmap against target $EXTADDR"
		echo ""
		nmap -T2 -p- -iL $home/workspaces/$workspace/NMAP/External/extTargets.txt -oA $home/workspaces/$workspace/NMAP/External/externaltcp -Pn &>/dev/null & 
		nmap -T2 -sU -iL $home/workspaces/$workspace/NMAP/External/extTargets.txt -oA $home/workspaces/$workspace/NMAP/External/externaludp -Pn &>/dev/null &
		echo ""
		echo "Scans running in background"
		echo ""
		echo "created files"
		tree $home/workspaces/$workspace/NMAP/External
		echo ""
		echo "---------------------------------------"
		read -n 1 -r -s -p " Press any key to Continue to main Menu" key	
		clear ;;
	3) clear

		echo "NMAP Port scans"

		nmap -p- $EXFLAG $EXTADDR -Pn -oA $home/workspaces/$workspace/NMAP/External/externaltcp -Pn &>/dev/null & 
		nmap -sU -p- $EXTFLAG $EXTADDR -oA $home/workspaces/$workspace/NMAP/External/externaltcp -Pn &>/dev/null & 
		
		cat $home/workspaces/$workspace/NMAP/External/externaltcp.gnmap |egrep -v "^#|Status: Up" | cut -d' ' -f4- | sed -n -e 's/Ignored.*//p' | sed -e 's/^[ \t]*//' | tr -d "/"" ""a-z""-" > $home/workspaces/$workspace/NMAP/External/TargetPorts.txt
		
		TargetPorts=$(cat $home/workspaces/$workspace/NMAP/External/TargetPorts.txt)
		cat $home/workspaces/$workspace/NMAP/External/TargetPorts.txt
	
		read -n 1 -r -s -p " Press any key to Continue to main Menu" key
		clear ;;
	4) clear
		echo "Running Enumerating Services"
		nmap -sV $EXTADDR -p $TargetPorts -Pn -oA $home/workspaces/$workspace/NMAP/External/ServiceScan
		read -n 1 -r -s -p " Press any key to Continue to main Menu" key	
		clear ;;
esac






