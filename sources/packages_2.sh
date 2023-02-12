#!/bin/bash

function web () {
    sudo apt-get install -y whatweb ffuf gobuster nuclei httprobe sqlmap \
	exiftool default-mysql-client hurl postgresql arjun
}

web