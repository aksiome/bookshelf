tp B5-0-0-0-1 ~ ~ ~
execute store result score #move.x1 bs.data store result score #move.x bs.data run data get entity B5-0-0-0-1 Pos[0] 1000
execute store result score #move.y1 bs.data store result score #move.y bs.data run data get entity B5-0-0-0-1 Pos[1] 1000
execute store result score #move.z1 bs.data store result score #move.z bs.data run data get entity B5-0-0-0-1 Pos[2] 1000
execute store result score #move.x2 bs.data run data get entity @s Pos[0] 1000
execute store result score #move.y2 bs.data run data get entity @s Pos[1] 1000
execute store result score #move.z2 bs.data run data get entity @s Pos[2] 1000
execute store result score #move.vx bs.data run scoreboard players operation #move.x2 bs.data -= #move.x1 bs.data
execute store result score #move.vy bs.data run scoreboard players operation #move.y2 bs.data -= #move.y1 bs.data
execute store result score #move.vz bs.data run scoreboard players operation #move.z2 bs.data -= #move.z1 bs.data
scoreboard players operation #move.h bs.data = @s bs.height
scoreboard players operation #move.w bs.data = @s bs.width
scoreboard players operation #move.w bs.data /= 2 bs.const

scoreboard players set #move.dr bs.data 0
scoreboard players set #move.ct bs.data 2147483647
execute if score #move.vx bs.data matches 0.. run scoreboard players add #move.dr bs.data 4
execute if score #move.vy bs.data matches 0.. run scoreboard players add #move.dr bs.data 2
execute if score #move.vz bs.data matches 0.. run scoreboard players add #move.dr bs.data 1
execute if score #move.dr bs.data matches 0 run function bs.move:collision/recurse/init/nnn
execute if score #move.dr bs.data matches 1 run function bs.move:collision/recurse/init/nnp
execute if score #move.dr bs.data matches 2 run function bs.move:collision/recurse/init/npn
execute if score #move.dr bs.data matches 3 run function bs.move:collision/recurse/init/npp
execute if score #move.dr bs.data matches 4 run function bs.move:collision/recurse/init/pnn
execute if score #move.dr bs.data matches 5 run function bs.move:collision/recurse/init/pnp
execute if score #move.dr bs.data matches 6 run function bs.move:collision/recurse/init/ppn
execute if score #move.dr bs.data matches 7 run function bs.move:collision/recurse/init/ppp
$execute unless score #move.ct bs.data matches 2147483647 run function $(on_collision)
execute in minecraft:overworld run tp B5-0-0-0-1 0 0 0
