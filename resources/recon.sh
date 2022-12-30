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
    amass enum -active -d $domain -o results.txt
}

live_hosts () {
    cat results.txt | httprobe > live-hosts.txt
}

probed_hosts () {
    httpx -list results.txt -silent -probe > probed-hosts.txt

}

# scanned_hosts () {
#     naabu -list results.txt > scanned-hosts.txt
# }

aquatone_tool () {
    cat live-hosts.txt | aquatone \
        -ports=80,443,8080,8081,8443,8000 \
        -threads=5 \
        -silent \
        -chrome-path=/usr/bin/chromium \
        -out screenshots/ \
    && echo "Done taking screenshots on $domain" | notify -id general
}

nuclei_tool () {
    nuclei -t cves/ -l live-hosts.txt -o nuclei-results | ./slackcat -1
}

echo -e "\e[1;31m searching for $domain... \e[0m"
amass_tool
echo -e "\e[1;31m searching for live hosts on $domain... \e[0m"
live_hosts
echo -e "\e[1;31m probing hosts... \e[0m"
probed_hosts
echo -e "\e[1;31m scanning hosts for $domain... \e[0m"
scanned_hosts
#echo -e "\e[1;31m screenshotting live hosts on $domain... \e[0m"
#aquatone_tool
echo -e "\e[1;31m running nuclei for live hosts on $domain... \e[0m"
nuclei_tool
