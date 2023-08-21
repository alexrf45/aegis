# latest kali base image
FROM kalilinux/kali-rolling:latest

LABEL "project"="kali-d"
LABEL "author"="f0nzy"
LABEL "version"="v1.1.0"
LABEL "website"="https://r0land-sec.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install sudo

RUN groupadd --gid 1000 kali \
  && useradd --home-dir /home/kali --create-home --uid 1000 \
  --gid 1000 --shell /bin/bash --skel /dev/null kali

RUN chown -R kali:kali /home/kali/

RUN echo kali:kali | chpasswd

RUN usermod -aG sudo kali

RUN echo 'kali  ALL=(ALL) NOPASSWD:ALL' >>  /etc/sudoers.d/kali

WORKDIR /home/kali/

USER kali

RUN mkdir .logs && mkdir .local && mkdir tools && mkdir -p /home/kali/.config/tmuxp

ADD sources/0-base.sh /tmp/sources/0-base.sh

RUN sudo chmod +x /tmp/sources/0-base.sh && /tmp/sources/0-base.sh

ADD sources/1-tools.sh /tmp/sources/1-tools.sh

RUN sudo chmod +x /tmp/sources/1-tools.sh &&  /tmp/sources/1-tools.sh

ADD sources/2-tools.sh /tmp/sources/2-tools.sh

RUN sudo chmod +x /tmp/sources/2-tools.sh && /tmp/sources/2-tools.sh

RUN sudo chown -R kali:kali /tmp/sources/*

ADD sources/hakrawler /tmp/sources/hakrawler

ADD sources/jsleak /tmp/sources/jsleak

RUN cp /tmp/sources/hakrawler /home/kali/.local/hakrawler \
  && chmod +x /home/kali/.local/hakrawler && \
  cp /tmp/sources/jsleak /home/kali/.local/jsleak && chmod +x /home/kali/.local/jsleak


ADD resources /home/kali/resources/

RUN sudo chown -R kali:kali /home/kali/resources

RUN cp /home/kali/resources/tmux.conf /home/kali/.tmux.conf \
  && cp -r /home/kali/resources/.BurpSuite /home/kali/.BurpSuite \
  && cp /home/kali/resources/ctf.yaml /home/kali/.config/tmuxp/ctf.yaml \
  && cp /home/kali/resources/bounty.yaml /home/kali/.config/tmuxp/bounty.yaml \
  && cp -r /home/kali/resources/bloodhound /home/kali/.config/bloodhound \
  && cp -r /home/kali/resources/shell-upgrade.sh /home/kali/tools/shell-upgrade.sh \
  && cp -r /home/kali/resources/recon.sh /home/kali/.local/recon.sh && chmod +x /home/kali/.local/recon.sh

RUN git clone https://github.com/samratashok/nishang.git

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" \
  --unattended

RUN cp /home/kali/resources/zsh/zshrc /home/kali/.zshrc

RUN cp /home/kali/resources/zsh/kali.zsh-theme /home/kali/.oh-my-zsh/themes/. \
  && cp /home/kali/resources/zsh/history /home/kali/.kali_history

RUN tar -xvf /home/kali/resources/mozilla.tar.bz2 -C /home/kali/

RUN git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

RUN sudo rm -rf /tmp/sources && sudo rm -rf /home/kali/resources

USER kali

RUN zsh



