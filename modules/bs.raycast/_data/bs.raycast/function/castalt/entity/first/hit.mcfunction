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

scoreboard players set #raycast.entity bs.data 1
scoreboard players operation #raycast.ex bs.data = @s bs.raycast.x
scoreboard players operation #raycast.ey bs.data = @s bs.raycast.y
scoreboard players operation #raycast.ez bs.data = @s bs.raycast.z
execute store result storage bs.raycast: ray._entry double 0.00000095367431640625 run scoreboard players get #raycast.hit bs.data
function bs.raycast:castalt/utils/stop_entry
