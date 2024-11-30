import docker
from questionary import confirm
import os

client = docker.from_env()


def pull_image(image_name):
    print(f"Pulling image: {image_name}")
    client.images.pull(image_name)


def start_container(profile, mount_path=None):
    print(f"Starting container: {profile['name']}")
    host_network = profile['options'].get('host_networking', False)
    default_mount = profile['options'].get('default_mount', '')

    if not mount_path and default_mount:
        mount_path = default_mount

    mounts = {}
    if mount_path:
        src, target = mount_path.split(":")
        mounts[src] = {'bind': target, 'mode': 'rw'}

    client.containers.run(
        profile['image'],
        detach=True,
        network_mode="host" if host_network else None,
        volumes=mounts,
        tty=True,
    )


def stop_container(container_id):
    container = client.containers.get(container_id)
    container.stop()
    container.remove()
