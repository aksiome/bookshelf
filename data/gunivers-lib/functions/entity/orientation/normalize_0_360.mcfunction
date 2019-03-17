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


scoreboard players operation @s OriT %= 180 Constant
scoreboard players operation @s OriP %= 360 Constant

scoreboard players add @s[scores={OriT=..-1}] OriT 180
scoreboard players add @s[scores={OriP=..-1}] OriP 360