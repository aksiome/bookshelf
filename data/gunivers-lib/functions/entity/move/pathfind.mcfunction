# NAME: Pathfind
# PATH: gunivers-lib:entity/move/pathfind

# AUTHOR: LeiRoF

# VERSION: 1.0
# MINECRAFT: 1.13

# REQUIREMENTS:
# - Vars (module)


# INIT:
scoreboard objectives add Var1 dummy
scoreboard objectives add Var2 dummy
scoreboard objectives add Var3 dummy

scoreboard objectives add PathCost dummy

# CODE:
#____________________________________________________________________________________________________

execute at @s align x align y align z positioned ~0.5 ~ ~0.5 run summon armor_stand ~ ~ ~ {Invisible:0,Marker:0,NoGravity:1,Tags:["Glib_Pathfind_Source"]}
summon armor_stand ~ ~ ~ {Invisible:0,Marker:0,NoGravity:1,Tags:["Glib_Pathfind_Target"]}

execute as @e[tag=Glib_Pathfind_Source] run function gunivers-lib:entity/move/child/pathfind/source

# Clear
kill @e[tag=Glib_Pathfind_Target]
kill @e[tag=Glib_Pathfind_Source]