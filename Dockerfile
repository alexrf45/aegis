# latest kali base image
FROM kalilinux/kali-rolling:latest

LABEL "author"="Sean Fontaine"
LABEL "version"="v1.2.0"
LABEL "website"="https://r0land.link"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y sudo wireshark

RUN groupadd --gid 1000 kali \
    && useradd --home-dir /home/kali --create-home --uid 1000 \
      --gid 1000 --shell /bin/bash --skel /dev/null kali

RUN chown -R kali:kali /home/kali/

RUN echo kali:kali | chpasswd

RUN usermod -aG sudo kali

RUN echo 'kali  ALL=(ALL) NOPASSWD:ALL' >>  /etc/sudoers.d/kali

WORKDIR /home/kali/

USER kali

ADD sources /home/kali/sources/

RUN sudo chown -R kali:kali /home/kali/sources

RUN sudo chmod +x /home/kali/sources/packages_0.sh && \
	/home/kali/sources/packages_0.sh base

RUN sudo chmod +x /home/kali/sources/packages_1.sh && \
	/home/kali/sources/packages_1.sh network

RUN sudo chmod +x /home/kali/sources/packages_2.sh && \
	/home/kali/sources/packages_2.sh web

RUN sudo chmod +x /home/kali/sources/packages_3.sh && \
	/home/kali/sources/packages_3.sh active_directory

RUN sudo chmod +x /home/kali/sources/packages_4.sh && \
	/home/kali/sources/packages_4.sh password

ADD resources /home/kali/resources/

RUN sudo chown -R kali:kali /home/kali/resources

RUN mkdir .logs && mkdir .local && mkdir tools \
	&& cp /home/kali/resources/config.ini /home/kali/.local/config.ini \
	&& cp /home/kali/resources/tmux.conf /home/kali/.tmux.conf \
	&& cp /home/kali/resources/resolvers.txt /home/kali/tools/resolvers.txt \
	&& cp /home/kali/resources/ffufrc /home/kali/tools/.ffufrc \
	&& cp /home/kali/resources/ffufrc_subdomain /home/kali/tools/.ffufrc_subdomain \
	&& cp -r /home/kali/resources/.BurpSuite /home/kali/.BurpSuite \
	&& sudo cp /home/kali/resources/neo4j.conf /usr/share/neo4j/conf/.

#TODO: fix python env
# RUN sudo chmod +x /home/kali/sources/python.sh \
# 	&& /home/kali/sources/python.sh python_tools 

RUN sudo chmod +x /home/kali/sources/go.sh \
	&& /home/kali/sources/go.sh install_go

RUN sudo chmod +x /home/kali/sources/tools.sh \
	&& /home/kali/sources/tools.sh tools_install
	
RUN git clone https://github.com/samratashok/nishang.git

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" \
	--unattended

RUN cp /home/kali/resources/zsh/zshrc /home/kali/.zshrc

RUN cp /home/kali/resources/zsh/ka-tet.zsh-theme /home/kali/.oh-my-zsh/themes/. \
	&& cp /home/kali/resources/zsh/kali_history /home/kali/.kali_history

RUN git clone https://github.com/zsh-users/zsh-autosuggestions \
	${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
	${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

RUN sudo rm -rf /home/kali/sources && sudo rm -rf /home/kali/resources

USER kali

RUN zsh



