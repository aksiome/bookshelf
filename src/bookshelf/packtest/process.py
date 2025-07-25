import asyncio
import logging
import re
from collections.abc import Callable
from dataclasses import dataclass
from pathlib import Path

from bookshelf.utils import resolve_command

logger = logging.getLogger(__name__)


@dataclass
class LogMatcher:
    """Matches a line against a pattern, formats and logs it with given severity."""

    pattern: re.Pattern
    message: str = "{message}"
    severity: int = logging.ERROR
    formatter: Callable[[re.Match], dict] = lambda match: match.groupdict()

    def try_log(self, line: str) -> bool:
        """Attempt to match the line against the pattern and log if matched."""
        if match := self.pattern.search(line):
            extra = self.formatter(match)
            logger.log(
                self.severity, self.message.format(**extra),
                extra=extra,
            )
            return True
        return False


def test_error_formatter(match: re.Match) -> dict:
    """Custom formatter extracting and formatting test failure details from a match."""
    name = match["name"]
    i = name.rfind(".", 0, name.find("/"))
    # Infer the module path and test file from the test name
    return {
        **match.groupdict(),
        "title": f"Test '{name}' failed",
        "file": f"modules/{name[:i]}/data/{name[:i]}/test/{name[i+1:]}.mcfunction",
        "line": int(match["line"]),
    }


LOG_MATCHERS = [
    LogMatcher(re.compile(
        r"::error title=Test (?P<name>bs.*?) "
        r"failed on line (?P<line>\d+)!::(?P<message>.*)",
    ), formatter=test_error_formatter),
    LogMatcher(re.compile(
        r"::error title=(?P<title>.*?)::(?P<message>.*)",
    )),
    LogMatcher(re.compile(
        r"Running test environment 'bs.load:(?P<name>.*?)' batch 0 "
        r"\((?P<count>\d+) tests\)",
    ), "Test 'bs.{name}' module ({count} tests)", logging.DEBUG),
    LogMatcher(re.compile(
        r"(?P<count>\d+) tests are now running at position "
        r"(?P<x>-?\d+), (?P<y>-?\d+), (?P<z>-?\d+)!",
    ), "Run {count} tests at position ({x}, {y}, {z})", logging.DEBUG),
]


async def run_server(cwd: Path) -> int:
    """Run the Java test server, parses its output, and logs relevant lines."""
    java = resolve_command("java")
    flags = ["-Xmx2G", "-Dpacktest.auto", "-Dpacktest.auto.annotations", "-jar"]
    # Start the server process inside the given directory
    process = await asyncio.create_subprocess_exec(
        *[java, *flags, "server.jar", "nogui"],
        cwd=cwd,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.STDOUT,
    )

    # Stream output line-by-line and attempt to match with log patterns
    async for raw_line in process.stdout:
        line = raw_line.decode("utf-8").rstrip()
        for matcher in LOG_MATCHERS:
            if matcher.try_log(line):
                break

    return await process.wait()
