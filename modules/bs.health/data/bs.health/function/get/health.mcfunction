# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

execute if score @s bs.hmod matches 1.. store result storage bs:out health.get_health double 0.00001 run scoreboard players get @s bs.hmod
execute unless score @s bs.hmod matches 1.. run data modify storage bs:out health.get_health set from entity @s Health
$return run data get storage bs:out health.get_health $(scale)
