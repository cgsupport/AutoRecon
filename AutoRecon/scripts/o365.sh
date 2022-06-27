clear
read -p "Please enter workspace name: " workspace
echo $workspace
echo "Setting email Format"
EmailFormat=$(cat ~/workspaces/$workspace/Var/emailformat.txt)
echo "Creating User List"
read -p "Please enter the full name of the company you would like to Enumerate: " CompName
python3 /opt/CrossLinked/crosslinked.py -f $EmailFormat  "'$CompName'" -o ~/workspaces/$workspace/Users/emails/EmailList.txt
echo "email list Complete"
head -10 ~/workspaces/$workspace/Users/emails/EmailList.txt
read -p "Would you like to Continue to Validation/spray(Active/Bruteforce): " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
	    /opt/AutoRecon/scripts/AutoEnum.sh
	    exit
fi

echo "it works"



