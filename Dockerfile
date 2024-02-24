# latest kali base image
FROM kalilinux/kali-rolling:latest

LABEL "project"="kali-sec"
LABEL "branch"="dev"
LABEL "author"="fr3d"
LABEL "version"="v1.3.0_dev"
LABEL "website"="https://fr3ds-dev.pgs.sh/"

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

RUN /tmp/sources/2-tools.sh

RUN /tmp/sources/3-wordlists.sh

COPY resources /home/kali/resources/

RUN sudo chown -R kali:kali /home/kali/resources

RUN /tmp/sources/4-home.sh

RUN sudo rm -rf /tmp/sources && sudo rm -rf /home/kali/resources

USER kali

RUN bash



