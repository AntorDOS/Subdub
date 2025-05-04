#!/bin/bash

<<comment
echo "**********************************"
echo "*                                *"
echo "*                                *"
echo "*    subevigil-subdomain finder  *"
echo "*                                *"
echo "*                                *"
echo "**********************************"
comment

if [[ ! -z $1 ]]
then
	curl  --location --request GET "http://osint.bevigil.com/api/$1/subdomains/" \--header 'X-Access-Token: <enter_api_key>' 2>/dev/null | jq -r | grep -vE 'domain|subdomains|]|}|{|%|100|100' | cut -d '"' -f2


else
	echo "Usage: subevigil <domain>"
fi

