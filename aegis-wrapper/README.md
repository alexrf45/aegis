
# Aegis: Docker Wrapper TUI

Aegis is a Python-based command-line tool (TUI) for managing Docker containers with an interactive interface. It helps in pulling images, creating project directories, and running containers with ease.

## Features
- Pull and manage Docker images.
- Start, stop, and destroy containers with options for host networking and GUI support.
- Create project directories with default subfolders (`recon`, `exploit`, `www`, `privesc`, `report`, `loot`).
- Interactive menu using `questionary` and progress bars with `rich`.
- Supports running containers with a `zsh` entrypoint.

## Installation

You can install `aegis` via `pip`:

```bash
pip install aegis
```

# Usage

Run the aegis command with one of the following options:

```bash
Copy code
aegis <command> [options]
```

# Commands
- pull: Pull a Docker image.
- start: Start a container with options for host networking and GUI.
- stop: Stop a running container.
- destroy: Remove a stopped container.

# Options

--image: Specify the Docker image (default: fonalex45/aegis:dev).
--host-network: Enable host networking.
--gui: Enable GUI support.

# Example


```bash

aegis pull
aegis start --image fonalex45/aegis:dev --host-network --gui
aegis stop
aegis destroy
```

# Configuration
Default images and settings can be found in config.py.

# Contributing
Feel free to submit issues or pull requests to improve the project!
