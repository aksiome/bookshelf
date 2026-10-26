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

execute store result score #raycast.boxes bs.data run data get storage bs.hitbox:get_block out
execute store result score #raycast.mask bs.data run compute default integer bs.raycast:_cast/mask
execute if score #raycast.mask bs.data matches 0 run return fail

execute store result score #raycast.count bs.data run compute default integer bs.raycast:_cast/count
execute store result score #raycast.hit bs.data run compute default integer bs.raycast:_cast/flags
execute if score #raycast.ahead bs.data matches ..2147483646 if function bs.raycast:cast/entity/before/block run return 0
execute store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/on_block with storage bs.raycast: ray
execute if score #raycast.pierce bs.data matches 0 run scoreboard players set #raycast.max bs.data -2147483648
