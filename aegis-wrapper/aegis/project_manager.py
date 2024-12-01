import os


class ProjectManager:
    def create_project(self, project_name: str):
        """Creates a project directory with subfolders."""
        base_dir = os.path.join(os.getcwd(), project_name)
        subfolders = ['recon', 'exploit', 'www', 'privesc', 'report', 'loot']

        os.makedirs(base_dir, exist_ok=True)
        for folder in subfolders:
            os.makedirs(os.path.join(base_dir, folder), exist_ok=True)

        print(f"Project directory created at {base_dir}")
        return base_dir
        return project_name
