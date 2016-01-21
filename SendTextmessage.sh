#!bin/bash

#Check if user have no already session
if ! who | grep -wq $USER; then
  echo "session not exist"
  exit
else
	echo "session already exist. you are good to go."
fi


# Phone numbers
echo "============================================================="
read -p "Enter receiver number(with country code):" receiverPhoneNumber
echo "============================================================="

MESSAGE="Late at work"

# Send a text message
RESPONSE=`curl -X POST "https://api.twilio.com/2010-04-01/Accounts/AC299e454291dfe61646b1c4e271390b91/Messages.json" \
--data-urlencode "To=+$receiverPhoneNumber"  \
--data-urlencode "From=++17867667513"  \
--data-urlencode "Body=$MESSAGE" \
-u AC299e454291dfe61646b1c4e271390b91:a6a05ae1bd7a24f8f29ab98884782ba3`

# Log errors
if [ $? -gt 0 ]; then
	echo "**********************************************************"	
  	echo "Failed to send SMS."
  	echo "**********************************************************"
else
	echo "**********************************************************"
  	echo "SMS send successfully to $HER_NUMBER"
  	echo "**********************************************************"
fi





