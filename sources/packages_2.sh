#!/bin/bash

function web () {
    sudo apt-get install -y whatweb ffuf gobuster sqlmap \
	exiftool default-mysql-client hurl postgresql arjun httprobe
}

web
