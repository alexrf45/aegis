import sys
import questionary
import docker
from .utils import pull_images, start_container, stop_container, destroy_container, create_project_directory


client = docker.from_env()


def run_cli():
    action = questionary.select(
        "What do you want to do?",
        choices=["Pull Images", "Start Container", "Stop Container",
                 "Destroy Container", "Create Project Directory", "Help"]
    ).ask()

    if action == "Pull Images":
        pull_images()
    elif action == "Start Container":
        image = questionary.select("Select an image", choices=[
                                   "fonalex45/aegis:dev", "fonalex45/aegis:latest"]).ask()
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


def main():
    run_cli()


if __name__ == "__main__":
    main()
