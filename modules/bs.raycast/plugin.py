from collections.abc import Callable

from beet import Context, ContextFloatProvider, ContextIntProvider

from mcbookshelf.minecraft.condition import Condition
from mcbookshelf.minecraft.math import (
    Expression,
    add,
    btree,
    cond,
    fixed_target,
    float_storage,
    max_,
    min_,
    ref,
    score,
)
from mcbookshelf.pipeline.plugins import Generated, generator

MISS = 2**31 - 1
BLOCK_BOXES = 24
# The keys of the merge put the flag above the entry and its face axis: flag * 2^27 + entry * 4 + axis
FLAGS = 2**27
# The longest entry that fits under the flags: 25 bits, just under 2048 blocks
LONGEST = 2.0**25
# The exits carry the flag too: flag * 2^27 + exit * 4 + JOIN, where JOIN lets a box that starts within 4/16384 of a block after another one ends join it
JOIN = 19
# The scores read the most, each in a provider of its own that the others refer to, to keep them short
SHARED = ("boxes", "mask", "octant", "shapes", "max")


@generator
def beet_default(_: Context) -> Generated:
    for name in SHARED:
        yield f"bs.raycast:_{name}", provider(score("bs.data", fixed_target(f"#raycast.{name}")))
    for name in ("lx", "ly", "lz", "dx", "dy", "dz", "max"):
        yield f"bs.raycast:_{name}", float_provider(score("bs.data", fixed_target(f"#raycast.{name}")).to_float())
    for a in "xyz":
        yield f"bs.raycast:_offset_{a}", float_provider((ctx(f"e{a}") - ctx(a)).to_float() / 16384.0)
        yield f"bs.raycast:_p{a}", float_provider(ray(f"l{a}") - ray(f"d{a}"))

    yield "bs.raycast:_cast/any", provider(octants(any_box))
    yield "bs.raycast:_pierce/block/mask", provider(octants(lambda o: fold(add, lambda k: cond(crossed(k, o), bit(k), 0), 0)))
    yield "bs.raycast:_pierce/block/tally", provider(fold(add, lambda k: cond(marked(k), digit(k), 0), 0))
    yield "bs.raycast:_pierce/block/hit", provider(octants(lambda o: fold(min_, lambda k: cond(marked(k), tagged(k, o), MISS), MISS)) * 16 + flags())
    yield "bs.raycast:_pierce/block/nearest", provider(octants(lambda o: fold(min_, lambda k: cond(marked(k), tagged(k, o) * 16 + flag(k), MISS), MISS)))
    yield "bs.raycast:_cast/block", provider(octants(lambda o: fold(min_, lambda k: cond(crossed(k, o), tagged(k, o) * 16 + flag(k), MISS), MISS)))

    boxes = list(range(BLOCK_BOXES))
    by_box = lambda value: btree(boxes, lambda p: octants(lambda o: value(23 - p, o)), lambda ps: ctx("mask").le(2 ** (max(ps) + 1) - 1))  # noqa: E731
    yield "bs.raycast:_pierce/block/entry_key", provider(by_box(lambda k, o: flag(k) * FLAGS + tagged(k, o)))
    yield "bs.raycast:_pierce/block/exit_key", provider(by_box(lambda k, o: flag(k) * FLAGS + min_(*leaves(k, o)).to_int() * 4 + JOIN))
    yield "bs.raycast:_pierce/block/exit", provider(by_box(lambda k, o: min_(*leaves(k, o)).to_int()))

    e, x, u = lambda j: ctx(f"entry{j}"), lambda j: ctx(f"exit{j}"), ctx("limit")
    yield "bs.raycast:_pierce/shape/start", provider(fold(min_, e, MISS, "shapes"))
    yield "bs.raycast:_pierce/shape/grow", provider(fold(max_, lambda j: cond(e(j).le(u), cond(x(j).ge(u + 1), x(j), -MISS), -e(j)), -MISS, "shapes"))

    g = lambda i: ctx(f"start{i}")  # noqa: E731
    ordered = lambda i: g(i).floor_mod(FLAGS) * 16 + g(i) // FLAGS  # noqa: E731
    yield "bs.raycast:_pierce/shape/hit", provider(fold(min_, lambda i: g(i).floor_mod(FLAGS), MISS, "shapes") * 16 + add(*(found(f) for f in (1, 2, 4, 8))))
    yield "bs.raycast:_pierce/shape/enter", provider(fold(min_, lambda i: cond(ordered(i).le(ctx("mask")), MISS, ordered(i)), MISS, "shapes"))
    yield "bs.raycast:_cast/entity", provider(part_fold(min_, lambda k: cond(part_crossed(k), part_tagged(k) * 16 + part_flag(k), MISS), MISS))
    yield "bs.raycast:_pierce/entity/exit", provider(part_fold(max_, lambda k: cond(part_crossed(k), min_(*part_leaves(k)).to_int(), -1), -1))
    yield "bs.raycast:_pierce/entity/mask", provider(part_fold(add, lambda k: cond(part_crossed(k), bit(k), 0), 0))
    parts = list(range(16, 24))
    by_part = lambda value: btree(parts, lambda p: value(23 - p), lambda ps: ctx("mask").le(2 ** (max(ps) + 1) - 1))  # noqa: E731
    yield "bs.raycast:_pierce/entity/entry_key", provider(by_part(lambda k: part_flag(k) * FLAGS + part_tagged(k)))
    yield "bs.raycast:_pierce/entity/exit_key", provider(by_part(lambda k: part_flag(k) * FLAGS + min_(*part_leaves(k)).to_int() * 4 + JOIN))
    yield "bs.raycast:_pierce/shape/leave", provider(fold(max_, lambda i: cond(ordered(i).eq(ctx("hit")), (ctx(f"end{i}").floor_mod(FLAGS) - JOIN) // 4, -1), -1, "shapes"))



def provider(expression: Expression) -> ContextIntProvider:
    return ContextIntProvider(expression.json())


def float_provider(expression: Expression) -> ContextFloatProvider:
    return ContextFloatProvider(expression.json())


def ctx(name: str) -> Expression:
    if name in SHARED:
        return ref(f"bs.raycast:_{name}", "int")
    return score("bs.data", fixed_target(f"#raycast.{name}"))


def ray(name: str) -> Expression:
    """A value of the ray as a float, in a provider of its own."""
    return ref(f"bs.raycast:_{name}")


def bound(box: int, index: int) -> Expression:
    return float_storage("bs.hitbox:get_block", f"out[{box}][{index}]")


def flag(box: int) -> Expression:
    return bound(box, 6).to_int()


def bit(box: int) -> int:
    """The bit of a box in the mask, the first box on the highest bit."""
    return 2 ** (23 - box)


def octants(value: Callable[[int], Expression]) -> Expression:
    """The value for the octant of the ray, so that each box reads the bounds it needs, without a test per axis."""
    return btree(list(range(1, 9)), value, lambda os: ctx("octant").le(max(os)))


def slab(box: int, axis: int, octant: int, enter: bool) -> Expression:
    """The length where the ray crosses a plane of the box, from the next grid length l, the previous one p and the delta d of the axis."""
    a = "xyz"[axis]
    length, delta = ray(f"l{a}"), ray(f"d{a}")
    if (octant - 1) >> axis & 1:
        return length - delta * bound(box, axis + 3 if enter else axis)
    return ray(f"p{a}") + delta * bound(box, axis if enter else axis + 3)


def enters(box: int, octant: int) -> list[Expression]:
    return [slab(box, axis, octant, True) for axis in range(3)]


def leaves(box: int, octant: int) -> list[Expression]:
    return [slab(box, axis, octant, False) for axis in range(3)]


def crossed(box: int, octant: int) -> Condition:
    """Whether the ray goes through the box, ahead of the origin and within the max distance."""
    return max_(*enters(box, octant), 0.0).le(min_(*leaves(box, octant), ray("max")))


def tagged(box: int, octant: int) -> Expression:
    """The entry * 4 + its face axis, axis 3 for an origin inside the box."""
    return max_(*(max_(e, -LONGEST).to_int() * 4 + axis for axis, e in enumerate(enters(box, octant))), 3)


def fold(pick: Callable[..., Expression], term: Callable[[int], Expression], empty: Expression | int, count: str = "boxes") -> Expression:
    """Pick among the first `#raycast.<count>` terms."""
    value = term(BLOCK_BOXES - 1)
    for i in reversed(range(BLOCK_BOXES - 1)):
        value = pick(term(i), cond(ctx(count).ge(i + 2), value, empty))
    return value


def any_box(octant: int) -> Expression:
    """The value of #raycast.max: the stop value as soon as the ray goes through a box, else the max distance it has."""
    value = cond(crossed(BLOCK_BOXES - 1, octant), -(2**31), ctx("max"))
    for k in reversed(range(BLOCK_BOXES - 1)):
        value = cond(crossed(k, octant), -(2**31), cond(ctx("boxes").ge(k + 2), value, ctx("max")))
    return value


def marked(box: int) -> Condition:
    return (ctx("mask") // bit(box)).floor_mod(2).eq(1)


def digit(box: int) -> Expression:
    """1, 32, 1024 or 32768 for the flag 1, 2, 4 or 8: the sum counts the boxes of each flag in base 32."""
    value = bound(box, 6)
    return cond(value.le(2.0), cond(value.le(1.0), 1, 32), cond(value.le(4.0), 1024, 32768))


def flags() -> Expression:
    return add(*(cond((ctx("count") // 32**i).floor_mod(32).ge(1), 2**i, 0) for i in range(4)))


def found(value: int) -> Expression:
    """The flag when a shape has it, 0 otherwise."""
    shape = lambda i: ctx(f"start{i}") // FLAGS  # noqa: E731
    result = cond(shape(BLOCK_BOXES - 1).eq(value), value, 0)
    for i in reversed(range(BLOCK_BOXES - 1)):
        result = cond(shape(i).eq(value), value, cond(ctx("shapes").ge(i + 2), result, 0))
    return result


ENTITY_BOXES = 8


def part(box: int, index: int) -> Expression:
    return float_storage("bs.hitbox:get_entity", f"out[{box}][{index}]")


def part_flag(box: int) -> Expression:
    return part(box, 6).to_int()


def part_slab(box: int, axis: int, enter: bool) -> Expression:
    """The length where the ray crosses a plane of a box of the entity, from the position of the entity relative to the origin."""
    a = "xyz"[axis]
    start, delta = ray(f"offset_{a}"), ray(f"d{a}")
    ahead = (start + part(box, axis if enter else axis + 3)) * delta
    behind = -((start + part(box, axis + 3 if enter else axis)) * delta)
    return cond(ctx(f"u{a}").ge(0), ahead, behind)


def part_leaves(box: int) -> list[Expression]:
    return [part_slab(box, axis, False) for axis in range(3)]


def part_crossed(box: int) -> Condition:
    return max_(*(part_slab(box, axis, True) for axis in range(3)), 0.0).le(min_(*part_leaves(box), ray("max")))


def part_tagged(box: int) -> Expression:
    return max_(*(max_(part_slab(box, axis, True), -LONGEST).to_int() * 4 + axis for axis in range(3)), 3)


def part_fold(pick: Callable[..., Expression], term: Callable[[int], Expression], empty: Expression | int) -> Expression:
    """Pick among the first `#raycast.boxes` boxes of the entity."""
    value = term(ENTITY_BOXES - 1)
    for i in reversed(range(ENTITY_BOXES - 1)):
        value = pick(term(i), cond(ctx("boxes").ge(i + 2), value, empty))
    return value
