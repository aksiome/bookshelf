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

# as the entity, at the origin: its hit and on_entity, as and at it; the entry and exit commands run after, as the marker
tag @s remove bs.raycast.pending
scoreboard players operation #raycast.hit bs.data = @s bs.raycast.hit
scoreboard players operation #raycast.exit bs.data = @s bs.raycast.exit
scoreboard players operation #raycast.ex bs.data = @s bs.raycast.x
scoreboard players operation #raycast.ey bs.data = @s bs.raycast.y
scoreboard players operation #raycast.ez bs.data = @s bs.raycast.z
scoreboard players set #raycast.entity bs.data 1
execute if score @s bs.raycast.boxes matches 2.. run function bs.raycast:cast/entity/fire/group
execute if score @s bs.raycast.boxes matches 2.. as @n[type=minecraft:marker,tag=bs.raycast.origin] at @s run function bs.raycast:cast/entity/fire/emit
execute if score @s bs.raycast.boxes matches 2.. run return run scoreboard players set #raycast.entity bs.data 0
scoreboard players set #raycast.pierce bs.data 0
execute if data storage bs.raycast: ray.on_entity at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/on_entity with storage bs.raycast: ray
execute store result storage bs.raycast: ray._entry double 0.00000095367431640625 run scoreboard players get #raycast.hit bs.data
scoreboard players set #raycast.ran bs.data 1
