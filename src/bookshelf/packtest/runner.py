import shutil
from pathlib import Path

from platformdirs import PlatformDirs

from bookshelf.packtest import process
from bookshelf.packtest.assets import AssetDownloader

dirs = PlatformDirs(appname="bookshelf", appauthor="mcbookshelf", ensure_exists=True)


async def run(assets: AssetDownloader, mc_version: str, *packs: Path) -> int:
    """Run packtest for a given Minecraft version using the specified data packs."""
    work_dir = dirs.user_cache_path / f"packtest-{mc_version}"
    world_dir = work_dir / "world"
    datapacks_dir = world_dir / "datapacks"

    # Clean existing world directory
    if world_dir.exists():
        shutil.rmtree(world_dir)
    datapacks_dir.mkdir(parents=True, exist_ok=True)

    # Copy each pack into the datapacks directory
    for pack in packs:
        target = datapacks_dir / pack.name
        if pack.is_dir():
            shutil.copytree(pack, target)
        elif pack.is_file():
            shutil.copy(pack, target)

    await assets.download(mc_version, work_dir)
    return await process.run_server(work_dir)
