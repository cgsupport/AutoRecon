echo "Setting up workspace"
##################################################

echo "Checking for Workspace folder"
if [ ! -f ~/workspaces]
then 
	mkdir ~/workspaces
else 
	echo "workspaces folder found"
fi

echo "Available workspaces"
ls ~/workspaces
read -p "enter Company name: " COMPANYNAME

if [ -f ~/workspaces/$COMPANYNAME ]; then 
	echo "Workspace exists Going to Main Menu"
	/opt/AutoRecon/scripts/AutoEnum.sh
	exit 0
else 
	echo "Workspace does not exist. Creating working directory"
fi

echo "making Working Directories"
echo "creating Main Working directory"
mkdir ~/workspaces/$COMPANYNAME
cd ~/workspaces/$COMPANYNAME 
echo "creating NMAP folder"
mkdir NMAP
echo "creating User account folder"
mkdir ~/workspaces/$COMPANYNAME/Users
mkdir ~/workspaces/$COMPANYNAME/Users/emails
mkdir ~/workspaces/$COMPANYNAME/Users/Passwords
mkdir ~/workspaces/$COMPANYNAME/Users/ADAccounts
mkdir ~/workspaces/$COMPANYNAME/Users/emails/spray
echo "Creating Variable files"
mkdir ~/workspaces/$COMPANYNAME/Var
touch ~/workspaces/$COMPANYNAME/Var/domain.txt
touch ~/workspaces/$COMPANYNAME/Var/webaddress.txt
mkdir ~/workspaces/$COMPANYNAME/Var/tmp
touch ~/workspaces/$COMPANYNAME/Var/emailformat.txt
mkdir ~/workspaces/$COMPANYNAME/DNSInfo
echo "creating notes"
touch ~/workspaces/$COMPANYNAME/Notes.txt
echo "workspace Set up"
tree ~/workspaces/$COMPANYNAME
read -n 1 -r -s -p "Press any key to continue" key
#################################################
#network details
#################################################
clear 
echo "Network details"
read -p "please enter external address: " EXTADDR
mkdir ~/workspaces/$COMPANYNAME/NMAP/External
echo $EXTADDR > ~/workspaces/$COMPANYNAME/NMAP/External/extTargets.txt
read -n 1 -r -s -p "Press any key to continue" key
##################################################
#user details 
##################################################
clear
echo "email Format/validator"
echo "please enter email format:" 
echo "format example" 
echo "{f}{l}@domain.com"
echo "{first}.{last}@domain.com"
echo "this is using crosslinked for more formats see /opt/crosslinked.py -h" 
read -p "Email Format:  " emailformat
echo "$emailformat" >> ~/workspaces/$COMPANYNAME/Var/emailformat.txt
echo "email format created"
cat ~/workspaces/$COMPANYNAME/Var/emailformat.txt
read -n 1 -r -s -p "if email format looks correct press any key to set domain information" key

######################
# DNS enumeration #### 
#######################
#domain name lookup 
echo "Finding domain name from $EXTADDR"
nslookup $EXTADDR > ~/workspaces/$COMPANYNAME/Var/domain.txt
#formating nslookup output
grep 'name' ~/workspaces/$COMPANYNAME/Var/domain.txt > ~/workspaces/$COMPANYNAME/Var/tmp/domain.txt
# selecting only string after =
cat ~/workspaces/$COMPANYNAME/Var/tmp/domain.txt | cut -d "=" -f2- > ~/workspaces/$COMPANYNAME/Var/domain.txt
# removing . after string
sed '$ s/.$//' ~/workspaces/$COMPANYNAME/Var/domain.txt > ~/workspaces/$COMPANYNAME/Var/tmp/domain.txt
#removing whitespaces
cat ~/workspaces/$COMPANYNAME/Var/tmp/domain.txt | sed 's/ //g' > ~/workspaces/$COMPANYNAME/Var/domain.txt
cat ~/workspaces/$COMPANYNAME/Var/domain.txt
echo "IP: $EXTADDR"
echo "Domain:"
cat ~/workspaces/$COMPANYNAME/Var/domain.txt

############################

read -n 1 -r -s -p "WorkPlace and Variables Set Up Press any key to Continue to main Menu" key

/opt/AutoRecon/scripts/AutoEnum.sh

















