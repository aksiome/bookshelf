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

kill B5-0-0-0-1
kill B5-0-0-0-3
forceload remove -30000000 1600

scoreboard objectives remove bs.const
scoreboard objectives remove bs.ctx
scoreboard objectives remove bs.out

scoreboard objectives remove bs.width
scoreboard objectives remove bs.height
scoreboard objectives remove bs.depth

data remove storage bs:out hitbox
data remove storage bs:data hitbox
