#!/bin/bash

#I run neo4j locally via docker-compose then launch bloodhound from
#the container. Either way you need to have neo4j running before using bloodhound.
function active_directory() {
	sudo apt-get install -y \
		smbclient smbmap evil-winrm bloodhound responder \
		powershell ldap-utils
}

active_directory
