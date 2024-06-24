# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/Gunivers/Bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
#
# Documentation of the feature: https://bookshelf.docs.gunivers.net/en/latest/modules/random.html#noise
# ------------------------------------------------------------------------------------------------------------

data modify storage bs:data random.process set value { \
  resume: "bs.random:process/white_noise/recurse/resume", \
  x: 0, \
  y: 0, \
  run: "", \
  limit: 4096, \
  direction:"xz", \
  spacing: 1, \
}

$data modify storage bs:data random.process merge value $(with)
$data modify storage bs:data random.process merge value {w:$(width),h:$(height)}
execute unless data storage bs:data random.process.run run data modify storage bs:data random.process.limit set value -1

execute align xyz as B5-0-0-0-1 positioned ~.5 ~.5 ~.5 run function bs.random:process/white_noise/recurse/init
