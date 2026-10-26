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

scoreboard players set #raycast.pierce bs.data 1
scoreboard players set #raycast.kind bs.data 1
scoreboard players operation #raycast.hit bs.data = @s bs.raycast.hit
scoreboard players operation #raycast.ex bs.data = @s bs.raycast.x
scoreboard players operation #raycast.ey bs.data = @s bs.raycast.y
scoreboard players operation #raycast.ez bs.data = @s bs.raycast.z
execute if data storage bs.raycast: ray.on_entity at @s store result score #raycast.pierce bs.data run function bs.raycast:utils/on_entity with storage bs.raycast: ray
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_entry store result storage bs.raycast: ray._entry double 0.00000095367431640625 run scoreboard players get #raycast.hit bs.data
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_entry at B5-0-0-0-C1 store result score #raycast.pierce bs.data run function bs.raycast:utils/at_entry with storage bs.raycast: ray
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit store result storage bs.raycast: ray._exit double 0.00006103515625 run scoreboard players operation #raycast.exit bs.data = @s bs.raycast.e0
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit at B5-0-0-0-C1 store result score #raycast.pierce bs.data run function bs.raycast:utils/at_exit with storage bs.raycast: ray
scoreboard players set #raycast.kind bs.data 0
scoreboard players set @s bs.raycast.hit 2147483647
scoreboard players operation #raycast.entity bs.data = #raycast.other bs.data
execute if score #raycast.pierce bs.data matches 0 run return run scoreboard players set #raycast.max bs.data -2147483648
# the rest of the cell: the block alone, or the next entity of the cell
execute if score #raycast.other bs.data matches 2147483647 as B5-0-0-0-C1 run return run function bs.raycast:pierce/block/flush
execute as B5-0-0-0-C1 run function bs.raycast:pierce/react
