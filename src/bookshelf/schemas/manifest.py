from pathlib import Path
from typing import Self

from pydantic import BaseModel

from bookshelf.definitions import MODULES, MODULES_DIR
from bookshelf.logging import log_counter

from .feature import Feature
from .module import Module


class ExpandedModule(Module):
    """Represents a module with its features in the Bookshelf project."""

    features: list[Feature]

    @classmethod
    def from_file(cls, file: Path, **extra: object) -> Self:
        """Create an ExpandedModule instance from a JSON file."""
        # Collect all JSON files inside the data directory of the module
        features = sorted((file.parent / "data").rglob("*.json"))
        # Attempt to create Feature instances, filtering out None
        extra["features"] = list(filter(None, (
            Feature.try_from_file(feature)
            for feature in features
        )))

        return super().from_file(file, **extra)


class Manifest(BaseModel):
    """Represents the manifest of the Bookshelf project."""

    version: str = "v2"
    modules: list[ExpandedModule]

    @classmethod
    def build(cls) -> Self | None:
        """Build the manifest by gathering modules and features."""
        with log_counter() as counter:
            # Load modules in sorted order and filter out any failures
            manifest = cls(modules=list(filter(None, (
                ExpandedModule.try_from_file(MODULES_DIR / module / "module.json")
                for module in sorted(MODULES)
            ))))
        # Return None if any errors occurred during loading
        return manifest if counter["error"] == 0 else None

    def save(self, file: Path) -> int:
        """Save the manifest as JSON to the given file path."""
        return file.write_text(
            self.model_dump_json(
                indent=2,
                exclude_defaults=True,
                exclude_none=True,
            ),
            newline="\n",
        )
