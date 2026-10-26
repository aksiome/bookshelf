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

$execute as @e[tag=bs.raycast.target,distance=..$(_around)] if score @s bs.raycast.hit = #raycast.next bs.data run function bs.raycast:cast/entity/fire/hit
scoreboard players set #raycast.next bs.data 2147483647
$execute as @e[tag=bs.raycast.target,distance=..$(_around)] run scoreboard players operation #raycast.next bs.data < @s bs.raycast.hit
execute store result score #raycast.ahead bs.data run compute default integer {type:"floor_div",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.next"}},right:64}
execute if score #raycast.shaped bs.data matches 1 run return run function bs.raycast:cast/entity/fire/after
execute store result storage bs.raycast: ray._entry double 0.00000095367431640625 run scoreboard players get #raycast.hit bs.data
execute if score #raycast.pierce bs.data matches 0 run return run function bs.raycast:cast/utils/stop_entry
execute if data storage bs.raycast: ray.on_entry at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_entry with storage bs.raycast: ray
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit store result storage bs.raycast: ray._exit double 0.00006103515625 run scoreboard players get #raycast.exit bs.data
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_exit with storage bs.raycast: ray
execute if score #raycast.pierce bs.data matches 0 run return run scoreboard players set #raycast.max bs.data -2147483648
execute if score #raycast.ahead bs.data <= #raycast.until bs.data run return run function bs.raycast:cast/entity/fire/next with storage bs.raycast: ray
return fail
