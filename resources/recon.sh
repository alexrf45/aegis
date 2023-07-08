#!/bin/bash

whatweb -a 1 -U=$AGENT -t 10 --wait=0.2 http://$IP/ >whatweb.txt

mkdir -p $NAME-nmap/$NAME

nmap -sC -sV -oA $NAME-nmap/$NAME -p- $IP

ffuf -c -t 30 -p 0.1 \
	-r -rate 100 -recursion -recursion-depth 3 \
	-H "User-Agent:$AGENT"
-mc 200,302,403 -w /usr/share/seclists/Discovery/Web-Content/raft-small-words.txt \
	-u http://$IP/FUZZ
