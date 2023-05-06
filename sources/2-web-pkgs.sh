#!/bin/bash

function web() {
	sudo apt-get install -y whatweb ffuf sqlmap \
		exiftool default-mysql-client hurl postgresql arjun httprobe \
		burpsuite nikto
}

web
