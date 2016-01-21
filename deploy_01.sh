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


printf "${YELLOW}This is staging deployment${COLOR_OFF}\n"
    cd $STAGING_LOCAL_DIR
	sshpass -p $sshpass ssh -v -p $STAGING_PORT $STAGING_USERNAME@$STAGING_SERVER \
	'cd public_html/Projects/cwd/ && \
	if [ ! -d staging ]; then  mkdir staging; fi && \
	cd staging && \
	if [ ! -d NAA ]; then  mkdir NAA; fi && \
	cd NAA && \
	if [ ! -d public ]; then  mkdir public; fi && \
	if [ ! -d views ]; then  mkdir views; fi'

	#Transfer files
    #sshpass -p $sshpass scp -v -r /Users/sahil/NodeAngular-Application/public techhysahil@23.229.183.161:~/public_html/Projects/cwd/staging/NAA/public
    #sshpass -p $sshpass scp -v -r /Users/sahil/NodeAngular-Application/views techhysahil@23.229.183.161:~/public_html/Projects/cwd/staging/NAA/views
    #sshpass -p $sshpass scp -v -r /Users/sahil/NodeAngular-Application/HttpServer.js techhysahil@23.229.183.161:~/public_html/Projects/cwd/staging/NAA/HttpServer.js

    if [[ $? -eq 0 ]]; then
        echo "============================================================="
        echo "============= File Transfered successful ===================="
        echo "============================================================="
    elif [[ $? -eq 1 ]]; then
        echo "============================================================="
        echo "============= Error in Transfering files ===================="
        echo "============================================================="
    fi

