
import questionary
from .docker_manager import pull_image, create_project_dir, run_container


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
            choices=list(IMAGE_TAGS.values())
        ).ask()
        pull_image(client, image_choice)

    elif action == "Create Project":
        project_name = questionary.text("Enter project name:").ask()
        create_project_dir(project_name)

    elif action == "Run Container":
        image_choice = questionary.select(
            "Select image to run:", choices=list(IMAGE_TAGS.values())).ask()
        project_dir = questionary.text("Enter project directory:").ask()
        host_network = questionary.confirm("Enable host networking?").ask()
        run_container(client, image_choice, project_dir, host_network)


if __name__ == '__main__':
    main()
