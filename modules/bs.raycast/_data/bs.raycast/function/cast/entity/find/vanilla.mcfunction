# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
# ------------------------------------------------------------------------------------------------------------

# targets left by a ray that did not end, such as one past the command limit
$execute if score #raycast.from bs.data matches 0 run tag @e[tag=bs.raycast.target,distance=..$(_around)] remove bs.raycast.target
# the marker and the targets are left out: a target is not tested twice
tag @s add bs.raycast.target
$execute positioned ^ ^ ^$(_middle) as @e[distance=..$(_reach),tag=!bs.raycast.target,$(selector)] positioned ^4194304 ^ ^ if entity @s[distance=..4194308] positioned ^-8388608 ^ ^ if entity @s[distance=..4194308] positioned ^4194304 ^4194304 ^ if entity @s[distance=..4194308] positioned ^ ^-8388608 ^ if entity @s[distance=..4194308] positioned as @s positioned ^ ^ ^8192 facing entity @n[type=minecraft:marker,tag=bs.raycast.origin] feet positioned ^ ^ ^8192 positioned ~-1.85 ~-1.85 ~-1.85 if entity @s[dx=2.7,dy=2.7,dz=2.7] run function bs.raycast:cast/entity/find/test with storage bs.raycast: ray
# the tests moved the marker
tp @s ~ ~ ~
$execute positioned ^ ^ ^$(_middle) as @e[distance=..$(_reach),tag=!bs.raycast.target,$(selector)] positioned as @s if function bs.raycast:cast/entity/find/big positioned ^ ^ ^8192 facing entity @n[type=minecraft:marker,tag=bs.raycast.origin] feet positioned ^ ^ ^8192 positioned ~-32 ~-32 ~-32 if entity @s[dx=63,dy=63,dz=63] run function bs.raycast:cast/entity/find/test with storage bs.raycast: ray
