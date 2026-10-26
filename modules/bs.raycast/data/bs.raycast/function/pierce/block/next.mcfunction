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

# on_block once, before the first shape of the block
scoreboard players set #raycast.pierce bs.data 1
execute if score #raycast.first bs.data matches 1 if data storage bs.raycast: ray.on_block run scoreboard players operation #raycast.hit bs.data = #raycast.bhit bs.data
execute if score #raycast.first bs.data matches 1 if data storage bs.raycast: ray.on_block store result score #raycast.pierce bs.data run function bs.raycast:utils/on_block with storage bs.raycast: ray
scoreboard players set #raycast.first bs.data 0
# the shape: its entry, then its exit
scoreboard players operation #raycast.hit bs.data = #raycast.block bs.data
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_entry store result storage bs.raycast: ray._entry double 0.00000095367431640625 run scoreboard players get #raycast.hit bs.data
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_entry at @s store result score #raycast.pierce bs.data run function bs.raycast:utils/at_entry with storage bs.raycast: ray
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit if score #raycast.shapes bs.data matches 0 store result storage bs.raycast: ray._exit double 0.00006103515625 run scoreboard players operation #raycast.exit bs.data = #raycast.bexit bs.data
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit unless score #raycast.shapes bs.data matches 0 store result score #raycast.exit bs.data store result storage bs.raycast: ray._exit double 0.00006103515625 run compute default integer bs.raycast:_pierce/shape/leave
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit at @s store result score #raycast.pierce bs.data run function bs.raycast:utils/at_exit with storage bs.raycast: ray
# the next shape of the block
execute if score #raycast.shapes bs.data matches 0 run scoreboard players set #raycast.block bs.data 2147483647
execute unless score #raycast.shapes bs.data matches 0 run scoreboard players operation #raycast.mask bs.data = #raycast.hit bs.data
execute unless score #raycast.shapes bs.data matches 0 store result score #raycast.block bs.data run compute default integer bs.raycast:_pierce/shape/enter
execute if score #raycast.pierce bs.data matches 0 run scoreboard players set #raycast.max bs.data -2147483648
execute if score #raycast.pierce bs.data matches 0 run return fail
return 1
