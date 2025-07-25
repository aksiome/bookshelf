from collections.abc import Generator

from beet import Context, TagFile


def beet_default(ctx: Context) -> Generator:
    """Add `"replace": true` to all tags in this module."""
    yield

    for _, file in ctx.data.all(f"{ctx.directory.name}:*", extend=TagFile): # type: ignore[type-var]
        # Insert "replace": true before the "values" key to preserve order
        pos = list(file.data.keys()).index("values")
        items = list(file.data.items())
        items.insert(pos, ("replace", True))
        file.set_content(dict(items))
