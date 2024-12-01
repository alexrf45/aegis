import argparse
import questionary
from aegis.docker_handler import DockerHandler
from aegis.project_manager import ProjectManager


def main():
    parser = argparse.ArgumentParser(description="Aegis Docker Wrapper TUI")
    parser.add_argument('command', choices=[
                        'start', 'stop', 'destroy', 'pull'], help="Action to perform")
    parser.add_argument('--image', help="Docker image to use")
    parser.add_argument('--host-network', action='store_true',
                        help="Enable host networking")
    parser.add_argument('--gui', action='store_true',
                        help="Enable GUI support")
    args = parser.parse_args()

    docker_handler = DockerHandler()
    project_manager = ProjectManager()

    if args.command == 'pull':
        image = questionary.select(
            "Select an image to pull",
            choices=['fonalex45/aegis:dev',
                     'fonalex45/aegis:latest', 'Custom']
        ).ask()
        if image == 'Custom':
            image = questionary.text("Enter the custom image name").ask()
        docker_handler.pull_image(image)

    elif args.command == 'start':
        project_dir = project_manager.create_project()
        docker_handler.start_container(
            image_name=args.image or 'fonalex45/aegis:dev',
            project_dir=project_dir,
            host_network=args.host_network,
            gui=args.gui
        )

    elif args.command == 'stop':
        container_id = questionary.text("Enter container ID to stop").ask()
        docker_handler.stop_container(container_id)

    elif args.command == 'destroy':
        container_id = questionary.text("Enter container ID to remove").ask()
        docker_handler.remove_container(container_id)


if __name__ == "__main__":
    main()
