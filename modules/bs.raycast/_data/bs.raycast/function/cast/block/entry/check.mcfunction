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

execute if data storage bs.hitbox:get_block out[0] run return run function bs.raycast:cast/block/entry/shape

execute store result score #raycast.hit bs.data store result storage bs.raycast: ray._entry double 0.00000095367431640625 run compute default integer {type:"add",inputs:[{type:"mul",inputs:[16,{type:"max",inputs:[{type:"mul",inputs:[4,{type:"sub",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.lx"}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.dx"}}}]},{type:"add",inputs:[1,{type:"mul",inputs:[4,{type:"sub",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.ly"}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.dy"}}}]}]},{type:"add",inputs:[2,{type:"mul",inputs:[4,{type:"sub",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.lz"}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.dz"}}}]}]},3]}]},{type:"storage",storage:"bs.hitbox:get_block",path:"out"}]}
execute if score #raycast.ahead bs.data matches ..2147483646 if function bs.raycast:cast/entity/before/block run return 0
scoreboard players set #raycast.max bs.data -2147483648
return run execute at @s run function bs.raycast:cast/utils/at_entry with storage bs.raycast: ray
