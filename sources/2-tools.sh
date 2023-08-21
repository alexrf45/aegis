#!/bin/bash

sudo apt-get install amass -y

httprobe_install() {
	wget -q https://github.com/tomnomnom/httprobe/releases/download/v0.2/httprobe-linux-amd64-0.2.tgz -O httprobe.tgz &&
		tar -xzf httprobe.tgz && chmod +x httprobe && mv httprobe $HOME/.local/httprobe && rm httprobe.tgz
}

go-dorks_install() {
	wget -q https://github.com/dwisiswant0/go-dork/releases/download/v1.0.2/go-dork_1.0.2_linux_amd64 -O go-dork &&
		mv go-dork $HOME/.local/go-dork &&
		chmod +x $HOME/.local/go-dork
}

rush_install() {
	wget https://github.com/shenwei356/rush/releases/download/v0.5.2/rush_linux_amd64.tar.gz -O rush.tar.gz &&
		gunzip rush.tar.gz && tar -xf rush.tar && rm rush.tar && mv rush $HOME/.local/rush && chmod +x $HOME/.local/rush

katana_install() {
	wget https://github.com/projectdiscovery/katana/releases/download/v1.0.3/katana_1.0.3_linux_amd64.zip -O katana.zip &&
		unzip katana.zip && chmod +x katana && mv katana $HOME/.local/. && rm katana.zip
}

chaos_install() {
	wget https://github.com/projectdiscovery/chaos-client/releases/download/v0.5.1/chaos-client_0.5.1_linux_amd64.zip \
		-O chaos.zip && unzip chaos.zip chaos-client && chmod +x chaos-client && mv chaos-client $HOME/.local/chaos &&
		rm chaos.zip
}

dnsx_install() {
	wget https://github.com/projectdiscovery/dnsx/releases/download/v1.1.4/dnsx_1.1.4_linux_amd64.zip -O dnsx.zip &&
		unzip dnsx.zip dnsx && chmod +x dnsx && mv dnsx $HOME/.local/dnsx && rm dnsx.zip
}

waybackurls_install() {
	wget -q -O waybackurls.tgz https://github.com/tomnomnom/waybackurls/releases/download/v0.1.0/waybackurls-linux-amd64-0.1.0.tgz &&
		gunzip waybackurls.tgz &&
		tar -C $HOME/.local -xf waybackurls.tar &&
		chmod +x $HOME/.local/waybackurls &&
		rm $HOME/waybackurls.tar

}

unfurl_install() {
	wget https://github.com/tomnomnom/unfurl/releases/download/v0.4.3/unfurl-linux-amd64-0.4.3.tgz \
		-O unfurl.tgz && tar -xzf unfurl.tgz && mv unfurl $HOME/.local/unfurl && rm unfurl.tgz
}

subfinder_install() {
	wget https://github.com/projectdiscovery/subfinder/releases/download/v2.6.2/subfinder_2.6.2_linux_amd64.zip \
		-O subfinder.zip && unzip subfinder.zip && chmod +x subfinder && mv subfinder $HOME/.local/subfinder && rm subfinder.zip
}

notify_install() {
	wget https://github.com/projectdiscovery/notify/releases/download/v1.0.5/notify_1.0.5_linux_amd64.zip \
		-O notify.zip && unzip -o notify && mv notify $HOME/.local/notify && rm notify.zip && rm LICENSE.md README.md
}

httprobe_install
go-dorks_install
rush_install
katana_install
chaos_install
dnsx_install
waybackurls_install
unfurl_install
subfinder_install
notify_install
