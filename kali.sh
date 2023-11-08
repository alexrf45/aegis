#!/bin/bash

# kali $1 ()
# {
#   mkdir $1 && cd $1 && \
#     docker run --name $1 -it \
#       --net=host --entrypoint=/bin/zsh \
#       --cap-add=NET_ADMIN \
#       -v $HOME/.katet:/home/kali/.katet \
#       -v $HOME/.Xauthority:/home/kali/.Xauthority:ro \
#       -v /tmp/.X11-unix:/tmp/.X11-unix \
#       -v `pwd`/.kali-logs:/root/.logs:rw \
#       -v `pwd`:/$1 \
#       -w /$1 \
#       -e DISPLAY=$DISPLAY \
#       -e TARGET=$TARGET -e IP=$IP -e DOMAIN=$DOMAIN \
#       -e TZ=$TIME_ZONE -e NAME=$1 \
#       fonalex45/kali-d:latest
# }

kali-directory $1 () {
 mkdir -p $1/{recon,www,exploit,pivot,report} && cd $1
}

kali $1 () {
	if [ ! -d `pwd`/.kali-logs ];
	then
    mkdir -p $1/{recon,www,exploit,pivot,report} && cd $1 && \
    mkdir .kali-logs \
    && docker run --name $1 -it \
    --net=host --entrypoint=/bin/zsh \
		--cap-add=NET_ADMIN \
    -e DISPLAY=$DISPLAY -e DOMAIN=$DOMAIN \
		-e TARGET=$TARGET -e IP=$IP -e TZ=$TIME_ZONE -e NAME=$1 \
    -v `pwd`/.kali-logs:$HOME/.logs:rw -v `pwd`:/$1 \
    -v $HOME/.Xauthority:$HOME/.Xauthority:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -w /$1 fonalex45/kali-sec:latest
	else
		docker run --name $1 -it \
		--net=host --entrypoint=/bin/zsh \
		--cap-add=NET_ADMIN \
		-e DOMAIN=$DOMAIN -e DISPLAY=$DISPLAY \
    -e TARGET=$TARGET -e IP=$IP \
    -e TZ=$TIME_ZONE -e NAME=$1 \
		-v `pwd`/.kali-logs:/root/.logs:rw -v `pwd`:/$1 \
		-v $HOME/.Xauthority:$HOME/.Xauthority:ro -v /tmp/.X11-unix:/tmp/.X11-unix \
		-w /$1 fonalex45/kali-sec:latest
	fi
}

kali-start $1 ()
{
 docker container start $1
}

kali-enter $1 ()
{
docker exec -it $1 /bin/zsh
}

kali-stop $1 () {
 docker container stop $1
}

kali-destory $1 () {
 docker container rm $1
}

kali-pull () {
  docker pull fonalex45/kali-sec:latest
}
