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

execute store result score #x bs.ctx store result score #y bs.ctx run scoreboard players operation #t bs.ctx += #s bs.ctx
$execute if score #t bs.ctx matches 1000.. if data storage bs:ctx _.points[3] run function bs.spline:utils/$(type)/next_segment_2d
execute if score #t bs.ctx matches ..1000 run function bs.spline:utils/compute_2d
$execute if score #t bs.ctx matches ..1000 run data modify storage bs:out spline.sample_$(type) append from storage bs:lambda spline.point
$execute if score #t bs.ctx matches ..999 run function bs.spline:sample/sample_2d {type:"$(type)"}
