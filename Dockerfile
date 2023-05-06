# latest kali base image
FROM kalilinux/kali-rolling:latest

LABEL "author"="Sean Fontaine"
LABEL "version"="v1.3.2"
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

RUN sudo chmod +x /home/kali/sources/0-base-pkgs.sh && \
  /home/kali/sources/0-base-pkgs.sh base

RUN sudo chmod +x /home/kali/sources/1-ntwk-pkgs.sh && \
  /home/kali/sources/1-ntwk-pkgs.sh network

RUN sudo chmod +x /home/kali/sources/2-web-pkgs.sh && \
  /home/kali/sources/2-web-pkgs.sh web

RUN sudo chmod +x /home/kali/sources/3-AD-pkgs.sh && \
  /home/kali/sources/3-AD-pkgs.sh active_directory

RUN sudo chmod +x /home/kali/sources/4-password-pkgs.sh && \
  /home/kali/sources/4-password-pkgs.sh password

ADD resources /home/kali/resources/

RUN sudo chown -R kali:kali /home/kali/resources

RUN mkdir .logs && mkdir .local && mkdir tools \
  && cp /home/kali/resources/tmux.conf /home/kali/.tmux.conf \
  && cp -r /home/kali/resources/.BurpSuite /home/kali/.BurpSuite

RUN sudo chmod +x /home/kali/sources/5-go.sh \
  && /home/kali/sources/5-go.sh install_go

RUN sudo chmod +x /home/kali/sources/6-tools.sh \
  && /home/kali/sources/6-tools.sh tools_install

RUN sudo dpkg -i /home/kali/resources/rustscan_2.1.1_amd64.deb

RUN git clone https://github.com/samratashok/nishang.git

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" \
  --unattended

RUN cp /home/kali/resources/zsh/zshrc /home/kali/.zshrc

RUN cp /home/kali/resources/zsh/ka-tet.zsh-theme /home/kali/.oh-my-zsh/themes/. \
  && cp /home/kali/resources/zsh/history /home/kali/.kali_history

RUN tar -xvf /home/kali/resources/mozilla.tar.bz2 -C /home/kali/

RUN git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

RUN sudo rm -rf /home/kali/sources && sudo rm -rf /home/kali/resources

USER kali

RUN zsh



