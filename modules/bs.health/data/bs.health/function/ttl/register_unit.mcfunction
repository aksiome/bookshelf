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

$execute store success score #s bs.ctx run function bs.health:ttl/normalize_unit with storage bs:const health.units[{name:'$(unit)'}]
execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace:"bs.health", \
  tag:"time_to_live", \
  message:'"The unit provided is not supported."', \
  path:"bs.health:ttl/register_unit", \
}
