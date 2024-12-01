import docker
import questionary
from . import docker_manager as dm
# from .docker_manager import pull_image, create_project_dir, run_container, stop_container, destroy_container, create_project_directory
from . import constants


def main():
    client = docker.from_env()

    action = questionary.select(
        "What would you like to do?",
        choices=[
            "Pull Image", "Create Project", "Run Container", "Stop Container",
            "Destroy Container", "Exit"
        ]
    ).ask()

    if action == "Pull Image":
        image_choice = questionary.select(
            "Select the image to pull:",
            choices=list(constants.IMAGE_TAGS.values())
        ).ask()
        dm.pull_image(client, image_choice)

    elif action == "Create Project":
        project_name = questionary.text("Enter project name:").ask()
        dm.create_project_dir(project_name)

    elif action == "Run Container":
        image_choice = questionary.select(
            "Select image to run:", choices=list(constants.IMAGE_TAGS.values())).ask()
        project_dir = questionary.text("Enter project directory:").ask()
        host_network = questionary.confirm("Enable host networking?").ask()
        dm.run_container(client, image_choice, project_dir, host_network)

    elif action == "Stop Container":
        container_id = questionary.text(
            "Enter the container ID to stop:").ask()
        dm.stop_container(container_id)
    elif action == "Destroy Container":
        container_id = questionary.text(
            "Enter the container ID to destroy:").ask()
        dm.destroy_container(container_id)
    elif action == "Create Project Directory":
        project_dir = questionary.text(
            "Enter the project directory path:").ask()
        dm.create_project_directory(project_dir)
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


if __name__ == '__main__':
    main()
