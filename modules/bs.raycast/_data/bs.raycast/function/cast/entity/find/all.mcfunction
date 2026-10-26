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

# a ray without blocks: all the entities at once, then the end of the ray
scoreboard players set #raycast.cut bs.data -2147483648
scoreboard players set #raycast.from bs.data 0
scoreboard players operation #raycast.to bs.data = #raycast.max bs.data
function bs.raycast:cast/entity/find/select
execute if score #raycast.next bs.data matches ..2147483646 run function bs.raycast:cast/entity/before/end with storage bs.raycast: ray
tp @s ~ -1000000 ~
kill @s
