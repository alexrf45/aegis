import os


class ProjectManager:
    def create_project(self):
        """Creates a project directory with subfolders."""
        project_name = input("Enter project name: ")
        base_dir = os.path.join(os.getcwd(), project_name)
        subfolders = ['recon', 'exploit', 'www', 'privesc', 'report', 'loot']

        os.makedirs(base_dir, exist_ok=True)
        for folder in subfolders:
            os.makedirs(os.path.join(base_dir, folder), exist_ok=True)

        print(f"Project directory created at {base_dir}")
        return base_dir
