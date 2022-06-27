echo "Available workspaces"
ls ~/workspaces
read -p "enter Company name: " COMPANYNAME

if [ ! -f ~/workspaces/$COMPANYNAME ]; then
	        echo "Workspace does not exist please set up workspace first"
		        /opt/AutoRecon/scripts/AutoEnum.sh
			        exit 0
			else 
				echo "Workspace does exist. Running Nmap Scans"
fi

$EXTADDR=$(cat ~/workspaces/$COMPANYNAME/NMAP/External/extTargets.txt)
########### Perform Ext Scan ####################
echo "Starting External NMAP scan"
echo " running nmap against target $EXTADDR"
nmap -v -T2 -p- -iL ~/$COMPANYNAME/NMAP/External/extTargets.txt -oA ~/$COMPANYNAME/NMAP/External/externaltcp -Pn & nmap -v -T2 -sU -iL ~/$COMPANYNAME/NMAP/External/extTargets.txt -oA ~/$COMPANYNAME/NMAP/external/externaludp -Pn
echo "External Nmap complete and saved as externaltcp and externalUDP"
tree ~/$COMPANYNAME/NMAP

read -n 1 -r -s -p "Scan Finished - Press any key to Continue to main Menu" key

/opt/AutoRecon/scripts/AutoEnum.sh

