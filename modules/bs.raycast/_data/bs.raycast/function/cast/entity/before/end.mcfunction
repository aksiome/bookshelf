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

scoreboard players operation #raycast.until bs.data = #raycast.max bs.data
execute unless score #raycast.max bs.data matches -2147483648 if score #raycast.ahead bs.data <= #raycast.until bs.data run function bs.raycast:cast/entity/fire/next with storage bs.raycast: ray
scoreboard players set #raycast.entity bs.data 0
$tag @e[tag=bs.raycast.target,distance=..$(_around)] remove bs.raycast.target
