# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

$execute as @e[tag=bs.raycast.todo,distance=..$(_around)] positioned ^ ^ ^$(_entry) positioned ~ ~-4096 ~-4096 if entity @s[dx=8192,dy=8192,dz=8192] positioned ~-4096 ~-4097 ~ if entity @s[dx=8192,dy=8192,dz=8192] positioned ~ ~4097 ~-4097 if entity @s[dx=8192,dy=8192,dz=8192] positioned as @n[type=minecraft:marker,tag=bs.raycast.origin] positioned ~-8193 ~-4096 ~-4096 if entity @s[dx=8192,dy=8192,dz=8192] positioned ~4097 ~4096 ~ if entity @s[dx=8192,dy=8192,dz=8192] positioned ~ ~-4096 ~4096 if entity @s[dx=8192,dy=8192,dz=8192] run function bs.raycast:castalt/entity/check with storage bs.raycast: ray
