clear
echo "----------------------------------"
echo "AutoEnum" 
echo "----------------------------------"
echo "created by matt"
echo "--------------------------------------"
echo "use how you wish but its on you..."
echo "-------------------------------------"
echo "-------------------------------------"
clear
echo "checking for workspace folder" 
read -p "please enter the name of the workspace folder " workspace

if [[ -d ~/workspaces/$workspace ]]

then
	echo "workspace exists"
else 
	echo "$FILE does not exist please set up workspace" 
        
fi

echo "=================================="
echo "---------Workspaces---------------"
echo "=================================="
ls ~/workspaces
echo ""
echo ""
echo "=================================="
echo ""
echo ""
echo "=================================="
echo "        Current settings          "
echo ""
echo "=================================="
echo ""
echo "Script running as:  $USER"
echo "Workspace location: " ~/workspaces/$workspace
echo "----------------------------------"
echo "Target Variables"
echo "================================="
echo "ExternalIP" 
cat ~/workspaces/$workspace/NMAP/External/extTargets.txt
echo ""
echo "Domain: " 
cat ~/workspaces/$workspace/Var/domain.txt
echo ""
echo "Email Format" 
cat ~/workspaces/$workspace/Var/emailformat.txt
echo ""
echo "=================================="
echo ""
echo "----------------------------------"
echo "-----------Main Menu--------------"
echo "----------------------------------"
echo ""
echo "1 - Set-Up Workspace"
echo "2 - Domain enumeration"
echo "3 - o365 enum/validation/spray"
echo "4 - NMAP scans" 
echo "5 - All available scans"
echo "6 - View Loot"
echo "7 - Change Workspace"
echo "8 - Exit"
read options;
case $options in 
	1) /opt/AutoRecon/scripts/workspace.sh;;
	2) /opt/AutoRecon/scripts/DomainEnum.sh;;
	3) /opt/AutoRecon/scripts/o365.sh;;
	4) /opt/AutoRecon/scripts/NmapScans.sh;;
	5) /opt/AutoRecon/scripts/allscans.sh;;
	6) /opt/AutoRecon/scripts/Loot.sh;;
	7) /opt/AutoRecon/scripts/AutoEnum.sh;;
	8) exit;;
	*) echo "Please Choose a number from the menu"
esac
