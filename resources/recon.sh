#!/bin/bash

########################################
# My first bug bounty script. I was looking to combine my normal workflow into a portable script.
# You will need to configure your amass config (API keys, etc) before running the script. Running amass with no API keys is not recommended.
########################################

project=$1
domain=$2

while getopts "p:d:" opt
do
   case "$opt" in
      p ) project="$OPTARG" ;;
      d ) domain="OPTARG" ;;
      ? ) Usage ;;
   esac
done

Usage() {
    echo -e "Usage: ./recon.sh -p PROJECT_NAME -d domain"
    exit 1
}


if [ -d "$project" ]; then
    rm -rf $project && mkdir $project && cd $project
    else
    mkdir $project && cd $project
fi


banner() {
    echo "+------------------------------------------+"
    printf "| %-40s |\n" "`date`"
    echo "|                                          |"
    printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
    echo "+------------------------------------------+"
}

amass_run () {
    echo -e "\e[1;31m searching for $project\e[0m"
    amass enum -config ~/.config/amass/config.ini -silent -o domains.txt -d $domain
    echo "Amass subdomain enum complete"
    echo -e "\e[1;31m resolving IP addresses for $project...\e[0m"
    amass enum -config ~/.config/amass/config.ini -silent -o ip.txt -ipv4 -d $domain
    echo "Amass IP enumeration complete"
}

http_probe () {
    echo -e "\e[1;31m searching for live hosts on $project...\e[0m"
    cat domains.txt | httprobe > live-hosts.txt
}

httpx_live () {
    echo -e "\e[1;31m probing hosts with httpx...\e[0m"
    http-x -list live-hosts.txt -silent -probe -tech-detect -status-code > probed-hosts.txt

}
file_format(){
    echo "Formatting httpx results"
    cat probed-hosts.txt | grep 'SUCCESS' | cut -d '[' -f 1 > targets.txt

}

spider_directories() {
    echo -e "\e[1;31m spidering directories\e[0m"
    for URL in $(<targets.txt); do ( ffuf -u "${URL}/FUZZ" \
    -w /usr/share/seclists/Discovery/Web-Content/raft-medium-directories-lowercase.txt \
    -c -t 5 -p 0.3 -H "User-Agent: $AGENT" -ac -o $NAME-ffuf.html -of html -or ); done
}

nuclei_tool () {
    echo -e "\e[1;31mrunning nuclei on $project\e[0m"
    nuclei -t cves/ -t exposures/ -t technologies/ -l live-hosts.txt -o nuclei-results
}

if [ -z "$project" ]
then
   echo $red"[-]" "Project name required";
   Usage
fi


list=(
        project_start
        amass_run
        http_probe
        httpx_live
        file_format
        spider_directories
        nuclei_tool
)

banner "Running Amass"
amass_run
banner "Running httprobe"
http_probe
banner "Running httpx"
httpx_live
banner "Formatting httpx results"
file_format
banner "Running spider"
spider_directories
banner "Running Nuclei"
nuclei_tool