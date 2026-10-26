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
execute store result score #raycast.block bs.data store result score #raycast.hit bs.data store result storage bs.raycast: ray._middle double 0.000000476837158203125 store result storage bs.raycast: ray._entry double 0.00000095367431640625 run compute default integer bs.raycast:_cast/block
execute if score #raycast.hit bs.data matches 2147483647 run return fail
data modify storage bs.raycast: ray._reach set compute default integer {type:"add",inputs:[{type:"floor_div",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.hit"}},right:2097152},17]}
execute at @s run function bs.raycast:cast/custom/tube with storage bs.raycast: ray
execute if score #raycast.max bs.data matches -2147483648 run return 0
execute if data storage bs.raycast: ray.on_block run function bs.raycast:utils/on_block with storage bs.raycast: ray
execute if data storage bs.raycast: ray.on_entry at @s run function bs.raycast:utils/at_entry with storage bs.raycast: ray
scoreboard players set #raycast.max bs.data -2147483648
