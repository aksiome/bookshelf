data modify storage bs:const data.mutate.ops set value [ \
    {name: "quote", fn: "bs.data:mutate/ops/quote"}, \
    {name: "stringify", fn: "bs.data:mutate/ops/stringify"}, \
    {name: "unquote", fn: "bs.data:mutate/ops/unquote"}, \
]

data modify storage bs:const data.validate.rules set value [ \
    {name: "array", fn: "bs.data:validate/rules/array"}, \
    {name: "bool", fn: "bs.data:validate/rules/bool"}, \
    {name: "byte", fn: "bs.data:validate/rules/byte"}, \
    {name: "compound", fn: "bs.data:validate/rules/compound"}, \
    {name: "double", fn: "bs.data:validate/rules/double"}, \
    {name: "exists", fn: "bs.data:validate/rules/exists"}, \
    {name: "float", fn: "bs.data:validate/rules/float"}, \
    {name: "int", fn: "bs.data:validate/rules/int"}, \
    {name: "long", fn: "bs.data:validate/rules/long"}, \
    {name: "nbt_path", fn: "bs.data:validate/rules/nbt_path"}, \
    {name: "no_whitespace", fn: "bs.data:validate/rules/no_whitespace"}, \
    {name: "number", fn: "bs.data:validate/rules/number"}, \
    {name: "quoted_text", fn: "bs.data:validate/rules/quoted_text"}, \
    {name: "resource_name", fn: "bs.data:validate/rules/resource_name"}, \
    {name: "resource_path", fn: "bs.data:validate/rules/resource_path"}, \
    {name: "resource", fn: "bs.data:validate/rules/resource"}, \
    {name: "short", fn: "bs.data:validate/rules/short"}, \
    {name: "string", fn: "bs.data:validate/rules/string"}, \
    {name: "unquoted_text", fn: "bs.data:validate/rules/unquoted_text"}, \
]
