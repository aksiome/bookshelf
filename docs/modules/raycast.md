# 🔦 Raycast

**`#bs.raycast:help`**

Cast rays to detect block and entity hits, with voxel-accurate collisions.

```{pull-quote}
"Reality only reveals itself when it is illuminated by a ray of poetry."

-- Georges Braque
```

---

## Functions

The following functions are available in this module.

---

### Cast

```{feature} bs.raycast:cast
```

```{tip}
A ray never hits an entity tagged `bs.raycast.omit`, such as the entity that casts it: run `tag @s add bs.raycast.omit` on it once.
```

*Example: check if there is a block within 10 blocks in front of you*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ if function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:10}} run say I see a block
```

*Example: turn the block you look at into gold*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/outline",max_distance:6,on_block:"setblock ~ ~ ~ minecraft:gold_block"}}
```

*Example: show where the ray enters and leaves each block, through up to 16 blocks*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"return 1",on_entry:"particle minecraft:flame ~ ~ ~",on_exit:"particle minecraft:soul_fire_flame ~ ~ ~"}}
```

---

## Predicates

The following predicates are available in this module. Use them in a [command of the ray](#commands).

---

### Hit face

:::::{tab-set}
::::{tab-item} Bottom

```{feature} bs.raycast:face/bottom
```

::::
::::{tab-item} East

```{feature} bs.raycast:face/east
```

::::
::::{tab-item} North

```{feature} bs.raycast:face/north
```

::::
::::{tab-item} South

```{feature} bs.raycast:face/south
```

::::
::::{tab-item} Top

```{feature} bs.raycast:face/top
```

::::
::::{tab-item} West

```{feature} bs.raycast:face/west
```

::::
:::::

*Example: place a torch on the top of the block you look at*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/outline",max_distance:6,on_block:"execute if predicate bs.raycast:face/top run setblock ~ ~1 ~ minecraft:torch keep"}}
```

---

### Hit flag

:::::{tab-set}
::::{tab-item} 1

```{feature} bs.raycast:flag/1
```

::::
::::{tab-item} 2

```{feature} bs.raycast:flag/2
```

::::
::::{tab-item} 4

```{feature} bs.raycast:flag/4
```

::::
::::{tab-item} 8

```{feature} bs.raycast:flag/8
```

::::
:::::

*Example: say when the ray enters water, with a provider that gives the fluid of a block the flag `2`*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision_with_fluid",on_block:"return 1",on_entry:"execute if predicate bs.raycast:flag/2 run say Splash"}}
```

---

## Float providers

The following float providers are available in this module. Use them in a [command of the ray](#commands): the entry ones in any command, where `on_block` gets the nearest entry of the block and `on_entry` and `on_exit` the entry of their shape, and the exit ones in `on_exit`.

---

### Hit entry

:::::{tab-set}
::::{tab-item} Distance

```{feature} bs.raycast:entry/distance
```

::::
::::{tab-item} X

```{feature} bs.raycast:entry/x
```

::::
::::{tab-item} Y

```{feature} bs.raycast:entry/y
```

::::
::::{tab-item} Z

```{feature} bs.raycast:entry/z
```

::::
:::::

*Example: keep the distance to the block you look at*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"data modify storage my_pack: distance set compute default float bs.raycast:entry/distance"}}

# See the result
data get storage my_pack: distance
```

*Example: keep where the ray enters the block you look at, relative to that block*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"data modify storage my_pack: y set compute default float bs.raycast:entry/y"}}

# See the result
data get storage my_pack: y
```

---

### Hit exit

:::::{tab-set}
::::{tab-item} Distance

```{feature} bs.raycast:exit/distance
```

::::
::::{tab-item} X

```{feature} bs.raycast:exit/x
```

::::
::::{tab-item} Y

```{feature} bs.raycast:exit/y
```

::::
::::{tab-item} Z

```{feature} bs.raycast:exit/z
```

::::
:::::

*Example: keep how far the ray goes through the first block it pierces*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"return 1",on_exit:"data modify storage my_pack: exit set compute default float bs.raycast:exit/distance"}}

# See the result
data get storage my_pack: exit
```

---

## Int providers

The following int providers are available in this module. Use them in a [command of the ray](#commands).

---

### Hit block

:::::{tab-set}
::::{tab-item} X

```{feature} bs.raycast:block/x
```

::::
::::{tab-item} Y

```{feature} bs.raycast:block/y
```

::::
::::{tab-item} Z

```{feature} bs.raycast:block/z
```

::::
:::::

*Example: keep the coordinates of the block you look at*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"execute store result score #x my_pack run compute default integer bs.raycast:block/x"}}

# See the result
scoreboard players get #x my_pack
```

---

(commands)=
## Commands

A ray runs commands where it hits something. They decide what the ray does next.

---

The ray goes from block to block. In each block it hits, it groups the boxes of the [block provider](hitbox.md#block-providers) into shapes: boxes with the same flag that touch or overlap are one shape. Its commands then run in this order:

:::{list-table}
*   - **`on_block`**
    - Once for the block, aligned to the grid, before the commands of its shapes. The [predicates](#predicates) and [providers](#float-providers) give the nearest entry, and every flag of the shapes the ray goes through.
*   - **`on_entry`**
    - At the point where the ray enters a shape, nearest shape first.
*   - **`on_exit`**
    - At the point where the ray leaves that shape, right after its `on_entry`.
:::

A ray that leaves a shape and enters it again, such as through the two walls of a cauldron, gives an entry and an exit each time.

The ray stops at the first block it hits, unless `on_block` is a `return` that succeeds, such as `return 1` or `return run execute if ...`. A ray that stops only enters the nearest shape of that block, and never runs `on_exit` there. A ray that goes on can still be stopped by `on_entry` or `on_exit`, when they `return 0` or `return fail`.

*Example: a waterlogged stairs hit with `#bs.hitbox:get_block/collision_with_fluid`, which gives the stairs the flag `1` and the water the flag `2`*

:::{list-table}
*   - **`on_block`**
    - Runs once: `flag/1` and `flag/2` both pass
*   - **`on_entry`** and **`on_exit`**
    - Run for the stairs, where `flag/1` passes, then for the water, where `flag/2` passes, in the order the ray enters them
:::

---

```{include} ../_templates/comments.md
```
