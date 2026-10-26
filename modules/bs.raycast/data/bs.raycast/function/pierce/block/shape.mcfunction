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

execute store result score #raycast.boxes bs.data run data get storage bs.hitbox:get_block out
execute store result score #raycast.mask bs.data run compute default integer bs.raycast:_pierce/block/mask
execute if score #raycast.mask bs.data matches 0 run return fail
scoreboard players set #raycast.first bs.data 1
scoreboard players set #raycast.shapes bs.data 0
# on_block only: the hit of the whole block
execute unless data storage bs.raycast: ray.on_entry unless data storage bs.raycast: ray.on_exit store result score #raycast.count bs.data run compute default integer bs.raycast:_pierce/block/tally
execute unless data storage bs.raycast: ray.on_entry unless data storage bs.raycast: ray.on_exit store result score #raycast.block bs.data store result score #raycast.bhit bs.data run compute default integer bs.raycast:_pierce/block/hit
execute unless data storage bs.raycast: ray.on_entry unless data storage bs.raycast: ray.on_exit run return 1
# a single box: its entry and exit
execute store result score #raycast.drop bs.data run compute default integer bs.raycast:_pierce/block/rest
execute if score #raycast.drop bs.data matches 0 store result score #raycast.block bs.data store result score #raycast.bhit bs.data run compute default integer bs.raycast:_pierce/block/nearest
execute if score #raycast.drop bs.data matches 0 if data storage bs.raycast: ray.on_exit store result score #raycast.bexit bs.data run compute default integer bs.raycast:_pierce/block/exit
execute if score #raycast.drop bs.data matches 0 run return 1
# the shapes: boxes with the same flag that touch, entered nearest first
execute store result score #raycast.shapes bs.data run function bs.raycast:pierce/block/table
execute if score #raycast.shapes bs.data matches 2 if score #raycast.entry1 bs.data <= #raycast.exit0 bs.data if score #raycast.entry0 bs.data <= #raycast.exit1 bs.data run function bs.raycast:pierce/block/join
execute if score #raycast.shapes bs.data matches 3.. store result score #raycast.shapes bs.data run function bs.raycast:pierce/block/merge
execute store result score #raycast.bhit bs.data run compute default integer bs.raycast:_pierce/shape/hit
scoreboard players set #raycast.mask bs.data -1
execute store result score #raycast.block bs.data run compute default integer bs.raycast:_pierce/shape/enter
return 1
