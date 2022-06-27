# AutoRecon
Matts Auto Recon script (TESTING)

Dependancies
apt install mlocate
apt install dnsmap
apt install dig
apt install Nmap

other tools that are required (all these tools need to be located in /opt/ and set up to work) 
https://github.com/m8r0wn/CrossLinked.git
https://github.com/0xZDH/o365spray.git


Set up 
step 1 git clone https://github.com/cgsupport/AutoRecon.git and move to /opt
step 2 chmod RWX for current user on all .sh files in folder 
step 3 add to bashrc/bash_aliases the following line 
      - alias AutoRecon= /opt/AutoRecon/scripts/AutoEnum.sh
step 4 Run AutoRecon


TODO: 
- Fix formatting of ASCII art 
- Test all features and find snags 
