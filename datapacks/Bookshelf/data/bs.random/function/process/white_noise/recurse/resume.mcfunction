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

data modify entity @s Pos set from storage bs:data random.process.pos
data modify entity @s Rotation set from storage bs:data random.process.rot

execute store result score #random.x bs.data run data get storage bs:data random.process.x
execute store result score #random.y bs.data run data get storage bs:data random.process.y
execute store result score #random.w bs.data run data get storage bs:data random.process.w
execute store result score #random.h bs.data run data get storage bs:data random.process.h
execute store result score #random.i bs.data run data get storage bs:data random.process.limit

data modify storage bs:out random.white_noise set value [[]]
execute at @s run function bs.random:process/white_noise/recurse/next with storage bs:data random.process

execute in minecraft:overworld run tp @s -30000000 0 1600
