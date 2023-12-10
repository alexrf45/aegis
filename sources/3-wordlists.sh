#!/bin/bash

mkdir -p $HOME/.wordlists

wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/Logins.fuzz.txt" -q -O $HOME/.wordlists/logins.txt

wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/common-api-endpoints-mazen160.txt" -q -O $HOME/.wordlists/api.txt

wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/common.txt" -q -O $HOME/.wordlists/common.txt

wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/directory-list-2.3-small.txt" -q -O $HOME/.wordlists/dir-list.txt

wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-small-words-lowercase.txt" -q -O $HOME/.wordlists/raft-small.txt

wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/Common-PHP-Filenames.txt" -q -O $HOME/.wordlists/php.txt

wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/api/api-endpoints.txt" -q -O $HOME/.wordlists/api-wild.txt

wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Fuzzing/fuzz-Bo0oM-friendly.txt" -q -O $HOME/.wordlists/fuzz-1.txt

wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Fuzzing/LFI/LFI-Jhaddix.txt" -q -O $HOME/.wordlists/LFI.txt

wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Fuzzing/SQLi/Generic-BlindSQLi.fuzzdb.txt" -q -O $HOME/.wordlists/SQL.txt

wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-20000.txt" -q -O $HOME/.wordlists/dns.txt

wget "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/bitquark-subdomains-top100000.txt" -q -O $HOME/.wordlists/dns-1.txt

wget "https://raw.githubusercontent.com/jeanphorn/wordlist/master/usernames.txt" -q -O $HOME/.wordlists/usernames.txt
