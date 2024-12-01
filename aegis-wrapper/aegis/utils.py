import logging
import re
from rich.progress import Progress
from rich.logging import RichHandler

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[RichHandler(rich_tracebacks=True)]
)


def log_info(message: str):
    """Logs an info-level message."""
    logging.info(message)


def log_error(message: str):
    """Logs an error-level message."""
    logging.error(message)


def show_progress(task_name: str, total: int):
    """Displays a progress bar."""
    with Progress() as progress:
        task = progress.add_task(task_name, total=total)
        for i in range(total):
            progress.update(task, advance=1)


def validate_project_name(project_name: str):
    """Validates the project name format."""
    if not re.match("^[a-zA-Z0-9_-]+$", project_name):
        raise ValueError(
            """Invalid project name. Only letters, numbers,
            hyphens, and underscores are allowed.""")
    return project_name
