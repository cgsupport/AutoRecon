source /opt/AutoRecon/scripts/functions.sh
source /opt/AutoRecon/Variables/GVar.sh
source $home/workspaces/$workspace/Var/WorkspaceVars.sh
cd $home
echo "=================================="
echo "---------Workspaces---------------"
echo "=================================="
ls $home/workspaces
echo ""
echo ""
echo "=================================="
echo "        Current settings          "
echo "=================================="
echo ""
echo "Script running as:  $USER"
echo "Workspace location: " $home/workspaces/$workspace
echo ""
echo "================================="
echo "Target Variables"
echo "================================="
echo ""
echo "ExternalIP: $EXTADDR" 
echo ""
echo "Domain: $domain " 
echo ""
echo "Email Format: $emailformat" 
echo ""
echo "================================="
echo "Running processes"
echo "================================="
echo ""
echo "NMAP scans Running?"
echo $nmapscanrunning
echo ""
echo "Password spray running?"
echo $PassSprayStatus
echo "=================================="
echo ""
echo "----------------------------------"
echo "-----------Main Menu--------------"
echo "----------------------------------"
echo ""
echo "1 - Domain enumeration"
echo "2 - o365 enum/validation/spray"
echo "3 - NMAP scans"
echo "4 - View Loot"
echo "7 - Change Workspace"
echo "8 - Exit"
read options;
case $options in 
	1) DomainEnum.sh;;
	2) o365.sh;;
	3) NmapScans.sh;;
	4) loot.sh;;
	7) setWorkspace;;
	8) exit;;
	*) echo "Please Choose a number from the menu"
esac