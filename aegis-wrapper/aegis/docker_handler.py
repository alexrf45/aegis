import docker
import os
from rich.progress import Progress


class DockerHandler:
    def __init__(self):
        self.client = docker.from_env()

    def pull_image(self, image_name: str):
        """Pulls a Docker image with a progress bar."""
        with Progress() as progress:
            task = progress.add_task(f"Pulling {image_name}", total=None)
            for line in self.client.api.pull(image_name, stream=True, decode=True):
                if 'status' in line and line['status'] == 'Downloading':
                    progress.update(task, advance=1)
            progress.remove_task(task)

    def start_container(self, image_name: str, project_dir: str, host_network: bool, gui: bool):
        """Starts a container with specified options."""
        volumes = {project_dir: {'bind': '/project', 'mode': 'rw'}}
        environment = {}

        if gui:
            environment["DISPLAY"] = os.environ.get("DISPLAY")
            volumes["/tmp/.X11-unix"] = {
                'bind': '/tmp/.X11-unix', 'mode': 'rw'}

        container = self.client.containers.run(
            image=image_name,
            command="zsh",
            detach=True,
            network_mode="host" if host_network else None,
            volumes=volumes,
            environment=environment,
            tty=True,
        )
        print(f"Container {container.short_id} started.")

    def stop_container(self, container_id: str):
        """Stops a running container."""
        container = self.client.containers.get(container_id)
        container.stop()
        print(f"Container {container_id} stopped.")

    def remove_container(self, container_id: str):
        """Removes a stopped container."""
        container = self.client.containers.get(container_id)
        container.remove()
        print(f"Container {container_id} removed.")
