# <h1>AutoRecon</h1>
Matts Auto Recon script (TESTING)

<h2>Dependancies</h2>
<br>
<li>apt install mlocate</li>
<li>apt install dnsmap</li>
<li>apt install dig</li>
<li>apt install Nmap</li>

<h3>other tools that are required (all these tools need to be located in /opt/ and set up to work) </h3>
<br>
<li>https://github.com/m8r0wn/CrossLinked.git</li>
https://github.com/0xZDH/o365spray.git</li>


<h2>Set up</h2>
<br>
<li>step 1 git clone https://github.com/cgsupport/AutoRecon.git and move to /opt</li>
<li>step 2 chmod RWX for current user on all .sh files in folder</li>
<li>step 3 add to bashrc/bash_aliases the following line 
      - alias AutoRecon= /opt/AutoRecon/scripts/AutoEnum.sh</li>
<li>step 4 Run AutoRecon</li>


<h2> Alternative set up (testing) </h2>
<br>
<li>git clone https://github.com/cgsupport/AutoRecon.git</li>
<li>run dependancies.sh as sudo</li> 

<h2>TODO: </h2>
<br>
<li>- Fix formatting of ASCII art </li>
<li>- Test all features and find snags </li>
