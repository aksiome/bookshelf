from beet import Context
from pydantic import BaseModel

from bookshelf.definitions import MC_VERSIONS
from bookshelf.utils import download_and_parse_json, with_prefix

BIOMES_URL = "https://raw.githubusercontent.com/misode/mcmeta/{}-summary/data/worldgen/biome/data.min.json"


class Biome(BaseModel):
    """Represents a Minecraft biome."""

    type: str
    temperature: float
    has_precipitation: bool


def get_biomes(ctx: Context, version: str = MC_VERSIONS[-1]) -> list["Biome"]:
    """Retrieve biomes from the provided version."""
    cache = ctx.cache[f"version/{version}"]
    biomes = download_and_parse_json(cache, BIOMES_URL.format(version), dict)

    return [
        Biome(type=with_prefix(name), **data)
        for name, data in biomes.items()
    ]
