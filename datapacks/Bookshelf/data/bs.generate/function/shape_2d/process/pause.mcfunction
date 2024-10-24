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
# Documentation of the feature: https://bookshelf.docs.gunivers.net/en/latest/modules/generate.html#shape-2d
# ------------------------------------------------------------------------------------------------------------

tp @s ~ ~ ~ ~ ~
data modify storage bs:data generate._.pos set from entity @s Pos
data modify storage bs:data generate._.rot set from entity @s Rotation
execute in minecraft:overworld run tp @s -30000000 0 1600

execute store result storage bs:data generate._.x int 1 run scoreboard players get $generate.x bs.data
execute store result storage bs:data generate._.y int 1 run scoreboard players get $generate.y bs.data

data modify storage bs:data generate.shape_2d prepend from storage bs:data generate._
schedule function bs.generate:shape_2d/process/scheduled 1t replace