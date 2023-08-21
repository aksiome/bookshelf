$data modify storage bs:data mutate.fn set from storage bs:const data.mutate.ops[{name:"$(next)"}].fn
data modify storage bs:data mutate.path set from storage bs:data mutate.ops[0].path
data modify storage bs:data mutate.next set from storage bs:data mutate.ops[1].op

return run function bs.data:mutate/loop with storage bs:data mutate
