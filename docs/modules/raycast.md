# 🔦 Raycast

**`#bs.raycast:help`**

Cast rays and detect collisions with blocks or entities.

```{note}
Unlike traditional raycasts, this module uses a [voxel traversal algorithm](http://www.cse.yorku.ca/~amana/research/grid.pdf) which provides much greater precision. Additionally, thanks to the `bs.hitbox` module, it supports all different hitbox types, including both blocks and entities.
```

```{epigraph}
"Reality only reveals itself when it is illuminated by a ray of poetry."

-- Georges Braque
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Run the Raycast

```{function} #bs.raycast:run {with:{}}

Cast a ray from the execution position and check if it hits something.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z> rotated <rot>`**: Origin of the ray.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`compound` **with**: Ray input data.
      - {nbt}`bool` **blocks**: Whether the ray should stop on blocks (default: true).
      - {nbt}`bool` {nbt}`string` **entities**: Whether the ray should stop on entities (default: false). Can also be a required entity tag.
      - {nbt}`int` **piercing**: Number of blocks or entities the ray can pass through (default: 0).
      - {nbt}`number` **max_distance**: Maximum ray travel distance (default: 16.0).
      - {nbt}`string` **hitbox_shape**: Hitbox type: `interaction` or `collision` (default: `interaction`).
      - {nbt}`string` **ignored_blocks**: Blocks to ignore (default: `#bs.hitbox:intangible`).
      - {nbt}`string` **ignored_entities**: Entities to ignore (default: `#bs.hitbox:intangible`).
      - {nbt}`string` **on_hit_point**: Command to run at the exact point where the ray makes contact.
      - {nbt}`string` **on_targeted_block**: Command to run at the block hit by the ray.
      - {nbt}`string` **on_targeted_entity**: Command to run as and at the entity hit by the ray.
  :::

:Lambdas:
  **Score `$raycast.piercing bs.lambda`**: The remaining number of blocks or entities the ray can pass through before stopping. This score can be dynamically updated inside callbacks (`on_*`) to modify ray behavior.

  **Storage `bs:lambda raycast`**:
  :::{treeview}
  - {nbt}`compound` Ray lambda data, accessible only in callbacks (`on_*`)
    - {nbt}`double` **distance**: The distance from the ray's origin to the impact point.
    - {nbt}`list` **hit_point**: The coordinates of the impact point.
    - {nbt}`list` **hit_normal**: The normal of the surface the ray hits.
    - {nbt}`list` **targeted_block**: The coordinates of the block that was hit.
    - {nbt}`list` **targeted_entity**: The UUID array of the entity that was hit.
  :::

:Outputs:
  **Return**: Whether the ray collides with a hitbox or not (1 or 0).

  **Storage `bs:out raycast`**:
  :::{treeview}
  - {nbt}`compound` Ray output data
    - {nbt}`double` **distance**: The distance from the ray's origin to the impact point.
    - {nbt}`list` **hit_point**: The coordinates of the impact point.
    - {nbt}`list` **hit_normal**: The normal of the surface the ray hit.
    - {nbt}`list` **targeted_block**: The coordinates of the block that was hit.
    - {nbt}`list` **targeted_entity**: The UUID array of the entity that was hit.
  :::
```

```{admonition} Collision / Interaction Shape
:class: info
- **Collision Shape**: Defines the physical boundaries of a block that entities cannot pass through. It determines where an entity will stop when moving towards the block.
- **Interaction Shape**: Defines the area where the player can interact with or break the block. This includes actions such as right-clicking to open a GUI (e.g., chests, furnaces) or mining the block. Some blocks have an interaction shape but no collision, such as crops or scaffolding.
```

*Example: Cast a ray from your eyes and detect any collisions:*

```mcfunction
# Once (returns 0 if no collision occurred)
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:run {with:{}}

# If a collision occurred, see the collision point
data get storage bs:out raycast.hit_point
```

> **Credits**: Aksiome

---

```{include} ../_templates/comments.md
```
