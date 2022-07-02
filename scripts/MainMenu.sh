source /opt/AutoRecon/scripts/functions.sh
source /opt/AutoRecon/Variables/GVar.sh


bannerMain()
echo ""
echo "Please select an Option"
echo "1) Set Up New Workspace"
echo "2) Select an existing workspace"
echo "3) Exit AutoRecon "
read opt;
    case $opt in
        1) CreateWorkspace;;
        2) 
            read -p "Please enter the CompanyName" workspace
            /opt/AutoRecon/scripts/WorkspaceMenu.sh
            ;;  
        3) exit ;;
        *) echo "No Option chosen";;
    esac
