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

# as the marker, at the origin: the selected entities nearest to the origin are tested until one hits, then it is visited
$execute unless entity @e[tag=bs.raycast.todo,distance=..$(_around),limit=1] run return 0
scoreboard players set #raycast.found bs.data 0
function bs.raycast:castalt/entity/only/pick with storage bs.raycast: ray
$execute as @e[tag=bs.raycast.pending,distance=..$(_around),limit=1] run function bs.raycast:castalt/entity/visit with storage bs.raycast: ray
