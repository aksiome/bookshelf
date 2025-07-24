from typing import Self

from pydantic import BaseModel


class Version(BaseModel):
    """Represents a semantic version with major, minor, and patch components."""

    major: int
    minor: int
    patch: int

    @classmethod
    def parse(cls, version: str) -> Self:
        """Parse the version string into a Version with major, minor, and patch."""
        major, minor, patch = map(int, version.split("."))
        return cls(major=major,minor=minor,patch=patch)
