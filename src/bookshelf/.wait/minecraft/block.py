from beet import Context
from pydantic import BaseModel

from bookshelf.definitions import MC_VERSIONS
from bookshelf.utils import download_and_parse_json, with_prefix

BLOCKS_URL = "https://raw.githubusercontent.com/mcbookshelf/mcdata/refs/tags/v1/{}/blocks/data.min.json"


class Block(BaseModel):
    """Represents a Minecraft block."""

    type: str
    group: int
    can_occlude: bool
    has_shape_offset: bool
    has_visual_offset: bool
    ignited_by_lava: bool
    blast_resistance: float
    friction: float
    hardness: float
    jump_factor: float
    speed_factor: float
    instrument: float
    sounds: dict[str, str]
    states: dict[str, list[str]]
    luminance: StatePredicate[float]
    is_conductive: StatePredicate[bool]
    is_spawnable: StatePredicate[bool]
    shapes: StatePredicate[BlockShapes]


class BlockShapes(BaseModel):
    """Represents Minecraft block shapes."""

    default_shape: list[list[float]]
    collision_shape: list[list[float]]


class BlockProperties(BaseModel):
    """Represents Minecraft block properties."""
