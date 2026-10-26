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

# the next entity of the cell, found again
scoreboard players set #raycast.entity bs.data 2147483647
scoreboard players set #raycast.other bs.data 2147483647
execute as @e[dx=0,tag=bs.raycast.done] unless score @s bs.raycast.hit matches 2147483647 run function bs.raycast:pierce/entity/near
execute if score #raycast.entity bs.data matches 2147483647 run return run function bs.raycast:pierce/block/flush
execute as @e[dx=0,tag=bs.raycast.done,predicate=bs.raycast:_utils/entity,limit=1] run function bs.raycast:pierce/entity/react
