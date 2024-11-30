import os
# from tqdm import tqdm
import questionary
import docker


client = docker.from_env()


IMAGE_DEV = "fonalex45/aegis:dev"
IMAGE_LATEST = "dfonalex45/aegis:latest"


def create_project_directory(base_dir):
    folders = ["recon", "exploit", "www", "privesc", "report", "loot"]
    os.makedirs(base_dir, exist_ok=True)
    for folder in folders:
        os.makedirs(os.path.join(base_dir, folder), exist_ok=True)
    print(f"Project directory created at {base_dir}")


def pull_images():
    for image in [IMAGE_DEV, IMAGE_LATEST]:
        print(f"Pulling {image}...")
        client.images.pull(image)
    print("Images pulled successfully.")


def start_container(image, use_host_network, project_dir):
    volumes = {project_dir: {'bind': '/workspace', 'mode': 'rw'}}
    networking = 'host' if use_host_network else None
    container = client.containers.run(
        image,
        network_mode=networking,
        volumes=volumes,
        detach=True
    )
    print(f"Container started: {container.id}")


def stop_container(container_id):
    container = client.containers.get(container_id)
    container.stop()
    print(f"Container {container_id} stopped.")


def destroy_container(container_id):
    container = client.containers.get(container_id)
    container.remove(force=True)
    print(f"Container {container_id} destroyed.")


def main():
    action = questionary.select(
        "What do you want to do?",
        choices=["Pull Images", "Start Container", "Stop Container",
                 "Destroy Container", "Create Project Directory", "Help"]
    ).ask()

    if action == "Pull Images":
        pull_images()
    elif action == "Start Container":
        image = questionary.select("Select an image", choices=[
                                   IMAGE_DEV, IMAGE_LATEST]).ask()
        use_host_network = questionary.confirm("Enable host networking?").ask()
        project_dir = questionary.text(
            "Enter the project directory path:").ask()
        create_project_directory(project_dir)
        start_container(image, use_host_network, project_dir)
    elif action == "Stop Container":
        container_id = questionary.text(
            "Enter the container ID to stop:").ask()
        stop_container(container_id)
    elif action == "Destroy Container":
        container_id = questionary.text(
            "Enter the container ID to destroy:").ask()
        destroy_container(container_id)
    elif action == "Create Project Directory":
        project_dir = questionary.text(
            "Enter the project directory path:").ask()
        create_project_directory(project_dir)
    elif action == "Help":
        print("""
        aegis commands:
          pull                 - Pull the latest images
          start                - Start a container
          stop                 - Stop a container
          destroy              - Destroy a container
          create-project       - Create project directory
          help                 - Show this help menu
        """)
