import json
from collections.abc import Generator

from beet import Context

from bookshelf.definitions import MC_VERSIONS

VERSION_META = "https://raw.githubusercontent.com/misode/mcmeta/refs/tags/{}-summary/version.json"


def beet_default(ctx: Context) -> Generator:
    """Set the pack format for the module based on supported Minecraft versions."""
    yield
    formats = get_supported_formats(ctx, MC_VERSIONS)

    ctx.assets.description = ctx.meta["description"]
    ctx.assets.pack_format = formats["assets"]["max_inclusive"]
    ctx.assets.supported_formats = formats["assets"]

    ctx.data.description = ctx.meta["description"]
    ctx.data.pack_format = formats["data"]["max_inclusive"]
    ctx.data.supported_formats = formats["data"]
    ctx.data.mcmeta.set_content({
        "id": ctx.data.name,
        **ctx.data.mcmeta.data,
    })


def get_supported_formats(ctx: Context, versions: list) -> dict:
    """Retrieve the supported formats for the given Minecraft versions."""
    cache = ctx.cache[f"version/{versions[0]}"]
    file = cache.download(VERSION_META.format(versions[0]))
    min_version = json.loads(file.read_text("utf-8"))

    cache = ctx.cache[f"version/{versions[-1]}"]
    file = cache.download(VERSION_META.format(versions[-1]))
    max_version = json.loads(file.read_text("utf-8"))

    return {
        "data": {
            "min_inclusive": min_version["data_pack_version"],
            "max_inclusive": max_version["data_pack_version"],
        },
        "assets": {
            "min_inclusive": min_version["resource_pack_version"],
            "max_inclusive": max_version["resource_pack_version"],
        },
    }
