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

# the position of the entity, from the marker of the ray: the same shift as the origin keeps it exact
tp @s ~ ~ ~
execute unless data storage bs.raycast: ray{_shift_x:0,_shift_z:0} run function bs.raycast:cast/utils/shift_by with storage bs.raycast: ray
data modify storage bs.raycast: pos set from entity @s Pos
execute store result score #raycast.ex bs.data run data get storage bs.raycast: pos[0] 16384
execute store result score #raycast.ey bs.data run data get storage bs.raycast: pos[1] 16384
execute store result score #raycast.ez bs.data run data get storage bs.raycast: pos[2] 16384
execute unless data storage bs.raycast: ray{_shift_x:0,_shift_z:0} run tp @s ~ ~ ~
