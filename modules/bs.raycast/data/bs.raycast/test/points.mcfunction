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

fill ~-1 ~ ~ ~1 ~ ~ minecraft:air
setblock ~ ~ ~ minecraft:stone
summon minecraft:marker ~ ~ ~ {Tags:["bs.raycast.test.points"]}
execute store result score #x bs.ctx run data get entity @n[type=minecraft:marker,tag=bs.raycast.test.points] Pos[0]
execute store result score #y bs.ctx run data get entity @n[type=minecraft:marker,tag=bs.raycast.test.points] Pos[1]
execute store result score #z bs.ctx run data get entity @n[type=minecraft:marker,tag=bs.raycast.test.points] Pos[2]
kill @n[type=minecraft:marker,tag=bs.raycast.test.points]

# the points in the block, going east then west
execute positioned ~-.5 ~.5 ~.5 rotated -90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:2,on_entry:'assert result -1..1 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:entry/x"]}}'}}
execute positioned ~-.5 ~.5 ~.5 rotated -90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:2,on_entry:'assert result 499..501 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:entry/y"]}}'}}
execute positioned ~-.5 ~.5 ~.5 rotated -90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:2,on_entry:'assert result 499..501 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:entry/z"]}}'}}
execute positioned ~-.5 ~.5 ~.5 rotated -90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:2,on_block:"return 1",on_exit:'assert result 999..1001 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:exit/x"]}}'}}
execute positioned ~1.5 ~.5 ~.5 rotated 90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:2,on_entry:'assert result 999..1001 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:entry/x"]}}'}}
execute positioned ~1.5 ~.5 ~.5 rotated 90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:2,on_block:"return 1",on_exit:'assert result -1..1 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:exit/x"]}}'}}

# the exit distance
execute positioned ~-.5 ~.5 ~.5 rotated -90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:2,on_block:"return 1",on_exit:'assert result 1499..1501 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:exit/distance"]}}'}}

# the block, going east then west
scoreboard players set #bx bs.ctx 0
execute positioned ~-.5 ~.5 ~.5 rotated -90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:2,on_block:"execute store result score #bx bs.ctx run compute default integer bs.raycast:block/x"}}
execute unless score #bx bs.ctx = #x bs.ctx run fail "Wrong block x going east"
scoreboard players set #bx bs.ctx 0
execute positioned ~1.5 ~.5 ~.5 rotated 90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:2,on_block:"execute store result score #bx bs.ctx run compute default integer bs.raycast:block/x"}}
execute unless score #bx bs.ctx = #x bs.ctx run fail "Wrong block x going west"
execute positioned ~1.5 ~.5 ~.5 rotated 90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:2,on_block:"execute store result score #bx bs.ctx run compute default integer bs.raycast:block/y"}}
execute unless score #bx bs.ctx = #y bs.ctx run fail "Wrong block y"
execute positioned ~1.5 ~.5 ~.5 rotated 90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:2,on_block:"execute store result score #bx bs.ctx run compute default integer bs.raycast:block/z"}}
execute unless score #bx bs.ctx = #z bs.ctx run fail "Wrong block z"
