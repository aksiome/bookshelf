import logging
import re
from pathlib import Path
from typing import Self

from pydantic import BaseModel, Field

from bookshelf.definitions import DOC_URL, MODULES_DIR, ROOT_DIR
from bookshelf.logging import log_json_error, log_validation_error
from bookshelf.utils import load_json

logger = logging.getLogger(__name__)


class Updated(BaseModel):
    """Represents metadata about when a feature or module was last updated."""

    # Date string in YYYY/MM/DD format
    date: str = Field(pattern=r"^\d{4}/(0[1-9]|1[0-2])/(0[1-9]|[1-2]\d|3[0-1])$")
    minecraft_version: str


class Feature(BaseModel):
    """Represents metadata for a feature within the library."""

    id: str
    kind: str
    documentation: str = Field(pattern=rf"^{re.escape(DOC_URL)}/en/latest/modules/.+$")
    authors: list[str]
    contributors: list[str] = Field(default_factory=list)
    created: Updated
    updated: Updated

    @classmethod
    def from_file(cls, file: Path, **extra: object) -> Self:
        """Create a Feature instance from a JSON file."""
        data = load_json(file)
        meta = data.get("__bookshelf__", {})

        if not meta.get("feature"):
            error_message = f"File '{file}' is not a valid feature"
            raise ValueError(error_message)

        feature_id, feature_kind = resolve_feature(file)
        return cls(id=feature_id, kind=feature_kind, **meta, **extra)

    @classmethod
    def try_from_file(cls, file: Path, **extra: object) -> Self | None:
        """Create a Feature instance from a JSON file with error handling."""
        data = load_json(file)
        meta = data.get("__bookshelf__", {})

        if not meta.get("feature"):
            return None

        simple_path = file.relative_to(ROOT_DIR)
        with log_json_error(simple_path), log_validation_error(simple_path):
            feature_id, feature_kind = resolve_feature(file)
            return cls(id=feature_id, kind=feature_kind, **meta, **extra)


def resolve_feature(file: Path) -> tuple[str, str]:
    """Extract the feature ID and kind from a module file path."""
    parts = file.relative_to(MODULES_DIR).parts
    # Special case for tags, prepend '#' and append '_tag' to kind
    if parts[3] == "tags":
        feature_id = f"#{parts[2]}:{'/'.join(parts[5:]).removesuffix('.json')}"
        feature_kind = f"{parts[4]}_tag"
    else:
        feature_id = f"{parts[2]}:{'/'.join(parts[4:]).removesuffix('.json')}"
        feature_kind = parts[3]
    # Feature ID example: 'module:feature/path/to/feature'
    return feature_id, feature_kind
