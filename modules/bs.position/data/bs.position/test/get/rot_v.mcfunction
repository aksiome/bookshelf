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
# @dummy

execute at @s rotated ~1 ~1 run function #bs.position:get_rot_v {scale:10}

execute store result score #v bs.ctx run data get entity @s Rotation[1] 10
scoreboard players operation #v bs.ctx -= @s bs.rot.v

assert score #v bs.ctx matches -11..-9
