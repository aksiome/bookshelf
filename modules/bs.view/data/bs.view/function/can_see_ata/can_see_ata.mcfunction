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
data modify storage bs:ctx x set from storage bs:ctx _[0]
data modify storage bs:ctx y set from storage bs:ctx _[1]
data modify storage bs:ctx z set from storage bs:ctx _[2]
execute summon minecraft:marker run function bs.view:can_see_ata/get_relative_pos with storage bs:ctx

# compute Euclidean distance: sqrt(x^2+y^2+z^2)
# Thanks to Triton365 for sharing this trick on the Minecraft Commands discord
execute store result storage bs:data view.transformation[0] float .001 run data get storage bs:ctx _[0] 1000
execute store result storage bs:data view.transformation[4] float .001 run data get storage bs:ctx _[1] 1000
execute store result storage bs:data view.transformation[8] float .001 run data get storage bs:ctx _[2] 1000
data modify entity B5-0-0-0-2 transformation set from storage bs:data view.transformation

data modify storage bs:data raycast.max_distance set from entity B5-0-0-0-2 transformation.scale[0]
execute facing entity @s eyes run function bs.raycast:run
return run execute if score #raycast.distance bs.data matches 2147483647
