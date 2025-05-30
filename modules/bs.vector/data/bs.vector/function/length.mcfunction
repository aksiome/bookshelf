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

# compute Euclidean distance: sqrt(x^2+y^2+z^2)
# Thanks to Triton365 for sharing this trick on the Minecraft Commands discord
execute store result storage bs:data vector.transformation[0] float 1 run scoreboard players get $vector.length.0 bs.in
execute store result storage bs:data vector.transformation[4] float 1 run scoreboard players get $vector.length.1 bs.in
execute store result storage bs:data vector.transformation[8] float 1 run scoreboard players get $vector.length.2 bs.in
data modify entity B5-0-0-0-2 transformation set from storage bs:data vector.transformation

execute store result score $vector.length bs.out run return run data get entity B5-0-0-0-2 transformation.scale[0]
