# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/Gunivers/Bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
#
# Documentation of the feature: https://bookshelf.docs.gunivers.net/en/latest/modules/random.html#noise
# ------------------------------------------------------------------------------------------------------------

tp @s ~ ~ ~ ~ ~
data modify storage bs:data random.process.pos set from entity @s Pos
data modify storage bs:data random.process.rot set from entity @s Rotation
execute in minecraft:overworld run tp @s -30000000 0 1600

execute store result storage bs:data random.process.x int 1 run scoreboard players get #random.x bs.data
execute store result storage bs:data random.process.y int 1 run scoreboard players get #random.y bs.data

function bs.random:process/queue
