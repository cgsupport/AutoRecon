#Sources
source /opt/AutoRecon/scripts/Variables/GVar.sh
source /opt/AutoRecon/scripts/Variables/WorkspaceMenu.sh

function checkWorkspacesFolderExists () {
   
    if [ ! -d "$home/workspaces" ]; then
	echo "Workspace folder does not exist. Creating Workspace folder"
	mkdir $home/workspaces
fi
echo "Workspace folder found"
clear
}

function checkCompanyNameFolderExists () {

    read -p "Please enter Company Name" workspace
    if [ ! -d "$home/workspaces/$workspace" ]; then
	echo "No Workspace Found"
    read -p "Would you like to create a new Company folder(y/N)" opt
    read options;
        case $options in 
	        [Y=y]) /opt/AutoRecon/scripts/CreateWorkspace.sh;;
	        *) checkCompanyNameFolderExists ;;
        esac
    fi
clear
}
function setWorkspace (){
    read -p "Please enter the CompanyName" workspace
    /opt/AutoRecon/scripts/WorkspaceMenu.sh
    
}
function runningNmapScans () {
    
    if ! [ -n $nmapproc  ]; then

	     NmapRunning="True"
    fi

    if ! [ -n $PassSpray ]; then

         o365enumRunning="True"
    fi
 
}


function bannerMain () {
    
    echo "======================================================"
    echo "                _        ______                       "
    echo "     /\        | |      |  ____|                      "
    echo "    /  \  _   _| |_ ___ | |__   _ __  _   _ _ __ ___  "
    echo "   / /\ \| | | | __/ _ \|  __| | '_ \| | | | '_ ` _ \ "
    echo "  / ____ \ |_| | || (_) | |____| | | | |_| | | | | | |"
    echo " /_/    \_\__,_|\__\___/|______|_| |_|\__,_|_| |_| |_|"
    echo "======================================================"
    echo "Created By : Matt"
    echo "With Help from: Yakub and Ant"
    echo "DISCLAIMER: This script is for targets you have"
    echo " permission to engage - I hold no responsibility for "
    echo "your actions or your prison sentence"
    echo "======================================================"
    echo "Current Set Variables"
    echo "Running User: $USER "
    echo "Workspace Exists: "
    echo "Existing Working Directories"
    echo "======================================================"
    ls $home/workspaces
    echo "======================================================"

}

function CreateWorkspace () {

        echo "Checking for Workspaces folder"
        checkWorkspacesFolderExists
        echo "Creating Working Directories"
        echo "============================"
        mkdir $home/workspaces/$workspace
        cd $home/workspaces/$workspace
        cp /opt/AutoRecon/Variables/WorkspaceVars.sh $home/workspaces/$workspace/Var/WorkspaceVars.sh
        mkdir Var
        mkdir -p loot/{Users,DNSInfo,Nmap}
        touch Notes
        echo "$workspace folder created"
        /opt/AutoRecon/scripts/WorkspaceMenu.sh
        clear
        echo "IP Address"
        echo "=================================="
        read -p "please enter external address: " EXTADDR
        Domainnamelookup
        clear
        echo "email Format/validator"
        echo "======================"
        echo "please enter email format" 
        echo "format example" 
        echo "{f}{l}@domain.com"
        echo "{first}.{last}@domain.com"
        echo "this is using crosslinked for more formats see /opt/crosslinked.py -h" 
        read -p "Email Format:  " emailformat
        echo "email format created"
        echo "$emailformat"
        read -n 1 -r -s -p "if email format looks correct press any key to set domain information" key
        clear
        read -n 1 -r -s -p "WorkPlace and Variables Set Up Press any key to Continue to main Menu" key

}

function Domainnamelookup () {
    DomainName=$(nslookup $EXTADDR | grep 'name'| cut -d "=" -f2- | sed '$ s/.$//' | sed 's/ //g')
}

function GenerateEmailList () {

    echo "creating email list"
    read -p "Please enter the full name of the company you would like to Enumerate: " CompName
    python3 $crosslinked -f $EmailFormat "'$CompName'" -o $home/workspaces/$workspace/Loot/Users/GatheredEmails.txt
    echo "email list Complete"
    head -10 $home/workspaces/$workspace/Loot/Users/GatheredEmails.txt
    sleep 3
    clear


}