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
# @dummy

tag @s add bs.foo.log.bar.debug
function #bs.log:error { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Debug tag error log message"' }
assert chat "Debug tag error log message"
tag @s remove bs.foo.log.bar.debug

tag @s add bs.foo.log.bar.info
function #bs.log:error { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Info tag error log message"' }
assert chat "Info tag error log message"
tag @s remove bs.foo.log.bar.info

tag @s add bs.foo.log.bar.warn
function #bs.log:error { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Warn tag error log message"' }
assert chat "Warn tag error log message"
tag @s remove bs.foo.log.bar.warn

tag @s add bs.foo.log.bar.error
function #bs.log:error { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Error tag error log message"' }
assert chat "Error tag error log message"
tag @s remove bs.foo.log.bar.error
