#env variables
home=$(echo ~)
crosslinked=$(locate crosslinked.py)
o365spraydir=$(locate o365spray.py)
# Company name 
workspace=""
#
#Running Processes
NmapRunning="false"
o365enumRunning="false"
nmapproc=$(ps -aux | grep "$Whoami" | grep "nmap" | grep "$workspace" | grep -v "grep")
PassSpray=$(ps -aux | grep "$Whoami" | grep "o365spray" | grep "$workspace" | grep -v "grep")
# Set Workspace Variables 
workspaceVarFile="$home/workspaces/$workspace/Var/WorkspaceVars.sh"
