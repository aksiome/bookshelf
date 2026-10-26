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

execute store result score #raycast.mask bs.data run compute default integer bs.raycast:_cast/target_mask
execute store result score #raycast.shapes bs.data run function bs.raycast:castalt/entity/table
execute if score #raycast.shapes bs.data matches 2 if score #raycast.entry1 bs.data <= #raycast.exit0 bs.data if score #raycast.entry0 bs.data <= #raycast.exit1 bs.data run function bs.raycast:castalt/entity/join
execute if score #raycast.shapes bs.data matches 3.. store result score #raycast.shapes bs.data run function bs.raycast:castalt/entity/merge
execute store result score @s bs.raycast.hit run compute default integer bs.raycast:_cast/hit
scoreboard players operation @s bs.raycast.shapes = #raycast.shapes bs.data
return 1
