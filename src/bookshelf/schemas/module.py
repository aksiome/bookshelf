import logging
import re
from collections.abc import Sequence
from enum import StrEnum
from pathlib import Path
from typing import Any, Self

from pydantic import BaseModel, Field

from bookshelf.definitions import DOC_URL, GITHUB_CONTENT_URL, ROOT_DIR
from bookshelf.logging import log_json_error, log_validation_error
from bookshelf.utils import load_json

logger = logging.getLogger(__name__)

RECOMMENDED_FIELDS = ["tags"]


class ModuleKind(StrEnum):
    """Enumeration for module kinds."""

    COMBINED = "combined"
    DATA_PACK = "data_pack"
    RESOURCE_PACK = "resource_pack"

    @classmethod
    def try_from_data(cls, data: dict[str, Any]) -> Self | None:
        """Determine the kind of module based on its data."""
        has_data_pack = "data_pack" in data
        has_resource_pack = "resource_pack" in data

        if has_data_pack and has_resource_pack:
            return cls.COMBINED
        if has_data_pack:
            return cls.DATA_PACK
        if has_resource_pack:
            return cls.RESOURCE_PACK

        return None


class Module(BaseModel):
    """Represents metadata for a module within the library."""

    id: str = Field(pattern=r"^bs\..+$")
    name: str
    slug: str
    icon: str | None = None
    banner: str | None = None
    readme: str | None = None
    description: str
    documentation: str = Field(pattern=rf"^{re.escape(DOC_URL)}/en/latest/modules/.+$")

    kind: ModuleKind
    tags: list[str] = Field(default_factory=list)
    authors: list[str] = Field(default_factory=list)
    contributors: list[str] = Field(default_factory=list)
    dependencies: list[str] = Field(default_factory=list)
    weak_dependencies: list[str] = Field(default_factory=list)

    @classmethod
    def from_file(cls, file: Path, **extra: object) -> Self:
        """Create a Module instance from a JSON file."""
        data = load_json(file)
        meta = data.get("meta", {}).copy()

        meta["kind"] = ModuleKind.try_from_data(data)
        # Resolve url metadata fields like icon, readme, banner
        resolve_file_urls(meta, file.parent, (
            ("icon", "pack.png"),
            ("readme", "README.md"),
            ("banner", "banner.png"),
        ))

        for field in RECOMMENDED_FIELDS:
            if field not in meta or not meta[field]:
                logger.warning(
                    "Module '%s' is missing recommended field 'meta.%s'.",
                    file.parent.name,
                    field,
                )

        return cls(id=file.parent.name, **meta, **extra)

    @classmethod
    def try_from_file(cls, file: Path, **extra: object) -> Self | None:
        """Create a Module instance from a JSON file with error handling."""
        relative_path = file.relative_to(ROOT_DIR)
        with log_json_error(relative_path), log_validation_error(relative_path):
            return cls.from_file(file, **extra)


def resolve_file_urls(
    meta: dict[str, Any],
    directory: Path,
    mappings: Sequence[tuple[str, str]],
) -> None:
    """Resolve URLs for files and add them to metadata."""
    for key, filename in mappings:
        file = directory / filename
        if file.exists():
            path = file.relative_to(ROOT_DIR)
            meta[key] = GITHUB_CONTENT_URL.format(path.as_posix())
