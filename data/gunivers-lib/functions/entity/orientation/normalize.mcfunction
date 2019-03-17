# NAME: Normalize Orientation
# PATH: gunivers-lib:entity/orientation/normalize

# AUTHOR: LeiRoF
# CONTRIBUTORS: 
# - KubbyDev

# VERSION: 1.0
# MINECRAFT: 1.12

# REQUIREMENTS:
# - gunivers-lib:utils/import/orientation (Import file)
# - gunivers-lib:utils/import/constant (Import file)

# INPUT:
# - Phi (score dummy)
# - Theta (score dummy)

# OUTPUT:
# - Phi (score dummy)
# - Theta (score dummy)

# CODE:
#____________________________________________________________________________________________________


# Vertical Orientation
scoreboard players operation @s OriT %= 360 Constant

execute if entity @s[scores={OriT=-360..-270}] run scoreboard players add @s OriT 360

tag @s[scores={OriT=-269..-91}] add Glib_Ori_Switch
scoreboard players add @s[tag=Glib_Ori_Switch] OriP 180
scoreboard players add @s[tag=Glib_Ori_Switch,scores={OriT=-269..-180}] OriT 180
scoreboard players operation @s[tag=Glib_Ori_Switch] OriT *= -1 Constant

tag @s remove Glib_Ori_Switch

# Horizontal Orientation
scoreboard players operation @s OriP %= 360 Constant
scoreboard players add @s[scores={OriP=..-1}] OriP 360