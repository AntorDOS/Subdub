#!/bin/bash

# Colors

RED='\033[0;31m' #It is Ascii code for red color
GREEN='\033[0;32m'
BLUE='\033[0;34m'
WHITE='\033[0;37m'
CYAN='\033[1;36m'
REDN='\033[1;31m' # Dark Red
GREENN='\033[1;32m' # Dark Green
BYellow='\033[1;33m' # Dark Yellow
# Banner
echo -e "${REDN}

██████  █    ██  ▄▄▄▄   ▓█████▄  █    ██  ▄▄▄▄
▒██    ▒  ██  ▓██▒▓█████▄ ▒██▀ ██▌ ██  ▓██▒▓█████▄
░ ▓██▄   ▓██  ▒██░▒██▒ ▄██░██   █▌▓██  ▒██░▒██▒ ▄██
  ▒   ██▒▓▓█  ░██░▒██░█▀  ░▓█▄   ▌▓▓█  ░██░▒██░█▀
▒██████▒▒▒▒█████▓ ░▓█  ▀█▓░▒████▓ ▒▒█████▓ ░▓█  ▀█▓
▒ ▒▓▒ ▒ ░░▒▓▒ ▒ ▒ ░▒▓███▀▒ ▒▒▓  ▒ ░▒▓▒ ▒ ▒ ░▒▓███▀▒
░ ░▒  ░ ░░░▒░ ░ ░ ▒░▒   ░  ░ ▒  ▒ ░░▒░ ░ ░ ▒░▒   ░
░  ░  ░   ░░░ ░ ░  ░    ░  ░ ░  ░  ░░░ ░ ░  ░    ░
      ░     ░      ░         ░       ░      ░
                        ░  ░                     ░


                🔧${GREENN} Subdomain Finding Tool by Jahid Hasan"

# Some Info 
echo
echo -e "${RED}Before Run This Tool, Please Read REDME.txt File"
echo
echo -e "${GREEN}This Tool Takes Long Time For Gathering Subdomain, So Please Wait..."
echo

sub="subdomains" # Directory Name For Saving Output
output=$(echo "$1" | cut -d "." -f1 ) # output_file_name
sub_dir=$(echo "$1" | cut -d "." -f1 ) # sub-directory under subdomains directory

# Gather All subdomain From different Tools And save the output in subdomains folder, then sorting, removing duplicate and filter live subdomain
function tools(){

	
	if command -v subfinder &>/dev/null # [subfinder] check The command Is Installed or not In system And If Install then run the actucal command
	then
			
		subfinder -silent -d $1 --all > $sub/$sub_dir/$output-1.txt

	else
		go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
		subfinder -silent -d $1 --all > $sub/$sub_dir/$output-1.txt

	fi



	if command -v sublist3r &>/dev/null # sublist3er
	then
		sublist3r -d $1 -t 20 2>/dev/null > $sub/$sub_dir/$output-2.txt


	fi

	if command -v assetfinder &>/dev/null # assetfinder
	then
		assetfinder -subs-only $1 > $sub/$sub_dir/$output-3.txt

	else
		go install github.com/tomnomnom/assetfinder@latest
		assetfinder -subs-only $1 > $sub/$sub_dir/$output-3.txt

	fi

	if command -v findomain &>/dev/null # findomain
	then
		findomain  --target $1 | grep -vE "Job|Good|Searching|❌|Target" > $sub/$sub_dir/$output-4.txt

	fi

	
	if command -v shuffledns &>/dev/null #shuffledns
	then
		shuffledns -silent -mode bruteforce -d $1 -r /home/$USER/resolvers.txt -w /home/$USER/wordlist.txt | grep -vE "[INF]" > $sub/$sub_dir/$output-5.txt

	else
		go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest
		shuffledns -silent -mode bruteforce -d $1 -r /home/$USER/Desktop/resolvers.txt -w /home/$USER/wordlist.txt | grep -vE "[INF]" > $sub/$sub_dir/$output-5.txt

	fi


	if command -v subevigil &>/dev/null # subevigil
	then
		subevigil $1 > $sub/$sub_dir/$output-6.txt

	fi


	if command -v chaos &>/dev/null # chaos
	then
		echo
		read -e -p "$(echo -e "${WHITE}Enter Your Project Discovery Api Key: ${BLUE}")" api
		export PDCP_API_KEY=$api
		chaos -d $1 -silent > $sub/$sub_dir/$output-7.txt

	else
		go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest
		echo
		read -e -p "$(echo -e "${WHITE}Enter Your Project Discovery Api Key: ${BLUE}")" api
		export PDCP_API_KEY=$api
		chaos -d $1 -silent > $sub/$sub_dir/$output-7.txt

	fi
	

	

	for i in {1..7}
	do
		file=$sub/$sub_dir/${output}-${i}.txt
		if [[ -f $file ]]
		then
			cat $file >> $sub/$sub_dir/${output}-total_sub.txt
			
		else
			echo
			echo -e "${RED}[!] Skipping missing file: $file"
		fi
	done
        
	 
	if command -v httpx &>/dev/null # httpx
        then

                cat $sub/$sub_dir/${output}-total_sub.txt | sort | uniq | httpx -silent -mc 200,404,403 > $sub/$sub_dir/${output}_alive_sub.txt
        else
                go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
                cat $sub/$sub_dir/${output}-total_sub.txt | sort | uniq | httpx -silent -mc 200,404,403 > $sub/$sub_dir/${output}_alive_sub.txt

        fi
	echo
	echo -e "${BYellow}Total Alive Subdomain Is: $(cat $sub/$sub_dir/${output}_alive_sub.txt | wc -l)"
	echo
	echo -e "${GREENN}Output Saved In $sub/$sub_dir"


}


# Main Working
if [[ ! -d $sub  ]] && [[ ! -z $1   ]] # check Input/Argument Empty Or Not and subdomains directory exists or not
then
    	echo -e "${BLUE}▶ Tool Starting... Please wait..."    
	mkdir $sub
	mkdir $sub/$sub_dir
	
	
	tools $1

	
	



elif [[  -z  $1  ]]
then

	echo -e "${WHITE}Usage: subdub <domain>"


elif [[ -d $sub ]] && [[ -d $sub/$sub_dir ]]
then
	echo -e "${BLUE}▶ Tool Starting... Please wait..."
	tools $1


elif [[ -d $sub   ]] && [[ ! -d $sub/$sub_dir ]]
then
	echo -e "${BLUE}▶ Tool Starting... Please wait..."
	mkdir $sub/$sub_dir
	tools $1
	


	
	
fi

