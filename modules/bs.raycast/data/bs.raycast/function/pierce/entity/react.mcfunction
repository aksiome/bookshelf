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

execute if score #raycast.max bs.data matches -2147483648 run return fail
execute if score @s bs.raycast.hit matches 2147483647 run return fail
# the shapes of the block entered before the entity
scoreboard players operation #raycast.bound bs.data = @s bs.raycast.hit
execute if score #raycast.block bs.data < @s bs.raycast.hit as B5-0-0-0-C1 unless function bs.raycast:pierce/block/until run return fail
# the entity, once its entry is in this cell
scoreboard players operation #raycast.next bs.data = @s bs.raycast.hit
scoreboard players operation #raycast.next bs.data /= 64 bs.const
execute if score #raycast.lx bs.data > #raycast.next bs.data if score #raycast.ly bs.data > #raycast.next bs.data if score #raycast.lz bs.data > #raycast.next bs.data run return run function bs.raycast:pierce/entity/emit
# still ahead: forgotten here, found again in the cell of its entry
execute store result score #raycast.entity bs.data run scoreboard players set #raycast.other bs.data 2147483647
