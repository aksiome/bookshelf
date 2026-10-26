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

# as the marker, at the origin: the entry and exit commands of the hit that ran
execute if score #raycast.pierce bs.data matches 0 run return run function bs.raycast:cast/utils/stop_entry
execute if data storage bs.raycast: ray.on_entry store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_entry with storage bs.raycast: ray
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit store result storage bs.raycast: ray._exit double 0.00006103515625 run scoreboard players get #raycast.exit bs.data
execute unless score #raycast.pierce bs.data matches 0 if data storage bs.raycast: ray.on_exit store result score #raycast.pierce bs.data run function bs.raycast:cast/utils/at_exit with storage bs.raycast: ray
scoreboard players set #raycast.entity bs.data 0
execute if score #raycast.pierce bs.data matches 0 run scoreboard players set #raycast.max bs.data -2147483648
