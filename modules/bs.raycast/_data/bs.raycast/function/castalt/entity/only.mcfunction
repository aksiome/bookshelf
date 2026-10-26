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

#execute if data storage bs.raycast: ray.on_entity run return run function <todoeachsincecanhavepiercing?>

scoreboard players set #raycast.hit bs.data 2147483647
data modify storage bs.raycast: ray._selector set from storage bs.raycast: ray.selector
data modify storage bs.raycast: ray._predicate set string storage bs.raycast: ray.entities 0 11
execute store result storage bs.raycast: ray._reach double 0.000030517578125 run compute default integer {type:"add",inputs:[{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.max"}},524288]}
execute unless data storage bs.raycast: ray{_predicate:"#bs.hitbox:"} run return run function bs.raycast:castalt/entity/first/custom with storage bs.raycast: ray
execute if data storage bs.raycast: ray.selector run return run function bs.raycast:castalt/entity/first/selector with storage bs.raycast: ray
data modify storage bs.raycast: ray._predicate set string storage bs.raycast: ray.entities 1
function bs.raycast:castalt/entity/first/predicate with storage bs.raycast: ray
