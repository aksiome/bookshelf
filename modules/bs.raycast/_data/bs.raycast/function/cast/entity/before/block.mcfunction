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

execute if score #raycast.pending bs.data matches 1.. at @s run function bs.raycast:cast/entity/find/more
execute store result score #raycast.until bs.data run compute default integer {type:"sub",left:{type:"floor_div",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.hit"}},right:64},right:1}
execute if score #raycast.ahead bs.data > #raycast.until bs.data run return fail
scoreboard players operation #raycast.block_hit bs.data = #raycast.hit bs.data
scoreboard players operation #raycast.block_exit bs.data = #raycast.exit bs.data
function bs.raycast:cast/entity/fire/next with storage bs.raycast: ray
scoreboard players set #raycast.entity bs.data 0
scoreboard players operation #raycast.hit bs.data = #raycast.block_hit bs.data
scoreboard players operation #raycast.exit bs.data = #raycast.block_exit bs.data
execute store result storage bs.raycast: ray._entry double 0.00000095367431640625 run scoreboard players get #raycast.hit bs.data
execute store result storage bs.raycast: ray._exit double 0.00006103515625 run scoreboard players get #raycast.exit bs.data
return run execute if score #raycast.max bs.data matches -2147483648
