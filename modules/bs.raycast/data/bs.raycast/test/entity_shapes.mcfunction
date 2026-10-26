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

# the boxes are set here: the provider only has to succeed and keep them, which a function that does not exist does
fill ~ ~ ~ ~ ~8 ~ minecraft:air
summon minecraft:interaction ~.5 ~2 ~.5 {Tags:["bs.raycast.test.shapes"]}

# two boxes with flags 1 and 2: two shapes, and on_entity has both flags
data modify storage bs.hitbox:get_entity out set value [[-.3f,0f,-.3f,.3f,.5f,.3f,1f],[-.3f,.5f,-.3f,.3f,1f,.3f,2f]]
scoreboard players set #in bs.ctx 0
scoreboard players set #out bs.ctx 0
scoreboard players set #f bs.ctx 0
execute positioned ~.5 ~ ~.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test.shapes",max_distance:4,on_entity:"return run execute if predicate bs.raycast:flag/1 if predicate bs.raycast:flag/2 run scoreboard players set #f bs.ctx 1",on_entry:"scoreboard players add #in bs.ctx 1",on_exit:"scoreboard players add #out bs.ctx 1"}}
execute unless score #f bs.ctx matches 1 run fail "on_entity should have both flags"
execute unless score #in bs.ctx matches 2 run fail "Should enter two shapes"
execute unless score #out bs.ctx matches 2 run fail "Should leave two shapes"

# the second shape enters half a block after the first
data modify storage bs.hitbox:get_entity out set value [[-.3f,0f,-.3f,.3f,.5f,.3f,1f],[-.3f,.5f,-.3f,.3f,1f,.3f,2f]]
execute positioned ~.5 ~ ~.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test.shapes",max_distance:4,on_entity:"return 1",on_entry:'execute if predicate bs.raycast:flag/2 run assert result 2499..2501 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:entry/distance"]}}'}}

# two boxes with the same flag that touch: one shape
data modify storage bs.hitbox:get_entity out set value [[-.3f,0f,-.3f,.3f,.5f,.3f,1f],[-.3f,.5f,-.3f,.3f,1f,.3f,1f]]
scoreboard players set #in bs.ctx 0
scoreboard players set #out bs.ctx 0
execute positioned ~.5 ~ ~.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test.shapes",max_distance:4,on_entity:"return 1",on_entry:"scoreboard players add #in bs.ctx 1",on_exit:"scoreboard players add #out bs.ctx 1"}}
execute unless score #in bs.ctx matches 1 run fail "Should enter one shape"
execute unless score #out bs.ctx matches 1 run fail "Should leave one shape"
kill @e[type=minecraft:interaction,tag=bs.raycast.test.shapes]

# a custom box away from the feet: the entity is 4.5 blocks above a ray across the column, its box hangs down onto it
summon minecraft:interaction ~.5 ~5.5 ~.5 {Tags:["bs.raycast.test.aside"]}
data modify storage bs.hitbox:get_entity out set value [[-.3f,-5f,-.3f,.3f,-4f,.3f,1f]]
execute positioned ~.05 ~1 ~.5 rotated -90 0 store result score #r bs.ctx run function #bs.raycast:cast.in {with:{entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test.aside",max_distance:.9}}
execute unless score #r bs.ctx matches 1 run fail "Should hit a custom box away from the feet"
kill @e[type=minecraft:interaction,tag=bs.raycast.test.aside]
