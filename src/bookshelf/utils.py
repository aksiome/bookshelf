import io
import json
import re
import shutil
from collections.abc import Callable, Generator
from contextlib import contextmanager
from datetime import datetime, timezone
from functools import cache
from pathlib import Path
from typing import IO

import portalocker
from jinja2 import Template
from pydantic import BaseModel

YEAR = datetime.now(timezone.utc).year


@cache
def load_json(file: Path) -> dict | list | None:
    """Load a JSON file and return its content."""
    return json.loads(file.read_text("utf-8"))


@cache
def load_template(file: Path) -> Template:
    """Load a Jinja2 template from a file."""
    return Template(file.read_text(encoding="utf-8"))


def namespace(value: str, namespace: str = "minecraft") -> str:
    """Ensure a resource starts with the given namespace."""
    return value if value.startswith(f"{namespace}:") else f"{namespace}:{value}"


def render_template(file: Path, **kwargs: dict[str, object]) -> str:
    """Load and render a Jinja2 template from a file."""
    return load_template(file).render(year=YEAR, **kwargs)


def render_snbt(obj: object) -> str:
    """Render a Python object into Minecraft's SNBT (stringified NBT) format."""
    def quote_key(k: str) -> str:
        return f'"{k}"' if ":" in k or not re.fullmatch(r"[A-Za-z0-9]+", k) else k

    for kind, handler in {
        BaseModel: lambda o: render_snbt(o.model_dump()),
        str: lambda o: f'"{o}"',
        float: lambda o: f"{o}d",
        bool: lambda o: "1b" if o else "0b",
        list: lambda o: f'[{",".join(render_snbt(v) for v in o)}]',
        dict: lambda o: f'{{{",".join(
            f"{quote_key(k)}:{render_snbt(v)}"
            for k, v in sorted(
                ((str(k), v) for k, v in o.items() if v is not None),
                key=lambda item: item[0],
            )
        )}}}',
    }.items():
        if isinstance(obj, kind):
            return handler(obj)

    return str(obj)


def resolve_command(command: str) -> str:
    """Load a JSON file and return its content."""
    if path := shutil.which(command):
        return path
    err = f"The '{command}' command was not found in your system PATH."
    raise FileNotFoundError(err)


def gen_loot_table_tree[T](
    items: list[T],
    entry: Callable[[T], dict],
    conditions: Callable[[list[T]], list],
) -> dict:
    """Generate a binary tree loot table from a list of items."""
    def subtree(items: list[T]) -> dict:
        if len(items) == 1:
            return entry(items[0])

        mid = len(items) // 2
        left, right = items[:mid], items[mid:]

        left_tree = subtree(left)
        right_tree = subtree(right)
        left_tree["conditions"] = conditions(left)

        return {"type":"alternatives","children":[left_tree, right_tree]}

    return {"pools":[{"rolls":1,"entries":[subtree(items)]}]}


@contextmanager
def threadsafe_open() -> Generator[None, None, None]:
    """Patch Path.open to make file operations thread-safe using file locks.

    This is an intentional hack: it replaces Path.open with a version that returns
    a context manager. As a result, Path.open must now be used with a 'with' statement.
    """
    _orig_open = Path.open

    def locked_open( # noqa: PLR0913
        self, # noqa: ANN001
        mode="r", # noqa: ANN001
        buffering=-1, # noqa: ANN001
        encoding=None, # noqa: ANN001
        errors=None, # noqa: ANN001
        newline=None, # noqa: ANN001
    ) -> IO:
        """Open file and lock it for thread-safe reading or writing."""
        if "b" not in mode:
            encoding = io.text_encoding(encoding)

        write_modes = {"w", "a", "x"}
        is_write_mode = any(m in mode for m in write_modes) or "+" in mode
        lock_type = portalocker.LOCK_EX if is_write_mode else portalocker.LOCK_SH
        return portalocker.Lock(
            self,
            mode,
            flags=lock_type,
            buffering=buffering,
            errors=errors,
            newline=newline,
        )

    Path.open = locked_open
    try:
        yield
    finally:
        Path.open = _orig_open
