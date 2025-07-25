import json
from collections.abc import Callable, Iterable
from functools import wraps
from itertools import takewhile
from pathlib import Path
from typing import Any

from beet import Cache


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
