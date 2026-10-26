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

$execute as @e[tag=bs.raycast.todo,distance=..$(_around),sort=nearest,limit=1] run function bs.raycast:castalt/entity/check with storage bs.raycast: ray
tp @s ~ ~ ~
$execute if score #raycast.found bs.data matches 0 if entity @e[tag=bs.raycast.todo,distance=..$(_around),limit=1] run function bs.raycast:castalt/entity/only/pick with storage bs.raycast: ray
