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

# the provider runs here, one entity at a time: in the selection, it would run for all of them first
tag @s remove bs.raycast.todo
$execute unless function $(entities) run return fail
execute at @s as @n[type=minecraft:marker,tag=bs.raycast.origin] run function bs.raycast:castalt/entity/position
execute store result score #raycast.parts bs.data store result score @s bs.raycast.boxes run data get storage bs.hitbox:get_entity out
execute store result score @s bs.raycast.hit run compute default integer bs.raycast:_cast/target
execute if score @s bs.raycast.hit matches 2147483647 run return fail
execute store result score @s bs.raycast.exit run compute default integer bs.raycast:_cast/target_out
scoreboard players operation @s bs.raycast.x = #raycast.ex bs.data
scoreboard players operation @s bs.raycast.y = #raycast.ey bs.data
scoreboard players operation @s bs.raycast.z = #raycast.ez bs.data
tag @s add bs.raycast.pending
scoreboard players set #raycast.found bs.data 1
