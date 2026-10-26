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

# a Bookshelf provider: its predicate when there is no selector, and the size of vanilla boxes
execute if data storage bs.raycast: ray{entities:"#bs.hitbox:get_entity/living"} run return run function bs.raycast:cast/entity/find/predicate {id:"living"}
execute if data storage bs.raycast: ray{entities:"#bs.hitbox:get_entity/pushable"} run return run function bs.raycast:cast/entity/find/predicate {id:"pushable"}
execute if data storage bs.raycast: ray{entities:"#bs.hitbox:get_entity/sized"} run return run function bs.raycast:cast/entity/find/predicate {id:"sized"}
execute if data storage bs.raycast: ray{entities:"#bs.hitbox:get_entity/solid"} run return run function bs.raycast:cast/entity/find/predicate {id:"solid"}
execute if data storage bs.raycast: ray{entities:"#bs.hitbox:get_entity/targetable"} run return run function bs.raycast:cast/entity/find/predicate {id:"targetable"}
# any other: every entity, in a tube
execute unless data storage bs.raycast: ray.selector run data modify storage bs.raycast: ray.selector set value "sort=arbitrary"
function bs.raycast:cast/entity/find/custom with storage bs.raycast: ray
