import logging
import os
from collections.abc import Generator, MutableMapping
from contextlib import contextmanager
from types import MappingProxyType
from typing import Any, ClassVar

from colorama import Fore, Style


class CustomLogRecord(logging.LogRecord):
    """Custom log record."""

    title: str = ""
    file: str = ""
    line: int = 0
    depth: int = 0
    step: bool = False
    end_step: bool = False


class BaseFormatter(logging.Formatter):
    """Base class for shared formatting logic."""

    COLORS = MappingProxyType({
        logging.DEBUG: Fore.LIGHTBLACK_EX,
        logging.INFO: Fore.WHITE,
        logging.WARNING: Fore.YELLOW,
        logging.ERROR: Fore.RED,
        logging.CRITICAL: Fore.LIGHTRED_EX,
    })

    def adjust_depth(self, record: CustomLogRecord) -> int:
        """Adjust the depth for hierarchical indentation."""
        return record.depth - int(record.step) - int(record.end_step)

    def get_prefix(self, record: CustomLogRecord) -> str:
        """Get the prefix for the log message."""
        color = self.COLORS.get(record.levelno, "")
        return str(color) + (f"{record.title}: " if record.title else "")

    def ensure_custom_record(self, record: logging.LogRecord) -> CustomLogRecord:
        """Ensure the record is a CustomLogRecord."""
        if isinstance(record, CustomLogRecord):
            return record

        return CustomLogRecord(
            record.name,
            record.levelno,
            record.pathname,
            record.lineno,
            record.msg,
            record.args,
            record.exc_info,
            record.funcName,
            record.stack_info,
        )


class ConsoleFormatter(BaseFormatter):
    """Formatter for console logs with color and indentation support."""

    def format(self, record: logging.LogRecord) -> str:
        """Format the log record for console output."""
        message = super().format(record)
        record = self.ensure_custom_record(record)
        indent = "   " * self.adjust_depth(record)
        return f"{indent}{self.get_prefix(record)}{message}{Style.RESET_ALL}"


class GithubFormatter(BaseFormatter):
    """Formatter for GitHub Actions logs with annotation support."""

    ANNOTATIONS = MappingProxyType({
        logging.WARNING: "warning",
        logging.ERROR: "error",
        logging.CRITICAL: "error",
    })

    def format(self, record: logging.LogRecord) -> str:
        """Format the log record for GitHub Actions output."""
        message = super().format(record)
        record = self.ensure_custom_record(record)
        if record.step:
            return f"::group::{message}"
        if record.end_step:
            return f"::endgroup::\n{message}"

        if annotation := self.ANNOTATIONS.get(record.levelno):
            return f"::{annotation} {",".join(filter(None, [
                f"title={record.title}" if record.title else "",
                f"file={record.file}" if record.file else "",
                f"line={record.line}" if record.line else "",
            ]))}::{message}"

        return f"{self.get_prefix(record)}{message}{Style.RESET_ALL}"


class StepLogger(logging.LoggerAdapter):
    """Tracks warnings and errors during a logging step."""

    contexts: ClassVar[list["StepLogger"]] = []

    def __init__(
        self,
        logger: logging.Logger,
    ) -> None:
        """Initialize a new StepLogger."""
        self.errors = 0
        self.warnings = 0
        StepLogger.contexts.append(self)
        super().__init__(logger, {"depth": len(StepLogger.contexts)})

    def log(
        self,
        level: int,
        msg: object,
        *args: object,
        **kwargs: Any, # noqa: ANN401
    ) -> None:
        """Log a message and track warning/error counts."""
        if level >= logging.ERROR:
            self.errors += 1
        elif level >= logging.WARNING:
            self.warnings += 1
        super().log(level, msg, *args, **kwargs)

    def process(
        self,
        msg: object,
        kwargs: MutableMapping[str, Any],
    ) -> tuple[Any, MutableMapping[str, Any]]:
        """Merge the log message with extra context."""
        extra = dict(self.extra) if self.extra is not None else {}
        extra.update(kwargs.get("extra", {}))
        kwargs["extra"] = extra
        return msg, kwargs

    def close(self) -> None:
        """Close the context and log a summary message if there are no more parent."""
        if StepLogger.contexts:
            StepLogger.contexts.pop()

        if StepLogger.contexts:
            StepLogger.contexts[-1].errors += self.errors
            StepLogger.contexts[-1].warnings += self.warnings
            return

        extra = {"end_step": True}
        match self.errors, self.warnings:
            case 0, 0:
                self.info("✅ Done!", extra=extra)
            case 0, w:
                self.info(f"🔔 Done with {w} warning(s).", extra=extra)
            case e, 0:
                self.info(f"🚨 Done with {e} error(s).", extra=extra)
            case e, w:
                self.info(f"🚨 Done with {e} error(s) and {w} warning(s).", extra=extra)


@contextmanager
def log_step(message: str | None = None) -> Generator[StepLogger, None, None]:
    """Create a new logging context with optional step message."""
    logger = logging.getLogger("bookshelf")
    step = StepLogger(logger)
    if message:
        step.info(message, extra={"step": True})
    try:
        yield step
    finally:
        step.close()


def get_step_logger() -> StepLogger:
    """Get the current StepLogger or create a new one."""
    if StepLogger.contexts:
        return StepLogger.contexts[-1]
    return StepLogger(logger)


# Set up custom log record factory
logging.setLogRecordFactory(CustomLogRecord)

# Configure logger
logger = logging.getLogger("bookshelf")
handler = logging.StreamHandler()
handler.setFormatter(
    GithubFormatter()
    if os.getenv("GITHUB_WORKSPACE") else
    ConsoleFormatter(),
)
logger.addHandler(handler)
logger.setLevel(logging.DEBUG)
