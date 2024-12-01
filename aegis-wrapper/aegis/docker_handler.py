import docker
import os
import time
from rich.progress import Progress, TimeRemainingColumn, BarColumn, DownloadColumn, TextColumn, SpinnerColumn


class DockerHandler:
    def __init__(self):
        self.client = docker.from_env()

    def pull_image(self, image_name: str):
        """Pulls a Docker image with a progress bar
        showing time remaining and download speed."""
        with Progress(
            SpinnerColumn(),
            TextColumn("[bold blue]{task.fields[status]}", justify="right"),
            BarColumn(),
            "[progress.percentage]{task.percentage:>3.1f}%",
            DownloadColumn(),
            TimeRemainingColumn(),
        ) as progress:
            task = progress.add_task(
                "Pulling image...",
                total=None,
                status=f"Starting download: {image_name}",
            )

            last_progress = 0
            start_time = time.time()

            for line in self.client.api.pull(image_name,
                                             stream=True,
                                             decode=True):
                if 'status' in line and line['status'] in ['Downloading', 'Extracting']:
                    progress.update(
                        task,
                        advance=1,
                        total=None,
                        status=line['status'],
                    )

                if 'progressDetail' in line:
                    details = line['progressDetail']
                    if 'current' in details and 'total' in details:
                        progress.update(
                            task,
                            completed=details['current'],
                            total=details['total'],
                            status=f"{line['status']}: {
                                details['current']}/{details['total']} bytes",
                        )

            elapsed_time = time.time() - start_time
            progress.update(task, completed=1, status=f"Completed in {
                            elapsed_time:.2f} seconds.")
            progress.remove_task(task)

    def start_container(self,
                        image_name: str,
                        project_name: str,
                        project_dir: str,
                        host_network: bool,
                        gui: bool):
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
            detach=False,
            stdin_open=True,
            network_mode="host" if host_network else None,
            volumes=volumes,
            environment=environment,
            tty=True
        )
        container.attach(stream=True, logs=True)
        print(f"Container '{project_name}' started and attached.")
        # print(f"Container {container.short_id} started.")

    def stop_container_by_name(self, project_name: str):
        """Stops a container by project name."""
        container = self.client.containers.get(project_name)
        container.stop()
        print(f"Container '{project_name}' stopped.")

    def remove_container_by_name(self, project_name: str):
        """Removes a container by project name."""
        container = self.client.containers.get(project_name)
        container.remove(force=True)
        print(f"Container '{project_name}' removed.")
