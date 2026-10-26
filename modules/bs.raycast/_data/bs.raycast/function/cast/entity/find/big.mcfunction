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

# as the entity, at its position: a box wider than 3 along x or z, or taller than 3
execute positioned ~1.5 ~-4096 ~-4096 unless entity @s[dx=4096,dy=8192,dz=8192] positioned as @s positioned ~-4096 ~-4096 ~1.5 unless entity @s[dx=8192,dy=8192,dz=4096] positioned as @s positioned ~-4096 ~3 ~-4096 unless entity @s[dx=8192,dy=4096,dz=8192] run return fail
return 1
