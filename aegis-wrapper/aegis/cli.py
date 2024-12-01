import argparse
import questionary
from aegis.docker_handler import DockerHandler
from aegis.project_manager import ProjectManager
from aegis.utils import validate_project_name, log_error


def main():
    parser = argparse.ArgumentParser(description="Aegis Docker Wrapper TUI")
    parser.add_argument('command', choices=[
                        'start', 'stop', 'destroy', 'pull'],
                        help="Action to perform")
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
        project_name = questionary.text("Enter project name").ask()
        try:
            validated_name = validate_project_name(project_name)
            project_dir = project_manager.create_project(validated_name)
            docker_handler.start_container(
                image_name=args.image or 'fonalex45/aegis:dev',
                name=validated_name,
                project_dir=project_dir,
                host_network=args.host_network,
                gui=args.gui
            )
        except ValueError as e:
            log_error(str(e))
            return
    elif args.command == 'stop':
        project_name = questionary.text(
            "Enter project name to stop container").ask()
        try:
            validated_name = validate_project_name(project_name)
            docker_handler.stop_container_by_name(validated_name)
        except ValueError as e:
            log_error(str(e))

    elif args.command == 'destroy':
        project_name = questionary.text(
            "Enter project name to destroy container").ask()
        try:
            validated_name = validate_project_name(project_name)
            docker_handler.remove_container_by_name(validated_name)
        except ValueError as e:
            log_error(str(e))


if __name__ == "__main__":
    main()
