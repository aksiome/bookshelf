import json
import os
import re
from collections.abc import Callable, Iterable
from datetime import datetime
from functools import wraps
from itertools import takewhile
from pathlib import Path
from typing import Any, Self, TypeVar

from beet import Cache
from jinja2 import Template
from pydantic import BaseModel

from bookshelf.definitions import MODULES_DIR

T = TypeVar("T")

class RedactedString(str):
    """A string wrapper that prevents the accidental exposure of sensitive data."""

    __slots__ = ()

    def __new__(cls, value: str) -> Self:
        """Create a new RedactedString instance."""
        return super().__new__(cls, value)

    def __repr__(self) -> str:
        """Return the string representation, hiding the sensitive data."""
        return "<Redacted>"


def download_and_parse_json[T: dict | list](
    cache: Cache,
    url: str,
    expected: type[T],
) -> T:
    """Get cached downloaded JSON data, asserting it matches expected_type."""
    file = cache.download(url)
    data = json.loads(file.read_text("utf-8"))
    if not isinstance(data, expected):
        error_msg = f"Expected a dict, but got {type(data)}"
        raise TypeError(error_msg)
    return data


def getenv_redacted(key: str, default: str | None = None) -> RedactedString | None:
    """Get an environment variable by key and return it as a RedactedString."""
    if value := os.getenv(key):
        return RedactedString(value)
    return RedactedString(default) if default else None


def matching_len(a: Iterable, b: Iterable) -> int:
    """Return the length of the longest matching prefix between two sequences."""
    return len(list(takewhile(
        lambda x: x[0] == x[1],
        zip(a, b, strict=False),
    )))


def cache_result(
    cache: Cache,
    key: str,
) -> Callable[[Callable[..., Any]], Callable[..., Any]]:
    """Cache the result of a function into a JSON file."""
    def decorator(func: Callable[..., Any]) -> Callable[..., Any]:
        @wraps(func)
        def wrapper(*args: list, **kwargs: dict) -> dict | list:
            cache_path = cache.get_path(key)
            if cache_path.is_file():
                return json.loads(cache_path.read_text("utf-8"))
            result = func(*args, **kwargs)
            with Path(cache_path).open("w") as file:
                json.dump(result, file, indent=None)
            return result
        return wrapper
    return decorator
