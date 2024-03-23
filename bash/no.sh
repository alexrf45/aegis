#!/bin/bash

# Define some variables
DOCKER_CMD="docker"
DOCKER_IMAGE="debian"
DOCKER_CONTAINER="my-container"
#DOCKER_PORT="8080:80

get_input() {
	local name="$1"
	local prompt="$2"
	local default="$3"

	# Use gum to prompt the user for input
	gum input --prompt "$prompt" \
		--default "$default" \
		--name "$name" \
		--format "{{ .Answer }}"

	# Retrieve the answer from gum and return it
	gum choose \
		--cursor-prefix="○ " \
		--selected-prefix="◉ " --unselected-prefix="○ " \
		--name "$name" \
		--format "{{ .Answer }}"
}

start_container() {
	echo "Starting container with host networking..."
	$DOCKER_CMD run -d --name $DOCKER_CONTAINER --net=host $DOCKER_IMAGE
	echo "Container started."
}

stop_container() {
	echo "Stopping container..."
	$DOCKER_CMD stop $DOCKER_CONTAINER
	$DOCKER_CMD rm $DOCKER_CONTAINER
	echo "Container stopped."
}

show_logs() {
	echo "Showing container logs..."
	$DOCKER_CMD logs $DOCKER_CONTAINER
}

show_help() {
	echo "Usage: docker-cli.sh [start|stop|logs|help]"
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
