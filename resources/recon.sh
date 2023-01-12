#!/bin/bash

########################################
# ///                                        \\\
#  		You can edit your configuration here
#
#
########################################

# subdomainThreads=10
# ffufThreads=30
########################################
# My first bug bounty script. I was looking to combine my normal workflow into a portable script.
########################################

domain=

while getopts d: flag
do
    case "${flag}" in
        d) domain=${OPTARG};;
    esac
done



amass_tool () {
    amass -dir ~/.config/amass/config.ini
}

live_hosts () {
    cat domains.txt | httprobe > live-hosts.txt
}

probed_hosts () {
    httpx -list live-hosts.txt -silent -probe > probed-hosts.txt

}
file_format(){
    cat probed-hosts.txt | grep 'SUCCESS' | cut -d '[' -f 1 > targets.txt

}

spider_directories() {
    for URL in $(<targets.txt); do ( ffuf -u "${URL}/FUZZ" \
    -w /usr/share/seclists/Discovery/Web-Content/raft-medium-directories-lowercase.txt \
    -c -t 5 -p 0.3 -H "User-Agent: $AGENT" -ac -o $NAME-ffuf.txt -of html ); done
}


# aquatone_tool () {
#     cat live-hosts.txt | aquatone \
#         -ports=80,443,8080,8081,8443,8000 \
#         -threads=5 \
#         -silent \
#         -chrome-path=/usr/bin/chromium \
#         -out screenshots/ \
#     && echo "Done taking screenshots on $domain" | notify -id general
# }

nuclei_tool () {
    nuclei -t cves/ -l live-hosts.txt -o nuclei-results 
    # ./slackcat -1
}

recon_2() {
    while true; do for target in ~/$NAME/domains.txt; \
    do amass enum -active -df $target -dir $NAME-db/target/; \
    amass track -last 4 -dir $NAME-db/target/ -df $target -nocolor | grep "Found: " | awk '{ print $NF }' | tee -a found.text \
    | httpx -sc -td -cl -title | notify -bulk; done; done

}

echo -e "\e[1;31m searching for $domain... \e[0m"
amass_tool
echo -e "\e[1;31m searching for live hosts on $domain... \e[0m"
live_hosts
echo -e "\e[1;31m probing hosts... \e[0m"
probed_hosts
echo -e "\e[1;31m formating hosts for ffuf.. \e[0m"
file_format
echo -e "\e[1;31m spidering directories... \e[0m"
spider_directories
#echo -e "\e[1;31m screenshotting live hosts on $domain... \e[0m"
#aquatone_tool
echo -e "\e[1;31m running nuclei for live hosts on $domain... \e[0m"
nuclei_tool
echo -e "\e[1;31m checking for new domains on $domain... \e[0m"
recon_2
