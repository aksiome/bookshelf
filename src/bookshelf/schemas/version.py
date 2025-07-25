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
        try:
            # Split the string and convert each part to an integer
            major, minor, patch = map(int, version.split("."))
            return cls(major=major,minor=minor,patch=patch)
        except ValueError as e:
            error_message = f"Invalid version string: {version!r}"
            raise ValueError(error_message) from e
