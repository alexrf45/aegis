# latest kali base image
FROM kalilinux/kali-rolling:latest

LABEL "project"="kali-sec"
LABEL "branch"="main"
LABEL "author"="fr3d"
LABEL "version"="v1.2.0"
LABEL "website"="https://fr3d.dev"

ENV DEBIAN_FRONTEND noninteractive
ENV TZ="America/New_York"

RUN apt-get update && apt-get install sudo -y

RUN groupadd --gid 1000 kali \
  && useradd --home-dir /home/kali --create-home --uid 1000 \
  --gid 1000 --shell /bin/bash --skel /dev/null kali

RUN chown -R kali:kali /home/kali/

RUN echo kali:kali | chpasswd

RUN usermod -aG sudo kali

RUN echo 'kali  ALL=(ALL) NOPASSWD:ALL' >>  /etc/sudoers.d/kali

WORKDIR /home/kali/

USER kali

COPY sources/ /tmp/sources

RUN sudo chown -R kali:kali /tmp/sources/*

RUN sudo chmod +x /tmp/sources/*.sh

RUN /tmp/sources/0-base.sh

RUN  /tmp/sources/1-tools.sh

#RUN /tmp/sources/2-tools.sh not needed for CTFs and labs

RUN /tmp/sources/3-wordlists.sh

COPY resources /home/kali/resources/

RUN sudo chown -R kali:kali /home/kali/resources

RUN mkdir -p $HOME/.config && cp /home/kali/resources/tmux.conf /home/kali/.tmux.conf \
  && cp -r /home/kali/resources/shell-upgrade.sh /home/kali/tools/shell-upgrade.sh \
  && cp -r /home/kali/resources/recon.sh /home/kali/.local/bin/recon.sh && chmod +x /home/kali/.local/bin/recon.sh \
  && cp -r /home/kali/resources/proxychains.conf /home/kali/.proxychains/proxychains.conf \
  && cp -r /home/kali/resources/kerbrute /home/kali/.local/bin/kerbrute && chmod +x /home/kali/.local/bin/kerbrute \
  && cp -r /home/kali/resources/starship.toml /home/kali/.config/starship.toml

RUN git clone https://github.com/samratashok/nishang.git tools/nishang

RUN git clone https://github.com/gustanini/PowershellTools.git tools/powershelltools

RUN git clone https://github.com/aniqfakhrul/powerview.py tools/powerview

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" \
  --unattended

RUN cp /home/kali/resources/zsh/zshrc /home/kali/.zshrc

RUN cp /home/kali/resources/zsh/kali.zsh-theme /home/kali/.oh-my-zsh/themes/. \
  && cp /home/kali/resources/zsh/history /home/kali/.kali_history

RUN git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

RUN  curl -O https://starship.rs/install.sh && chmod +x install.sh && ./install.sh -b $HOME/.local/bin --yes

RUN sudo rm -rf /tmp/sources && sudo rm -rf /home/kali/resources

USER kali

RUN zsh



