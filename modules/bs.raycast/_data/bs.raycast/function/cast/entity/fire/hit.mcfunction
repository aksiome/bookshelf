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

# as the entity: its hit, then on_entity, as and at it
tag @s remove bs.raycast.target
scoreboard players operation #raycast.hit bs.data = @s bs.raycast.hit
scoreboard players operation #raycast.exit bs.data = @s bs.raycast.exit
scoreboard players operation #raycast.ex bs.data = @s bs.raycast.x
scoreboard players operation #raycast.ey bs.data = @s bs.raycast.y
scoreboard players operation #raycast.ez bs.data = @s bs.raycast.z
scoreboard players set #raycast.entity bs.data 1
scoreboard players set #raycast.shaped bs.data 0
execute if score @s bs.raycast.boxes matches 2.. run return run function bs.raycast:cast/entity/fire/group
execute unless data storage bs.raycast: ray.on_entity run return run scoreboard players set #raycast.pierce bs.data 0
execute at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/on_entity with storage bs.raycast: ray
