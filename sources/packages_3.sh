#!/bin/bash

function active_directory() {
    sudo apt-get install -y python3-impacket impacket-scripts \
    smbclient smbmap crackmapexec evil-winrm bloodhound responder \
    powershell ldap-utils
}

active_directory

