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
# Documentation of the feature: https://bookshelf.docs.gunivers.net/en/latest/modules/vector.html#dot-product
# ------------------------------------------------------------------------------------------------------------

$scoreboard players set #vector.scaling bs.data $(scaling)

scoreboard players operation $vector.dot_product bs.out = $vector.dot_product.u.0 bs.in
scoreboard players operation $vector.dot_product bs.out *= $vector.dot_product.v.0 bs.in
scoreboard players operation #vector.dot_product bs.data = $vector.dot_product.u.1 bs.in
scoreboard players operation #vector.dot_product bs.data *= $vector.dot_product.v.1 bs.in
scoreboard players operation $vector.dot_product bs.out += #vector.dot_product bs.data
scoreboard players operation #vector.dot_product bs.data = $vector.dot_product.u.2 bs.in
scoreboard players operation #vector.dot_product bs.data *= $vector.dot_product.v.2 bs.in
scoreboard players operation $vector.dot_product bs.out += #vector.dot_product bs.data
return run scoreboard players operation $vector.dot_product bs.out /= #vector.scaling bs.data
