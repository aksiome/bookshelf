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

$execute positioned ^ ^ ^$(_middle) as @e[tag=!bs.raycast.omit,distance=..$(_reach),$(_selector)] positioned ^4194304 ^ ^ if entity @s[distance=..4194320] positioned ^-8388608 ^ ^ if entity @s[distance=..4194320] positioned ^4194304 ^4194304 ^ if entity @s[distance=..4194320] positioned ^ ^-8388608 ^ if entity @s[distance=..4194320] run function bs.raycast:castalt/entity/first/check with storage bs.raycast: ray
execute unless score #raycast.hit bs.data matches 2147483647 run function bs.raycast:castalt/entity/first/emit with storage bs.raycast: ray
