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

scoreboard players operation #raycast.block_mask bs.data = #raycast.mask bs.data
execute store result score #raycast.hit bs.data run compute default integer bs.raycast:_cast/nearest
execute if function bs.raycast:cast/entity/before/block run return 1
scoreboard players operation #raycast.mask bs.data = #raycast.block_mask bs.data
return fail
