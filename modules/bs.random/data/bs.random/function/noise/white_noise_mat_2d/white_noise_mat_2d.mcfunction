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

data modify storage bs:ctx _ set value {scale:1}
$scoreboard players set #w bs.ctx $(width)
$scoreboard players set #h bs.ctx $(height)
$data modify storage bs:ctx _ merge value $(with)
execute store result storage bs:ctx _.scale double .000001 run data get storage bs:ctx _.scale 1000

scoreboard players set #y bs.ctx 0
data modify storage bs:out random.white_noise_mat_2d set value []
execute if score #h bs.ctx matches 1.. if score #w bs.ctx matches 1.. run function bs.random:noise/white_noise_mat_2d/yloop
