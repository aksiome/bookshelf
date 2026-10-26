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

fill ~-1 ~ ~-1 ~1 ~1 ~1 minecraft:air

# one entry per flag, nearest first, and the block with all its flags
setblock ~ ~ ~ minecraft:oak_stairs[facing=west,waterlogged=true]
scoreboard players set #ward.raycast.first bs.data -1
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision_with_fluid",on_entry:'execute unless score #ward.raycast.first bs.data matches 0.. store success score #ward.raycast.first bs.data if predicate bs.raycast:flag/2'}
execute positioned ~1.5 ~ ~.5 facing ~-.5 ~.52 ~ store result score #r bs.ctx run function #bs.raycast:cast
execute if score #r bs.ctx matches 0 run fail "Failed to detect a targeted block"
assert score #ward.raycast.first bs.data matches 1

setblock ~ ~ ~ minecraft:oak_stairs[facing=east,waterlogged=true]
scoreboard players set #ward.raycast.entries bs.data 0
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision_with_fluid",max_distance:2,on_entry:'scoreboard players add #ward.raycast.entries bs.data 1',on_block:'return 1'}
execute positioned ~1.5 ~ ~.5 facing ~-.5 ~.52 ~ store result score #r bs.ctx run function #bs.raycast:cast
execute if score #r bs.ctx matches 1 run fail "Should not detect a targeted block"
assert score #ward.raycast.entries bs.data matches 2
scoreboard players set #ward.raycast.first bs.data -1
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision_with_fluid",on_entry:'execute unless score #ward.raycast.first bs.data matches 0.. store success score #ward.raycast.first bs.data if predicate bs.raycast:flag/1'}
execute positioned ~1.5 ~ ~.5 facing ~-.5 ~.52 ~ store result score #r bs.ctx run function #bs.raycast:cast
execute if score #r bs.ctx matches 0 run fail "Failed to detect a targeted block"
assert score #ward.raycast.first bs.data matches 1
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision_with_fluid",on_block:'assert predicate bs.raycast:flag/1'}
execute positioned ~1.5 ~ ~.5 facing ~-.5 ~.52 ~ store result score #r bs.ctx run function #bs.raycast:cast
execute if score #r bs.ctx matches 0 run fail "Failed to detect a targeted block"
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision_with_fluid",on_block:'assert predicate bs.raycast:flag/2'}
execute positioned ~1.5 ~ ~.5 facing ~-.5 ~.52 ~ store result score #r bs.ctx run function #bs.raycast:cast
execute if score #r bs.ctx matches 0 run fail "Failed to detect a targeted block"

# an entry command can stop the ray: through the water, stopped by the stair, the water entry still runs
setblock ~ ~ ~ minecraft:oak_stairs[facing=west,waterlogged=true]
scoreboard players set #ward.raycast.water bs.data 0
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision_with_fluid",max_distance:2,on_block:'return 1',on_entry:'return run execute unless predicate bs.raycast:flag/1 run scoreboard players add #ward.raycast.water bs.data 1'}
execute positioned ~1.5 ~.75 ~.5 facing ~-.5 ~ ~ store result score #r bs.ctx run function #bs.raycast:cast
execute if score #r bs.ctx matches 0 run fail "Failed to stop at the stair"
assert score #ward.raycast.water bs.data matches 1
