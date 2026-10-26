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

# tags left by a ray that did not end, such as one past the command limit
$tag @e[tag=bs.raycast.pending,distance=..$(_around)] remove bs.raycast.pending
$tag @e[tag=bs.raycast.todo,distance=..$(_around)] remove bs.raycast.todo
# the marker is left out
# a custom box: its feet are within 16 blocks of the ray
$execute positioned ^ ^ ^$(_middle) as @e[distance=..$(_reach),tag=!bs.raycast.done,$(selector)] positioned ^4194304 ^ ^ if entity @s[distance=..4194320] positioned ^-8388608 ^ ^ if entity @s[distance=..4194320] positioned ^4194304 ^4194304 ^ if entity @s[distance=..4194320] positioned ^ ^-8388608 ^ if entity @s[distance=..4194320] run tag @s add bs.raycast.todo
# the hits, nearest first, then the end of the ray
function bs.raycast:castalt/entity/only/next with storage bs.raycast: ray
$tag @e[tag=bs.raycast.todo,distance=..$(_around)] remove bs.raycast.todo
$tag @e[tag=bs.raycast.pending,distance=..$(_around)] remove bs.raycast.pending
scoreboard players set #raycast.entity bs.data 0
tp @s ~ -1000000 ~
kill @s
