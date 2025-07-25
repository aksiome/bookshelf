import logging
import sys
from dataclasses import dataclass, field
from pathlib import Path

import click
from beet import PackConfig, Project, ProjectConfig
from rich.progress import (
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
)

from bookshelf.definitions import BUILD_DIR, MODULES, MODULES_DIR, ROOT_DIR, SRC_DIR
from bookshelf.logging import log_group
from bookshelf.schemas import Feature, Module
from bookshelf.utils import render_template

logger = logging.getLogger(__name__)


@dataclass
class BuildOptions:
    """Options for configuring the module build process."""

    output: Path | None = None
    meta: dict = field(default_factory=dict)
    require: list[str] = field(default_factory=list)
    zipped: bool = False


@click.group()
def modules() -> None:
    """Modules-related commands."""


@modules.command()
@click.argument("modules", nargs=-1)
def build(modules: tuple[str, ...]) -> None:
    """Build the specified modules."""
    with log_group("🔨 Building Project…"):
        build_modules(modules or MODULES, BuildOptions(
            output=BUILD_DIR,
        ))


@modules.command()
def release() -> None:
    """Build and release zipped modules."""
    with log_group("🔨 Building Project…"):
        build_modules(MODULES + sorted([
            mod.name
            for mod in MODULES_DIR.iterdir()
            if mod.is_dir() and mod.name.startswith("@")
        ]), BuildOptions(
            meta={"autosave":{"link":False}},
            require=["bookshelf.plugins.release_pack"],
            zipped=True,
        ))


@modules.command()
@click.option(
    "--version",
    type=click.Choice(["latest", "all"], case_sensitive=False),
    default="latest",
    help="Which Minecraft version(s) to test against: 'latest' (default) or 'all'.",
)
def test(version: str) -> None:
    """Build and test modules."""
    with log_group("🔨 Building Project…"):
        build_module("@suite", BuildOptions(
            output=BUILD_DIR,
            meta={"autosave":{"link":False}},
            require=["bookshelf.plugins.load_tests"],
            zipped=True,
        ))


@modules.command()
def check() -> None:
    """Run all module checks: metadata, features, and function headers."""
    with log_group("🔍 Checking Modules…") as counter, Progress(
        SpinnerColumn(finished_text="[green]✔"),
        TextColumn("[progress.description]{task.description}"),
        MofNCompleteColumn(),
    ) as progress:
        check_modules(progress)
        check_features(progress)
        check_functions(progress)
        check_requirements(progress)
    sys.exit(counter.get("error", 0))


def build_modules(modules: list[str], options: BuildOptions | None = None) -> None:
    """Build a list of modules with progress reporting."""
    with Progress(
        SpinnerColumn(finished_text="[green]✔"),
        TextColumn("[progress.description]{task.description}"),
        TimeElapsedColumn(),
    ) as progress:
        tasks = {
            module: progress.add_task(f"Building module [green]{module}", total=1)
            for module in modules
        }
        for module in modules:
            build_module(module, options)
            progress.advance(tasks[module])


def build_module(module: str, options: BuildOptions | None = None) -> None:
    """Build a single module using the given build options."""
    options = options or BuildOptions()
    pack_config = PackConfig(
        compression="deflate",
        compression_level=9,
        zipped=True,
    ) if options.zipped else PackConfig()

    Project(ProjectConfig(
        extend="module.json", # type: ignore[arg-type]
        broadcast=[MODULES_DIR / module], # type: ignore[arg-type]
        data_pack=pack_config,
        resource_pack=pack_config,
        output=options.output,
        meta=options.meta,
        require=[
            *options.require,
            "bookshelf.plugins.set_pack_meta",
        ],
    ).resolve(ROOT_DIR)).build()


def check_features(progress: Progress) -> None:
    """Validate all feature metadata JSON files."""
    for feature in progress.track(
        list(MODULES_DIR.rglob("*/data/**/*.json")),
        description="Checking features metadata",
    ):
        Feature.try_from_file(feature)


def check_modules(progress: Progress) -> None:
    """Validate all module metadata JSON files."""
    for module in progress.track(
        MODULES,
        description="Checking modules metadata",
    ):
        Module.try_from_file(MODULES_DIR / module / "module.json")


def check_functions(progress: Progress) -> None:
    """Ensure all .mcfunction files begin with the correct header."""
    template = render_template(SRC_DIR / "bookshelf/templates/header.jinja")

    for file in progress.track(
        list(MODULES_DIR.rglob("*/data/**/*.mcfunction")),
        description="Checking function headers",
    ):
        lines = file.read_text("utf-8").splitlines()
        header = "\n".join(lines[:len(template.splitlines())])

        if header.strip() != template.strip():
            simple_path = file.relative_to(ROOT_DIR)
            logger.error(
                "Found invalid header in file: %s",
                simple_path,
                extra={
                    "title": "Missing Header Error",
                    "file": simple_path,
                },
            )


def check_requirements(progress: Progress) -> None:
    """Verify required files exist in each module."""
    required = [
        (module, path)
        for module in MODULES
        for path in [
            MODULES_DIR / module / "module.json",
            MODULES_DIR / module / "README.md",
            MODULES_DIR / module / "pack.png",
            MODULES_DIR / module / f"data/{module}/function/__load__.mcfunction",
            MODULES_DIR / module / f"data/{module}/function/__unload__.mcfunction",
        ]
    ]

    for module, file in progress.track(
        required,
        description="Checking required files",
    ):
        if not file.exists():
            logger.error(
                "File '%s' is missing from module '%s'.",
                file.name,
                module,
                extra={"title": "Missing Required File", "file": file},
            )
