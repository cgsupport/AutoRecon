echo "Setting up workspace"
##################################################
home=$(echo ~)
echo "Checking for Workspace folder"

if [ ! -d "$home/workspaces" ]; then 
	mkdir $home/workspaces
else 
	echo "workspaces folder found"
fi

echo "Available workspaces"
ls $home/workspaces
read -p "enter Company name: " COMPANYNAME

if [ -d $home/workspaces/$COMPANYNAME ]; then 
	echo "Workspace exists Going to Main Menu"
	/opt/AutoRecon/scripts/AutoEnum.sh
	exit 0
else 
	echo "Workspace does not exist. Creating working directory"
fi

echo "making Working Directories"
echo "creating Main Working directory"
mkdir $home/workspaces/$COMPANYNAME
cd $home/workspaces/$COMPANYNAME 
echo "creating NMAP folder"
mkdir NMAP
echo "creating User account folder"
mkdir $home/workspaces/$COMPANYNAME/Users
mkdir $home/workspaces/$COMPANYNAME/Users/emails
mkdir $home/workspaces/$COMPANYNAME/Users/Passwords
mkdir $home/workspaces/$COMPANYNAME/Users/ADAccounts
mkdir $home/workspaces/$COMPANYNAME/Users/emails/spray
echo "Creating Variable files"
mkdir $home/workspaces/$COMPANYNAME/Var
touch $home/workspaces/$COMPANYNAME/Var/domain.txt
touch $home/workspaces/$COMPANYNAME/Var/webaddress.txt
mkdir $home/workspaces/$COMPANYNAME/Var/tmp
touch $home/workspaces/$COMPANYNAME/Var/emailformat.txt
mkdir $home/workspaces/$COMPANYNAME/DNSInfo
echo "creating notes"
touch $home/workspaces/$COMPANYNAME/Notes.txt
echo "workspace Set up"
tree $home/workspaces/$COMPANYNAME
read -n 1 -r -s -p "Press any key to continue" key
#################################################
#network details
#################################################
clear 
echo "Network details"
read -p "please enter external address: " EXTADDR
mkdir $home/workspaces/$COMPANYNAME/NMAP/External
echo $EXTADDR > $home/workspaces/$COMPANYNAME/NMAP/External/extTargets.txt
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
echo "$emailformat" >> $home/workspaces/$COMPANYNAME/Var/emailformat.txt
echo "email format created"
cat $home/workspaces/$COMPANYNAME/Var/emailformat.txt
read -n 1 -r -s -p "if email format looks correct press any key to set domain information" key

######################
# DNS enumeration #### 
#######################
#domain name lookup 
echo "Finding domain name from $EXTADDR"
nslookup $EXTADDR > $home/workspaces/$COMPANYNAME/Var/domain.txt
#formating nslookup output
grep 'name' $home/workspaces/$COMPANYNAME/Var/domain.txt > $home/workspaces/$COMPANYNAME/Var/tmp/domain.txt
# selecting only string after =
cat $home/workspaces/$COMPANYNAME/Var/tmp/domain.txt | cut -d "=" -f2- > $home/workspaces/$COMPANYNAME/Var/domain.txt
# removing . after string
sed '$ s/.$//' $home/workspaces/$COMPANYNAME/Var/domain.txt > $home/workspaces/$COMPANYNAME/Var/tmp/domain.txt
#removing whitespaces
cat $home/workspaces/$COMPANYNAME/Var/tmp/domain.txt | sed 's/ //g' > $home/workspaces/$COMPANYNAME/Var/domain.txt
cat $home/workspaces/$COMPANYNAME/Var/domain.txt
echo "IP: $EXTADDR"
echo "Domain:"
cat $home/workspaces/$COMPANYNAME/Var/domain.txt

############################

read -n 1 -r -s -p "WorkPlace and Variables Set Up Press any key to Continue to main Menu" key

/opt/AutoRecon/scripts/AutoEnum.sh

















