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

# as the earliest tested entity, at the origin: the selected boxes that reach before its entry are tested, then the earliest hit runs
scoreboard players set #raycast.found bs.data 0
execute store result storage bs.raycast: ray._entry double 0.00000095367431640625 run scoreboard players get @s bs.raycast.hit
function bs.raycast:castalt/entity/near with storage bs.raycast: ray
execute as @n[type=minecraft:marker,tag=bs.raycast.origin] run tp @s ~ ~ ~
# the earliest hit runs: this one, or one just tested (every box that could enter before it was in that region)
scoreboard players set #raycast.ran bs.data 0
execute if score #raycast.found bs.data matches 0 run function bs.raycast:castalt/entity/emit
execute if score #raycast.found bs.data matches 1 run scoreboard players set #raycast.bound bs.data 2147483647
$execute if score #raycast.found bs.data matches 1 as @e[tag=bs.raycast.pending,distance=..$(_around)] run scoreboard players operation #raycast.bound bs.data < @s bs.raycast.hit
$execute if score #raycast.found bs.data matches 1 as @e[tag=bs.raycast.pending,distance=..$(_around)] if score @s bs.raycast.hit = #raycast.bound bs.data run function bs.raycast:castalt/entity/emit
execute as @n[type=minecraft:marker,tag=bs.raycast.origin] run function bs.raycast:castalt/entity/switch with storage bs.raycast: ray
