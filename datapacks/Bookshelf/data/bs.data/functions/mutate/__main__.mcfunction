$data modify storage bs:data mutate set value {storage:$(storage),nbt:$(nbt),ops:$(ops)}

execute unless data storage bs:data mutate.ops[0] run return 1

data modify storage bs:data mutate.next set from storage bs:data mutate.ops[0].op
return run function bs.data:mutate/start with storage bs:data mutate
