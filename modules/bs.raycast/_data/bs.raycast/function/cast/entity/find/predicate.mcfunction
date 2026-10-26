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

# the predicate of the provider when there is no selector
$execute unless data storage bs.raycast: ray.selector run data modify storage bs.raycast: ray.selector set value "predicate=bs.hitbox:get_entity/$(id)"
function bs.raycast:cast/entity/find/vanilla with storage bs.raycast: ray
