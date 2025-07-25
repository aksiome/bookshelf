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

data modify storage bs:ctx _ set from entity @s Pos
execute store result score #move.y bs.data run data get storage bs:ctx _[1] 10000
execute store result storage bs:data move.x int -1 run data get storage bs:ctx _[0]
execute store result storage bs:data move.y int -1 run data get storage bs:ctx _[1]
execute store result storage bs:data move.z int -1 run data get storage bs:ctx _[2]
function bs.move:collision/utils/get_relative_pos with storage bs:data move
