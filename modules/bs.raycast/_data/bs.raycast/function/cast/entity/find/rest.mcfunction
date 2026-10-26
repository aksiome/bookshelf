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

# the entities left to select when the ray ends: all of them, or the ones after the first block
scoreboard players operation #raycast.to bs.data = #raycast.max bs.data
execute if score #raycast.pending bs.data matches 2 run scoreboard players set #raycast.ahead bs.data 2147483647
scoreboard players set #raycast.cut bs.data -2147483648
execute if score #raycast.pending bs.data matches 1 store result score #raycast.cut bs.data run compute default integer {type:"mul",inputs:[{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.from"}},64]}
function bs.raycast:cast/entity/find/select
scoreboard players set #raycast.pending bs.data 0
