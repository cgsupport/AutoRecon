echo "installing Dependancies- this may take some time" 
apt install mlocate && apt install dnsmap && apt install dig && apt install nmap && && apt install python3 && apt install python3-pip && apt install git


echo "moving to /opt and installing tools"
cd /opt
git clone https://github.com/m8r0wn/CrossLinked.git
git clone https://github.com/0xZDH/o365spray.git

echo "creating Aliases" 
echo "alias AutoRecon='/opt/AutoRecon/scripts/AutoEnum.sh'" >> /home/*/.bashrc
echo ""
echo "Please set up 3rd party tools under non root user"
echo ""
echo "--------------------------------------------"
echo "Crosslinked"
echo ""
echo "cd /opt/Crosslinked and run pip3 install -r requirements.txt"
echo ""
echo "--------------------------------------------"
echo "o365spray"
echo ""
echo "cd /opt/o365spray && pip3 install -r requirements.txt"
echo ""
echo "--------------------------------------------"
echo "--------------------------------------------"
read "Installation complete. to use type AutoRecon into Terminal"
exit

