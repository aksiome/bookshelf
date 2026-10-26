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

execute if score #raycast.pierce bs.data matches 0 run return run function bs.raycast:cast/utils/finalize_entry
execute store result score #raycast.hit bs.data store result score #raycast.mask bs.data store result storage bs.raycast: ray._entry double 0.00000095367431640625 run compute default integer bs.raycast:_cast/enter
execute if data storage bs.raycast: ray.on_entry at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_entry with storage bs.raycast: ray
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit store result score #raycast.exit bs.data store result storage bs.raycast: ray._exit double 0.00006103515625 run compute default integer bs.raycast:_cast/leave
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_exit with storage bs.raycast: ray
execute if score #raycast.pierce bs.data matches 0 run return run scoreboard players set #raycast.max bs.data -2147483648

execute if score #raycast.shapes bs.data matches ..1 run return 0
execute store result score #raycast.hit bs.data store result score #raycast.mask bs.data store result storage bs.raycast: ray._entry double 0.00000095367431640625 run compute default integer bs.raycast:_cast/enter
execute if data storage bs.raycast: ray.on_entry at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_entry with storage bs.raycast: ray
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit store result score #raycast.exit bs.data store result storage bs.raycast: ray._exit double 0.00006103515625 run compute default integer bs.raycast:_cast/leave
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_exit with storage bs.raycast: ray
execute if score #raycast.pierce bs.data matches 0 run return run scoreboard players set #raycast.max bs.data -2147483648

execute if score #raycast.shapes bs.data matches ..2 run return 0
execute store result score #raycast.hit bs.data store result score #raycast.mask bs.data store result storage bs.raycast: ray._entry double 0.00000095367431640625 run compute default integer bs.raycast:_cast/enter
execute if data storage bs.raycast: ray.on_entry at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_entry with storage bs.raycast: ray
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit store result score #raycast.exit bs.data store result storage bs.raycast: ray._exit double 0.00006103515625 run compute default integer bs.raycast:_cast/leave
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_exit with storage bs.raycast: ray
execute if score #raycast.pierce bs.data matches 0 run return run scoreboard players set #raycast.max bs.data -2147483648

execute if score #raycast.shapes bs.data matches ..3 run return 0
execute store result score #raycast.hit bs.data store result score #raycast.mask bs.data store result storage bs.raycast: ray._entry double 0.00000095367431640625 run compute default integer bs.raycast:_cast/enter
execute if data storage bs.raycast: ray.on_entry at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_entry with storage bs.raycast: ray
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit store result score #raycast.exit bs.data store result storage bs.raycast: ray._exit double 0.00006103515625 run compute default integer bs.raycast:_cast/leave
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_exit with storage bs.raycast: ray
execute if score #raycast.pierce bs.data matches 0 run return run scoreboard players set #raycast.max bs.data -2147483648

execute if score #raycast.shapes bs.data matches ..4 run return 0
execute store result score #raycast.hit bs.data store result score #raycast.mask bs.data store result storage bs.raycast: ray._entry double 0.00000095367431640625 run compute default integer bs.raycast:_cast/enter
execute if data storage bs.raycast: ray.on_entry at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_entry with storage bs.raycast: ray
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit store result score #raycast.exit bs.data store result storage bs.raycast: ray._exit double 0.00006103515625 run compute default integer bs.raycast:_cast/leave
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_exit with storage bs.raycast: ray
execute if score #raycast.pierce bs.data matches 0 run return run scoreboard players set #raycast.max bs.data -2147483648

execute if score #raycast.shapes bs.data matches ..5 run return 0
execute store result score #raycast.hit bs.data store result score #raycast.mask bs.data store result storage bs.raycast: ray._entry double 0.00000095367431640625 run compute default integer bs.raycast:_cast/enter
execute if data storage bs.raycast: ray.on_entry at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_entry with storage bs.raycast: ray
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit store result score #raycast.exit bs.data store result storage bs.raycast: ray._exit double 0.00006103515625 run compute default integer bs.raycast:_cast/leave
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_exit with storage bs.raycast: ray
execute if score #raycast.pierce bs.data matches 0 run return run scoreboard players set #raycast.max bs.data -2147483648

execute if score #raycast.shapes bs.data matches ..6 run return 0
execute store result score #raycast.hit bs.data store result score #raycast.mask bs.data store result storage bs.raycast: ray._entry double 0.00000095367431640625 run compute default integer bs.raycast:_cast/enter
execute if data storage bs.raycast: ray.on_entry at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_entry with storage bs.raycast: ray
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit store result score #raycast.exit bs.data store result storage bs.raycast: ray._exit double 0.00006103515625 run compute default integer bs.raycast:_cast/leave
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_exit with storage bs.raycast: ray
execute if score #raycast.pierce bs.data matches 0 run return run scoreboard players set #raycast.max bs.data -2147483648

execute if score #raycast.shapes bs.data matches ..7 run return 0
execute store result score #raycast.hit bs.data store result score #raycast.mask bs.data store result storage bs.raycast: ray._entry double 0.00000095367431640625 run compute default integer bs.raycast:_cast/enter
execute if data storage bs.raycast: ray.on_entry at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_entry with storage bs.raycast: ray
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit store result score #raycast.exit bs.data store result storage bs.raycast: ray._exit double 0.00006103515625 run compute default integer bs.raycast:_cast/leave
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit at @s store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_exit with storage bs.raycast: ray
execute if score #raycast.pierce bs.data matches 0 run return run scoreboard players set #raycast.max bs.data -2147483648
