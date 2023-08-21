#!/bin/bash

########################################
# My first bug bounty script
# Tools used: subfinder, httprobe, naabu, httpx, hakrawler, meg
# I highly reccommend API keys where posssible to ensure more accurate results.
########################################

project=$1
file=$2

RED="31"
BOLDRED="\e[1;${RED}m"
GREEN="32"
BOLDGREEN="\e[1;${GREEN}m"
YELLOW="33"
BOLDYELLOW="\e[1;${YELLOW}m"
ENDCOLOR="\e[0m"

while getopts "p:f:?" opt; do
	case "$opt" in
	p) project="$OPTARG" ;;
	f) file="$OPTARG" ;;
	?) Usage ;;
	esac
done

Usage() {
	figlet recon.sh | lolcat
	echo -e "Usage: ./recon.sh -p PROJECT_NAME -f root.txt \n"
	echo -e "-p Project name or target"
	echo -e "-f list of root domains"
	exit 1
}

if [ -z "$project" ]; then
	echo $red"[-]" "Project name required"
	Usage
fi

if [ -z "$file" ]; then
	echo $red"[-]" "Domain file required"
	Usage
fi

main_banner() {
	figlet recon.sh | lolcat
}

tool_banner() {
	echo -e "${BOLDGREEN}+------------------------------------------+"
	printf "| %-40s |\n" "$(date)"
	echo -e "|                                          |"
	printf "${BOLDGREEN}|$(tput bold) %-40s $(tput sgr0)${BOLDGREEN}|\n" "$@"
	echo -e "${BOLDGREEN}+------------------------------------------+"
}

http_probe() {
	echo -e "${BOLDRED}searching for live hosts on $project...${ENDCOLOR}\n"
	cat $project-domains.txt | httprobe >$project-live-hosts.txt
}

httpx_live_hosts() {
	echo -e "${BOLDRED}probing hosts on $project...${ENDCOLOR}\n"
	http-x -list $project-live-hosts.txt -silent -probe -tech-detect -status-code -t 3 -H "User-Agent: $AGENT" -o $project-probed-hosts.txt
}
file_format_1() {
	echo -e "${BOLDYELLOW}Formatting httpx results${ENDCOLOR}\n"
	cat $project-probed-hosts.txt | grep 'SUCCESS' | cut -d '[' -f 1 | cut -d ' ' -f 1 >$project-targets.txt
}

main_banner

tool_banner "Running chaos"
chaos -key $CHAOS_KEY -dL root.txt -silent -o chaos-$project-domains.txt
tool_banner "Running subfinder"
subfinder -dL $file -all -cs -rl 100 -t 20 -timeout 10 -max-time 5 >$project-main.txt
cat $project-main.txt | cut -d "," -f 1 >$project-domains.txt
tool_banner "Running dnsx"
dnsx -l root.txt -t 50 -rl 100 -o dnsx-$project-domains.txt -r resolvers.txt
tool_banner "subdomain enumeration complete"
tool_banner "Running httprobe"
http_probe
tool_banner "Httprobe complete"
tool_banner "Running httpx"
httpx_live_hosts
tool_banner "Formatting httpx results"
file_format_1
tool_banner "Looking for links and secrets"
cat $project-targets.txt | jsleak -l -l -c 5 >$project-links-secrets.txt
tool_banner "links and secrets search complete"
tool_banner "Running hakrawler"
cat $project-targets.txt | hakrawler \
	-h "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36;;X-Bug-Bounty: r0land" \
	-d 4 -t 2 -timeout 5 -u >$project-endpoints.txt
tool_banner "Recon on $project Finished"
