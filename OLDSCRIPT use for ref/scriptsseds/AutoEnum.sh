clear
Whatuser=$(tty | tr -d dev | cut -c3-)
home=$(echo ~)
nmapscanrunning="false"
PassSprayStatus="false"

echo "----------------------------------"
echo "AutoEnum" 
echo "----------------------------------"
echo "created by matt"
echo "--------------------------------------"
echo "use how you wish but its on you..."
echo "-------------------------------------"
echo "-------------------------------------"
echo ""
echo ""
echo "checking for workspace folder" 
read -p "please enter the name of the workspace folder " workspace

if [ ! -d "$home/workspaces/$workspace" ]; then
	echo "$DIR directory does not exist. Setting up workspace"
	/opt/AutoRecon/scripts/workspace.sh
	exit
fi

sleep 3
clear 

nmapproc=$(ps -aux | grep "$Whatuser" | grep "nmap" | grep "$workspace" | grep -v "grep")
PassSpray=$(ps -aux | grep "$Whatuser" | grep "o365spray" | grep "$workspace" | grep -v "grep")

if ! [ -n $nmapproc  ]; then

	nmapscanrunning="true"
fi

if ! [ -n $PassSpray ]; then

	PassSprayStatus="true"
fi

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
echo "ExternalIP" 
cat $home/workspaces/$workspace/NMAP/External/extTargets.txt
echo ""
echo "Domain: " 
cat $home/workspaces/$workspace/Var/domain.txt
echo ""
echo "Email Format" 
cat $home/workspaces/$workspace/Var/emailformat.txt
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
echo "1 - Set-Up Workspace"
echo "2 - Domain enumeration"
echo "3 - o365 enum/validation/spray"
echo "4 - NMAP scans"
echo "5 - View Loot"
echo "7 - Change Workspace"
echo "8 - Exit"
read options;
case $options in 
	1) /opt/AutoRecon/scripts/workspace.sh;;
	2) /opt/AutoRecon/scripts/DomainEnum.sh;;
	3) /opt/AutoRecon/scripts/o365.sh;;
	4) /opt/AutoRecon/scripts/NmapScans.sh;;
	5) /opt/AutoRecon/scripts/loot.sh;;
	6) /opt/AutoRecon/scripts/AutoEnum.sh;;
	7) exit;;
	*) echo "Please Choose a number from the menu"
esac
