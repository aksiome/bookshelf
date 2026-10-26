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
setblock ~ ~ ~ minecraft:stone

# the ray leaves the block when a command lets it through
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision",max_distance:1.8,on_block:'return 1',on_exit:'assert result 1499..1501 run compute default integer {type:"from_float",input:{type:"mul",inputs:[1000.0,"bs.raycast:exit/distance"]}}'}
execute positioned ~1.5 ~.5 ~.5 facing ~-.5 ~ ~ store result score #r bs.ctx run function #bs.raycast:cast
execute if score #r bs.ctx matches 1 run fail "Should not detect a targeted block"
