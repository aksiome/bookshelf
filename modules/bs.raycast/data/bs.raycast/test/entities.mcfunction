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

# the entities sit above the plot: a column of blocks never leaves its chunk
fill ~ ~ ~ ~ ~8 ~ minecraft:air
summon minecraft:armor_stand ~.5 ~2 ~.5 {NoGravity:1b,Tags:["bs.raycast.test.entities"]}
summon minecraft:armor_stand ~.5 ~5 ~.5 {NoGravity:1b,Tags:["bs.raycast.test.entities"]}

# an entity alone stops the ray
execute positioned ~.5 ~ ~.5 rotated 0 -90 store result score #r bs.ctx run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test.entities",max_distance:8}}
execute unless score #r bs.ctx matches 1 run fail "Should hit the armor stand"

# without a selector, the predicate of the provider
execute positioned ~.5 ~ ~.5 rotated 0 -90 store result score #r bs.ctx run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",max_distance:4}}
execute unless score #r bs.ctx matches 1 run fail "Should hit the armor stand with the default selector"

# piercing both armor stands, entries and exits
scoreboard players set #in bs.ctx 0
scoreboard players set #out bs.ctx 0
scoreboard players set #on bs.ctx 0
execute positioned ~.5 ~ ~.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test.entities",max_distance:8,on_entity:"return run scoreboard players add #on bs.ctx 1",on_entry:"scoreboard players add #in bs.ctx 1",on_exit:"scoreboard players add #out bs.ctx 1"}}
execute unless score #on bs.ctx matches 2 run fail "Should run on_entity twice"
execute unless score #in bs.ctx matches 2 run fail "Should enter twice"
execute unless score #out bs.ctx matches 2 run fail "Should leave twice"

# the first armor stand: entered at its feet, left at its top
execute positioned ~.5 ~ ~.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test.entities",max_distance:8,on_entity:'assert result 1999..2001 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:entry/distance"]}}'}}
execute positioned ~.5 ~ ~.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test.entities",max_distance:4,on_entity:"return 1",on_exit:'assert result 3974..3976 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:exit/distance"]}}'}}

# the points relative to the feet of the armor stand
execute positioned ~.5 ~ ~.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test.entities",max_distance:8,on_entity:'assert result -1..1 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:entry/x"]}}'}}
execute positioned ~.5 ~ ~.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test.entities",max_distance:8,on_entity:'assert result -1..1 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:entry/y"]}}'}}
execute positioned ~.5 ~ ~.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test.entities",max_distance:8,on_entity:'assert result -1..1 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:entry/z"]}}'}}
execute positioned ~.5 ~ ~.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test.entities",max_distance:4,on_entity:"return 1",on_exit:'assert result 1974..1976 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:exit/y"]}}'}}

# entities and blocks in order: block, armor stand, block, armor stand
setblock ~ ~1 ~ minecraft:oak_slab
setblock ~ ~4 ~ minecraft:oak_slab
data modify storage bs.ctx _ set value []
execute positioned ~.5 ~ ~.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test.entities",max_distance:8,on_block:'return run data modify storage bs.ctx _ append value "b"',on_entity:'return run data modify storage bs.ctx _ append value "e"'}}
assert data storage bs.ctx {_:["b","e","b","e"]}

# an entity that stops the ray hides the block behind it
data modify storage bs.ctx _ set value []
execute positioned ~.5 ~ ~.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test.entities",max_distance:8,on_block:'return run data modify storage bs.ctx _ append value "b"',on_entity:'data modify storage bs.ctx _ append value "e"'}}
assert data storage bs.ctx {_:["b","e"]}
kill @e[type=minecraft:armor_stand,tag=bs.raycast.test.entities]
fill ~ ~ ~ ~ ~8 ~ minecraft:air

# entities of different sizes in one ray: each one keeps its own box
summon minecraft:armor_stand ~.5 ~2 ~.5 {NoGravity:1b,Tags:["bs.raycast.test.sizes"]}
summon minecraft:villager ~.5 ~5 ~.5 {NoAI:1b,Silent:1b,NoGravity:1b,Tags:["bs.raycast.test.sizes"]}
data modify storage bs.ctx _ set value []
execute positioned ~.5 ~ ~.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test.sizes",max_distance:8,on_entity:"return 1",on_entry:'data modify storage bs.ctx _ append value 0',on_exit:'execute store result storage bs.ctx _[-1] int 1 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:exit/distance"]}}'}}
execute store result score #a bs.ctx run data get storage bs.ctx _[0]
execute store result score #b bs.ctx run data get storage bs.ctx _[1]
execute unless score #a bs.ctx matches 3974..3976 run fail "The armor stand should keep its own box"
execute unless score #b bs.ctx matches 6949..6951 run fail "The villager should keep its own box"
kill @e[tag=bs.raycast.test.sizes]
