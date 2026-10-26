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

data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision",on_block:'assert predicate bs.raycast:face/top'}
execute positioned ~.5 ~1.5 ~.5 rotated 0 90 store result score #r bs.ctx run function #bs.raycast:cast
execute if score #r bs.ctx matches 0 run fail "Failed to detect a targeted block"

setblock ~ ~ ~ minecraft:air
setblock ~ ~1 ~ minecraft:stone
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision",on_block:'assert predicate bs.raycast:face/bottom'}
execute positioned ~.5 ~.5 ~.5 rotated 0 -90 store result score #r bs.ctx run function #bs.raycast:cast
execute if score #r bs.ctx matches 0 run fail "Failed to detect a targeted block"
