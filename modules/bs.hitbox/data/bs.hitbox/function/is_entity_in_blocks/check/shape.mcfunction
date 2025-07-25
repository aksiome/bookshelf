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

execute store result score #l bs.ctx run data get storage bs:ctx _.shape[-1][0] 625000
execute store result score #m bs.ctx run data get storage bs:ctx _.shape[-1][1] 625000
execute store result score #n bs.ctx run data get storage bs:ctx _.shape[-1][2] 625000
execute store result score #o bs.ctx run data get storage bs:ctx _.shape[-1][3] 625000
execute store result score #p bs.ctx run data get storage bs:ctx _.shape[-1][4] 625000
execute store result score #q bs.ctx run data get storage bs:ctx _.shape[-1][5] 625000

# offset coordinates if needed
scoreboard players operation #l bs.ctx += #u bs.ctx
scoreboard players operation #o bs.ctx += #u bs.ctx
scoreboard players operation #n bs.ctx += #v bs.ctx
scoreboard players operation #q bs.ctx += #v bs.ctx

# check aabb vs aabb collision
execute \
  if score #x bs.ctx < #o bs.ctx \
  if score #i bs.ctx > #l bs.ctx \
  if score #y bs.ctx < #p bs.ctx \
  if score #j bs.ctx > #m bs.ctx \
  if score #z bs.ctx < #q bs.ctx \
  if score #k bs.ctx > #n bs.ctx \
run return 1

data remove storage bs:ctx _.shape[-1]
execute if data storage bs:ctx _.shape[0] run return run function bs.hitbox:is_entity_in_blocks/check/shape
