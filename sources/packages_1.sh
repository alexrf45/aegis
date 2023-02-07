#!/bin/bash

function install_1() {
        sudo apt-get install -y netcat-traditional rlwrap nmap netdiscover masscan \
	    httprobe dnsenum dnsutils amass responder \
	    ftp telnet swaks snmpcheck snmpcheck snmp-mibs-downloader
}

install_1