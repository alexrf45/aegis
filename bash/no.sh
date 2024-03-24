#!/bin/bash

#GUM variables

export GUM_INPUT_CURSOR_FOREGROUND="#FF0"
export GUM_INPUT_PROMPT_FOREGROUND="#0FF"
export GUM_INPUT_PLACEHOLDER="What's up?"
export GUM_INPUT_PROMPT="$ "
export GUM_INPUT_WIDTH=80
#export BORDER_BACKGROUND="212"
export BORDER_FOREGROUND="255"
export BORDER="rounded"
export BACKGROND="212"
export FOREGROUND="67"

$project=$1
$image=$2

while getopts ":p:i:start:stop:destroy:logs:help" opt; do
	case "$opt" in
	p)
		$project=$OPTARG
		;;
	i)
		$image=$OPTARG
		;;
	"start")
		start_container
		;;
	"stop")
		stop_container
		;;
	"destory")
		destroy
		;;
	"logs")
		show_logs
		;;
	"help")
		Usage
		;;
	*)
		exit 1
		;;
	esac
done

Usage() {
	gum style \
		--foreground $FOREGROUND --border $BORDER \
		--align left --width 35 \
		"aegis [ start|stop|destroy|pull ]"
	exit 1
}

if [ -z "$project" ]; then
	gum style --border $BORDER --foreground $FOREGROUND --width 25 "[-] Project name required"
	Usage
fi

if [ -z "$image" ]; then

	gum style --border $BORDER --foreground $FOREGROUND --width 25 "[-] image tag required 'dev, latest' "
	Usage
fi

start_container() {
	gum style \
		--foreground $FOREGROUND --border-foreground $BORDER_FOREGROUND --border $BORDER \
		--align center --width 50 --margin "1 2" --padding "2 4"
	mkdir -p $project/{recon,www,exploit,pivot,report} &&
		cd $project &&
		mkdir .kali-logs &&
		docker run --name $project -it \
			--net=host --entrypoint=/bin/bash \
			--cap-add=NET_ADMIN \
			--cap-add=CAP_SYS_TIME \
			-e DISPLAY=$DISPLAY -e DOMAIN=$DOMAIN \
			-e TARGET=$project -e IP=$IP -e TZ=$TIME_ZONE -e NAME=$project \
			-v $(pwd)/.kali-logs:$HOME/.logs:rw -v $(pwd):/$project \
			-v $HOME/.Xauthority:$HOME/.Xauthority:ro \
			-v /tmp/.X11-unix:/tmp/.X11-unix \
			-w /$1 fonalex45/aegis:$image
}

stop_container() {
	gum style \
		--foreground 212 --border-foreground 212 --border double \
		--align center --width 60 --margin "1 2" --padding "2 4" \
		"Stopping container..."
	docker container stop $project \
		gum style \
		--foreground 212 --border-foreground 212 --border double \
		--align center --width 60 --margin "1 2" --padding "2 4" \
		"Container stopped."
}

show_logs() {
	gum style \
		--foreground 212 --border-foreground 212 --border double \
		--align center --width 60 --margin "1 2" --padding "2 4" \
		"Showing container logs..."
	docker logs $project
}

show_help() {
	gum style \
		--foreground 212 --border-foreground 212 --border double \
		--align center --width 60 --margin "1 2" --padding "2 4" \
		'Usage: kali [start|stop|logs|help]'
}

# Parse the command-line arguments
case "$1" in
"start")
	start_container
	;;
"stop")
	stop_container
	;;
"logs")
	show_logs
	;;
"help")
	show_help
	;;
*)
	show_help
	exit 1
	;;
esac
