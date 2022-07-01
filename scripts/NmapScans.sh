home=$(echo ~)
echo "Available workspaces"
ls $home/workspaces
echo "======================="
read -p "enter Company name: " COMPANYNAME

if [[! -f $home/workspaces/$COMPANYNAME]]; then
	        read "Workspace does not exist please set up workspace first"
		        /opt/AutoRecon/scripts/AutoEnum.sh
			        exit 
			else 
				echo "Workspace does exist. Running Nmap Scans"
fi

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

