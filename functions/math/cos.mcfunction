# NAME: Cosinus
# PATH: Gunivers-Lib:Math/Cos
 
# AUTHOR: LeiRoF
 
# VERSION: 1.0
# MINECRAFT: 1.12 
 
# REQUIREMENTS: 
# - Gunivers-Lib:Utils/Import/Temporary (Import file)
# - Gunivers-Lib:Utils/Import/Math (Import file) 
# - Gunivers-Lib:Utils/Import/Constant(Import file)

# INPUT: 
# - Var1 (score dummy)
 
# OUTPUT: 
# - Res (score dummy) 


# CODE:

# Convert to angle [0;360]

scoreboard players operation @s[scores={Var1=..-1}] Var1 *= Neg Constant
scoreboard players operation @s[scores={Var1=360..}] Var1 %= 360 Constant

# Retranscription of Var1 on interval [0;90[

scoreboard players operation @s Var3 = @s Var1
scoreboard players operation @s[scores={Var1=90..179}] Var3 *= Neg Constant
scoreboard players operation @s[scores={Var1=90..179}] Var3 += 180 Constant
scoreboard players operation @s[scores={Var1=180..269}] Var3 -= 180 Constant
scoreboard players operation @s[scores={Var1=270..}] Var3 *= Neg Constant
scoreboard players operation @s[scores={Var1=270..}] Var3 += 360 Constant

# Calcul Cos

scoreboard players operation @s Res = @s Var3
scoreboard players operation @s Res *= @s Res
scoreboard players operation @s Res *= 4 Constant
scoreboard players operation @s Res *= Neg Constant
scoreboard players operation @s Res += 32400 Constant
scoreboard players operation @s Res *= 1000 Constant
scoreboard players operation @s Var2 = @s Var3
scoreboard players operation @s Var2 *= @s Var2
scoreboard players operation @s Var2 += 32400 Constant
scoreboard players operation @s Res /= @s Var2

scoreboard players operation @s[scores={Var1=90..269}] Res *= Neg Constant


