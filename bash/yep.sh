#!/bin/bash
set -e

# Define a function that uses gum for input and formatting
function get_input {
	local name="$1"
	local prompt="$2"
	local default="$3"

	# Use gum to prompt the user for input
	gum input --prompt "$prompt" --default "$default" --name "$name" --format "{{ .Answer }}"

	# Retrieve the answer from gum and return it
	gum choose --name "$name" --format "{{ .Answer }}"
}

# Prompt the user for the image name
image_name=$(get_input "image_name" "Enter the name of the Docker image to use" "ubuntu")

# Prompt the user for the container name
container_name=$(get_input "container_name" "Enter a name for the Docker container" "my-container")

# Run the Docker container
docker run --name "$container_name" "$image_name"
