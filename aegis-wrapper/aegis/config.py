
# Default Docker images
DEFAULT_IMAGES = {
    "dev": "fonalex45/aegis:dev",
    "latest": "fonalex45/aegis:latest"
}

# Default project subfolders
PROJECT_SUBFOLDERS = ['recon', 'exploit', 'www', 'privesc', 'report', 'loot']

# Docker configuration
DOCKER_ENTRYPOINT = "zsh"

# GUI-related environment variables
GUI_ENV_VARS = {
    "DISPLAY": ":0"
}
