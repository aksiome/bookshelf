$data modify storage bs:data mutate.ops[0].path set value "$(storage) $(nbt).$(path)"
$data modify storage bs:data mutate.ops[0].value set from storage $(storage) $(nbt).$(path)

$function $(fn) with storage bs:data mutate.ops[0]

data remove storage bs:data mutate.ops[0]
execute unless data storage bs:data mutate.ops[0] run return 1

data modify storage bs:data mutate.next set from storage bs:data mutate.ops[1].op
$data modify storage bs:data mutate.fn set from storage bs:const data.mutate.ops[{name:"$(next)"}].fn
return run function bs.data:mutate/loop with storage bs:data mutate
