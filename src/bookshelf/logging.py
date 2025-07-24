import logging
from collections import Counter
from collections.abc import Generator
from contextlib import contextmanager
from json import JSONDecodeError
from pathlib import Path
from typing import Any

from pydantic import ValidationError
from rich.console import Console
from rich.logging import RichHandler
from rich.panel import Panel
from rich.traceback import install


class LogCounterHandler(logging.Handler):
    """A logging handler that counts log messages by level."""

    def __init__(self) -> None:
        """Initialize the LogCounterHandler."""
        super().__init__()
        self.counts = Counter()

    def emit(self, record: logging.LogRecord) -> None:
        """Count the log message by its level."""
        self.counts[record.levelname.lower()] += 1


@contextmanager
def log_counter(
    logger: logging.Logger | None = None,
) -> Generator[Counter, Any, None]:
    """Context manager to count log messages."""
    logger = logger or logging.getLogger("bookshelf")
    handler = LogCounterHandler()
    logger.addHandler(handler)

    try:
        yield handler.counts
    finally:
        logger.removeHandler(handler)


@contextmanager
def log_group(
    message: str,
    logger: logging.Logger | None = None,
) -> Generator[bool, Any, None]:
    """Context manager to group logs and print a summary at the end."""
    console = Console()
    console.print(Panel.fit(message), style="blue b")
    with log_counter(logger) as counter:
        yield counter

    match counter["error"], counter["warning"]:
        case 0, 0:
            console.print("\n✅ DONE!\n", style="green b")
        case 0, w:
            console.print(f"\n🔔 DONE with {w} WARNING\n", style="yellow b")
        case e, 0:
            console.print(f"\n🚨 DONE with {e} ERROR\n", style="red b")
        case e, w:
            console.print(f"\n🚨 DONE with {e} ERROR and {w} WARNING\n", style="red b")


@contextmanager
def log_json_error(
    file: Path,
    logger: logging.Logger | None = None,
) -> Generator[Counter, Any, None]:
    """Context manager to catch and log JSONDecodeError."""
    try:
        yield
    except JSONDecodeError as e:
        logger = logger or logging.getLogger("bookshelf")
        logger.error(
            "Invalid JSON in file '%s':\n%s",
            file.as_posix(),
            e,
            extra={
                "title": "Json Decode Error",
                "file": file.as_posix(),
                "line": e.lineno,
            },
        )


@contextmanager
def log_validation_error(
    file: Path,
    logger: logging.Logger | None = None,
) -> Generator[Counter, Any, None]:
    """Context manager to catch and log Pydantic ValidationError."""
    try:
        yield
    except ValidationError as e:
        logger = logger or logging.getLogger("bookshelf")
        logger.error(
            "Validation error in file '%s':\n%s",
            file.as_posix(),
            e,
            extra={
                "title": "Validation Error",
                "file": file,
            },
        )


FORMAT = "%(message)s"
logging.basicConfig(
    level="INFO", format=FORMAT, datefmt="[%X]", handlers=[RichHandler(
        rich_tracebacks=True,
        show_path=False,
        show_time=False,
    )],
)

install()
