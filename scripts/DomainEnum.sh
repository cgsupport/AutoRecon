clear
home=$(echo ~)

read -p "Please enter the workspace name:  " workspace

ExtAddr=$(cat $home/workspaces/$workspace/NMAP/External/extTargets.txt)
Domain=$(cat $home/workspaces/$workspace/Var/domain.txt)

clear
echo "Performing the following automated checks"
echo ""
echo "DNS Record check"
echo "will obtain all DNS records for given domain"
echo ""
echo ""
echo "DNS Zone Transfer"
echo "will check for succesful zone transfers"
echo ""
echo ""
echo "DNSenum xml/visual output" 
echo "will run DNSenum and output it to xml file in workspace"
echo "this will be done in stages" 
echo "1. DNS Records"
echo "2. Zone Transfer"
echo "3. Subdomain Bruteforce"
echo ""
echo ""
echo ""
sleep 5
clear
#Dns Record Check 
echo "Finding DNS Records"
touch $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
echo "-----------------" > $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
echo "A Records" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
echo "-----------------" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
dig +noall +answer @1.1.1.1 $Domain A >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt

echo "-----------------" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
echo "AAAA Records" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
echo "-----------------" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
dig +noall +answer @1.1.1.1 $Domain AAAA >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt

echo "-----------------" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
echo "NS Records" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
echo "-----------------" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
dig +noall +answer @1.1.1.1 $Domain ns >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt

echo "-----------------" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
echo "CNAME Records" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
echo "-----------------" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
dig +noall +answer @1.1.1.1 $Domain cname >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt

echo "-----------------" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
echo "TXT Records" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
echo "-----------------" >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt
dig +noall +answer @1.1.1.1 $Domain txt >> $home/workspaces/$workspace/DNSInfo/DNSRecords.txt

echo ""

cat $home/workspaces/$workspace/DNSInfo/DNSRecords.txt

sleep 5
clear
################################################################
#DNS Zone transfer check 
echo "checking to see if DNS transfer is available"
touch $home/workspaces/$workspace/DNSInfo/DNSZoneTransfer.txt
dig @1.1.1.1 $Domain axfr > $home/workspaces/$workspace/DNSInfo/DNSZoneTransfer.txt
cat $home/workspaces/$workspace/DNSInfo/DNSZoneTransfer.txt

sleep 5
clear
####################################################################
#Subdomain Bruteforce
read -p "Would you like to Continue to Subdomain Bruteforce): " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
	/opt/AutoRecon/scripts/AutoEnum.sh 
	exit
fi

echo "please select a wordlist(default:5000 Wordlist)"
echo "1) Small(5000 + words )"
echo "2) Medium(20000 + words)"
echo "3) Large(100000 + words)"
echo "4) Massive (Be careful 150000 + words )"
read wordlistChoice;
case $wordlistChoice in 
	1) wordlist="Domain-small.txt";;
	2) wordlist="Domain-medium.txt";;
	3) wordlist="Domain-large.txt";;
	4) wordlist="Domain-massive.txt";;
	*) wordlist="Domain-small.txt";;
esac

dnsmap $Domain -w /opt/AutoRecon/Wordlists/$wordlist -r $home/workspaces/$workspace/DNSInfo/SubBrute.txt

echo "Returning to menu"
/opt/AutoRecon/scripts/AutoEnum.sh


#
#
#
###
