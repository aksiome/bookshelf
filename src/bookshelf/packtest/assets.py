import asyncio
import logging
from collections.abc import Coroutine
from pathlib import Path
from typing import Any, Self

import httpx

from bookshelf.definitions import FABRIC_API, MODRINTH_API

logger = logging.getLogger(__name__)

# A download URL, either as a direct string or a coroutine resolving to one.
type URL = str | Coroutine[Any, Any, str]


class AssetResolutionError(Exception):
    """Raised when an asset cannot be resolved for the given criteria."""

    def __init__(self, name: str, version: str) -> None:
        """Initialize the AssetResolutionError."""
        self.name = name
        self.version = version
        super().__init__(
            f"Could not find a version for {name} "
            f"that matches the MC version: {version}",
        )


class AssetDownloader:
    """Asynchronous downloader for retrieving assets."""

    def __init__(self) -> None:
        """Initialize the AssetDownloader without an active HTTP client."""
        self.client: httpx.AsyncClient | None = None

    async def __aenter__(self) -> Self:
        """Enter the asynchronous context, initializing the HTTP client."""
        self.client = httpx.AsyncClient()
        return self

    async def __aexit__(self, *_: object) -> None:
        """Exit the asynchronous context and close the HTTP client."""
        if self.client:
            await self.client.aclose()

    async def download(self, mc_version: str, directory: Path) -> None:
        """Download required assets into the given directory."""
        server = self.resolve_fabric_url(mc_version)
        fabric = self.resolve_modrinth_url("fabric-api", mc_version)
        packtest = self.resolve_modrinth_url("packtest", mc_version)

        await asyncio.gather(
            self.download_file(server, directory / "server.jar"),
            self.download_file(fabric, directory / "mods/fabric-api.jar"),
            self.download_file(packtest, directory / "mods/packtest.jar"),
        )

    async def download_file(self, url: URL, file: Path) -> None:
        """Download a file from the given URL to the specified file path."""
        if isinstance(url, Coroutine):
            url = await url
        logger.debug("Fetching %s", url)
        response = await self.client.get(url)
        response.raise_for_status()
        # Ensure target directory exists
        file.parent.mkdir(parents=True, exist_ok=True)
        file.write_bytes(response.content)

    async def resolve_fabric_url(self, mc_version: str) -> str:
        """Resolve the download URL for a specific Fabric version."""
        response = await self.client.get(f"{FABRIC_API}/versions/loader/{mc_version}")
        response.raise_for_status()
        version = response.json()[0]["loader"]["version"]
        return f"{FABRIC_API}/versions/loader/{mc_version}/{version}/1.1.0/server/jar"

    async def resolve_modrinth_url(self, project_id: str, mc_version: str) -> str:
        """Resolve the Modrinth download URL for a given project and version."""
        response = await self.client.get(f"{MODRINTH_API}/project/{project_id}/version")
        response.raise_for_status()
        versions = response.json()
        # Filter versions compatible with the target Minecraft version
        if versions := [
            version
            for version in versions
            if any(v.startswith(mc_version) for v in version["game_versions"])
        ]:
            return versions[0]["files"][0]["url"]
        # Raise if no compatible version was found
        raise AssetResolutionError(project_id, mc_version)
