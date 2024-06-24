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

execute if score #random.i bs.data matches 0 run return run function bs.random:process/white_noise/recurse/pause

data modify storage bs:out random.white_noise[-1] append value 0.0f
execute store result storage bs:out random.white_noise[-1][-1] float .001 run random value 1..1000
execute if score #random.i bs.data matches 1.. run function bs.random:process/white_noise/recurse/run with storage bs:data random.process

scoreboard players add #random.x bs.data 1
$execute if score #random.x bs.data < #random.w bs.data positioned ^$(spacing) ^ ^ run return run function bs.random:process/white_noise/recurse/next with storage bs:data random.process
scoreboard players set #random.x bs.data 0
scoreboard players add #random.y bs.data 1
execute if score #random.y bs.data < #random.h bs.data run data modify storage bs:out random.white_noise append value []
$execute if score #random.y bs.data < #random.h bs.data positioned $(ox) ~ $(oz) positioned ^ ^$(spacing) ^ run function bs.random:process/white_noise/recurse/next with storage bs:data random.process
