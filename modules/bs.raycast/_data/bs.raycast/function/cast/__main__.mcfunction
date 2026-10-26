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

data modify storage bs.raycast: ray set value {max_distance:16,_shift_x:0,_shift_z:0}
data modify storage bs.raycast: ray merge from storage bs.raycast:cast in
execute unless data storage bs.raycast: ray.blocks unless data storage bs.raycast: ray.entities run return fail
execute store result score #raycast.next bs.data run scoreboard players set #raycast.ahead bs.data 2147483647
execute summon minecraft:marker run function bs.raycast:cast/setup
return run execute if score #raycast.max bs.data matches -2147483648
