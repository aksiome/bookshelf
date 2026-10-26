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

scoreboard players set #raycast.shaped bs.data 1
function bs.raycast:cast/entity/fire/boxes with storage bs.raycast: ray
execute store result score #raycast.parts bs.data run data get storage bs.hitbox:get_entity out
execute store result score #raycast.mask bs.data run compute default integer bs.raycast:_cast/target_mask
execute store result score #raycast.shapes bs.data run function bs.raycast:cast/entity/fire/table
execute if score #raycast.shapes bs.data matches 2 if score #raycast.entry1 bs.data <= #raycast.exit0 bs.data if score #raycast.entry0 bs.data <= #raycast.exit1 bs.data run function bs.raycast:cast/shape/pair
execute if score #raycast.shapes bs.data matches 3.. store result score #raycast.shapes bs.data run function bs.raycast:cast/shape/merge
execute store result score #raycast.hit bs.data run compute default integer bs.raycast:_cast/hit
execute unless data storage bs.raycast: ray.on_entity run return run scoreboard players set #raycast.pierce bs.data 0
execute at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/on_entity with storage bs.raycast: ray
