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

fill ~-2 ~ ~-2 ~2 ~2 ~2 minecraft:air
setblock ~-1 ~ ~ minecraft:cauldron
setblock ~ ~ ~ minecraft:cauldron
setblock ~1 ~ ~ minecraft:cauldron

# the ray goes through the 2 walls of each cauldron: 2 shapes per block, and the command of the block decides
scoreboard players set #ward.raycast.blocks bs.data 0
scoreboard players set #ward.raycast.entries bs.data 0
scoreboard players set #ward.raycast.exits bs.data 0
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision",max_distance:4,on_entry:'scoreboard players add #ward.raycast.entries bs.data 1',on_exit:'scoreboard players add #ward.raycast.exits bs.data 1',on_block:'return run scoreboard players add #ward.raycast.blocks bs.data 1'}
execute positioned ~2.5 ~.5 ~.5 facing ~-.5 ~ ~ store result score #r bs.ctx run function #bs.raycast:cast
assert score #ward.raycast.blocks bs.data matches 3
assert score #ward.raycast.entries bs.data matches 6
assert score #ward.raycast.exits bs.data matches 6

# a command that returns 0 stops the ray: here at the second block
scoreboard players set #ward.raycast.left bs.data 2
scoreboard players set #ward.raycast.entries bs.data 0
scoreboard players set #ward.raycast.exits bs.data 0
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision",max_distance:4,on_entry:'scoreboard players add #ward.raycast.entries bs.data 1',on_exit:'scoreboard players add #ward.raycast.exits bs.data 1',on_block:'return run scoreboard players remove #ward.raycast.left bs.data 1'}
execute positioned ~2.5 ~.5 ~.5 facing ~-.5 ~ ~ store result score #r bs.ctx run function #bs.raycast:cast
execute if score #r bs.ctx matches 0 run fail "Failed to detect a targeted block"
assert score #ward.raycast.left bs.data matches 0
assert score #ward.raycast.entries bs.data matches 3
assert score #ward.raycast.exits bs.data matches 2

# the block command runs before the entries of its shapes
scoreboard players set #ward.raycast.order bs.data 0
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision",max_distance:4,on_block:'scoreboard players set #ward.raycast.order bs.data 1',on_entry:'assert score #ward.raycast.order bs.data matches 1'}
execute positioned ~2.5 ~.5 ~.5 facing ~-.5 ~ ~ store result score #r bs.ctx run function #bs.raycast:cast
execute if score #r bs.ctx matches 0 run fail "Failed to detect a targeted block"

# an exit command can stop the ray too: here after leaving the first block
scoreboard players set #ward.raycast.blocks bs.data 0
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision",max_distance:4,on_block:'return run scoreboard players add #ward.raycast.blocks bs.data 1',on_exit:'return 0'}
execute positioned ~2.5 ~.5 ~.5 facing ~-.5 ~ ~ store result score #r bs.ctx run function #bs.raycast:cast
execute if score #r bs.ctx matches 0 run fail "Failed to detect a targeted block"
assert score #ward.raycast.blocks bs.data matches 1
