import logging
from rich.progress import Progress

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
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


def validate_container_id(container_id: str):
    """Validates the format of a Docker container ID."""
    if len(container_id) != 12:
        raise ValueError("Invalid container ID. Must be 12 characters.")
    return container_id
