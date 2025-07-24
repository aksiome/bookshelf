import subprocess

import click

from bookshelf.definitions import DOC_DIR, EXAMPLES_DIR
from bookshelf.utils import resolve_command


@click.group()
def docs() -> None:
    """Documentation-related commands."""


@docs.command()
@click.argument("output", required=False)
@click.option("--builder", default="html", help="The builder to use for Sphinx")
def build(
    output: str | None = None,
    builder: str = "html",
) -> None:
    """Build static HTML documentation."""
    cmd = resolve_command("sphinx-build")
    subprocess.run([
        cmd,
        ".",
        "-b",
        builder,
        output if output else "_build",
    ], check=True, cwd=DOC_DIR)


@docs.command()
@click.argument("output", required=False)
@click.option("--builder", default="html", help="The builder to use for Sphinx")
def watch(
    output: str | None = None,
    builder: str = "html",
) -> None:
    """Build and serve live documentation."""
    cmd = resolve_command("sphinx-autobuild")
    try:
        subprocess.run([
            cmd,
            ".",
            "-b",
            builder,
            output if output else "_build", "--watch",
            f"{EXAMPLES_DIR}",
        ], check=True, cwd=DOC_DIR)

    except KeyboardInterrupt:
        click.echo("\nExiting sphinx-autobuild…")
