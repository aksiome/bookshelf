# This file was automatically generated, do not edit it
execute if block ~ ~ ~ #bs.block:has_state[facing=north] run data modify storage bs:out block._[{n:"facing"}].o[{v:"north"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[facing=south] run data modify storage bs:out block._[{n:"facing"}].o[{v:"south"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[facing=west] run data modify storage bs:out block._[{n:"facing"}].o[{v:"west"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[facing=east] run data modify storage bs:out block._[{n:"facing"}].o[{v:"east"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[half=lower] run data modify storage bs:out block._[{n:"half"}].o[{v:"lower"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[half=upper] run data modify storage bs:out block._[{n:"half"}].o[{v:"upper"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[hinge=left] run data modify storage bs:out block._[{n:"hinge"}].o[{v:"left"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[hinge=right] run data modify storage bs:out block._[{n:"hinge"}].o[{v:"right"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[open=false] run data modify storage bs:out block._[{n:"open"}].o[{v:"false"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[open=true] run data modify storage bs:out block._[{n:"open"}].o[{v:"true"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[powered=false] run data modify storage bs:out block._[{n:"powered"}].o[{v:"false"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[powered=true] run data modify storage bs:out block._[{n:"powered"}].o[{v:"true"}].c set value 1b
