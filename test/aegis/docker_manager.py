import docker as client
import os
from . import constants
from tqdm import tqdm
# import fancyprint


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


def run_container(client, image, project_dir, project_name, host_network):
    container = client.containers.run(
        image,
        name=project_name,
        command='/bin/zsh',
        volumes={os.path.abspath(project_dir): {
            'bind': '/workspace', 'mode': 'rw'}},
        network_mode='host' if host_network else None,
        detach=False,
        stdin_open=True,
        tty=True
    )
    print(f"Container {container.short_id} started.")
    return container


def stop_container(container_id):
    container = client.containers.get(container_id)
    container.stop()
    print(f"Container {container_id} stopped.")


def destroy_container(container_id):
    container = client.containers.get(container_id)
    container.remove(force=True)
    print(f"Container {container_id} destroyed.")
