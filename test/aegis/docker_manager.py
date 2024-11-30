import docker
import os
import constants
from tqdm import tqdm


def pull_image(client, image_tag):
    print(f"Pulling image: {image_tag}")
    for line in client.api.pull(image_tag, stream=True, decode=True):
        if 'status' in line:
            print(line['status'])


def create_project_dir(project_name):
    os.makedirs(project_name, exist_ok=True)
    for folder in constants.DEFAULT_DIRECTORIES:
        os.makedirs(os.path.join(project_name, folder), exist_ok=True)
    print(f"Project directories created under {project_name}.")


def run_container(client, image, project_dir, host_network):
    container = client.containers.run(
        image,
        command='/bin/zsh',
        volumes={os.path.abspath(project_dir): {
            'bind': '/workspace', 'mode': 'rw'}},
        network_mode='host' if host_network else None,
        detach=True,
        stdin_open=True,
        tty=True
    )
    print(f"Container {container.short_id} started.")
    return container
