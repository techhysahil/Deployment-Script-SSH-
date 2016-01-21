#!bin/bash

########################################
######### Deploy Script ################
########################################

# install sshpass for by default addingadding password in script 

# Colors Codes
COLOR_OFF='\033[0m'   # unsets color to term fg color
RED='\033[0;31m'      # red
GREEN='\033[0;32m'    # green
YELLOW='\033[0;33m'   # yellow
MAGENTA='\033[0;35m'  # magenta
CYAN='\033[0;36m'     # cyan


# Staging env variable
STAGING_PORT=22
STAGING_USERNAME="techhysahil"
STAGING_SERVER=23.229.183.161
STAGING_LOCAL_DIR='/Users/sahil/NodeAngular-Application'
STAGING_REMOTE_DIR="public_html/Projects/staging"

# Production env variable
PRODUCTION_PORT=22
PRODUCTION_USERNAME="techhysahil"
PRODUCTION_SERVER=23.229.183.161
PRODUCTION_LOCAL_DIR='/Users/sahil/NodeAngular-Application'
PRODUCTION_REMOTE_DIR="public_html/Projects/"

# Ask password from User
read -s -p "Enter SSH Password :" sshpass
# OR you can add password in sshpass itself like sshpass='your_password'


if [[ $1 == "staging" ]]; then
	printf "${YELLOW}This is staging deployment${COLOR_OFF}\n"
    cd $STAGING_LOCAL_DIR
	sshpass -p $sshpass ssh -v -p $STAGING_PORT $STAGING_USERNAME@$STAGING_SERVER 'cd public_html/Projects/cwd/ && cd staging'
    sshpass -p $sshpass scp -v -r /Users/sahil/NodeAngular-Application techhysahil@23.229.183.161:~/public_html/Projects/cwd/staging
elif [[ $1 == "production" ]]; then
	printf "${YELLOW}This is production deployment${COLOR_OFF}\n"
	sshpass -p $sshpass ssh -v -p $PRODUCTION_PORT $PRODUCTION_USERNAME@$PRODUCTION_SERVER ' echo "Remote hostname :" $$ hostname &&\
		 cd public_html/Projects/ && git pull origin master'

	if [[ $? -eq 0 ]]; then
    	echo "File Transfered successfull"
    elif [[ $? -eq 1 ]]; then
    	echo "Error in Transfering files"
    fi

else
	printf "${YELLOW}Please add a valid enviromment as first argument${COLOR_OFF}\n"
fi