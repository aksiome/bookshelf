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

execute store result storage bs.raycast: ray._middle double 0.000030517578125 run compute default integer {type:"add",inputs:[{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.from"}},{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.to"}}]}
execute store result storage bs.raycast: ray._reach double 0.000030517578125 run compute default integer {type:"add",inputs:[{type:"sub",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.to"}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.from"}}},524288]}
execute store result storage bs.raycast: ray._around double 0.00006103515625 run compute default integer {type:"add",inputs:[{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.max"}},278528]}
tag @s add bs.raycast.origin
function bs.raycast:cast/entity/find/scan
tag @s remove bs.raycast.origin
tag @s remove bs.raycast.target
tp @s ~ ~ ~ ~ ~
execute unless score #raycast.next bs.data matches 2147483647 store result score #raycast.ahead bs.data run compute default integer {type:"floor_div",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.next"}},right:64}
