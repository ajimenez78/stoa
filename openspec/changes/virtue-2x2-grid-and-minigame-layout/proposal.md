## Why

The virtue progress box (`VirtueGrid`) in the Gym header currently displays the 4 stoic virtues in a single column (4 vertical rows), consuming significant vertical space on smaller mobile screens. This compresses the available area for minigames like "Dicotomía de control", making drop zones crowded and reducing space for situation cards.

## What Changes

- Configure `VirtueGrid` to use a 2x2 grid matrix (`columns = 2`) in both [`Dungeons/gym.tscn`](file:///home/arturo/Proyectos/github/stoa/Dungeons/gym.tscn) and [`Dungeons/Scripts/gym.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/Scripts/gym.gd), halving the vertical footprint of the virtue progress box.
- Preserve single-column layout for `practice_grid` and `minigame_grid`.

## Capabilities

### New Capabilities
- `dungeons/layout`: 2x2 virtue grid layout in Gym header for compact vertical presentation.

### Modified Capabilities
<!-- None -->

## Impact

- [`Dungeons/Scripts/gym.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/Scripts/gym.gd): `_update_responsive_layout()`.
- [`Dungeons/gym.tscn`](file:///home/arturo/Proyectos/github/stoa/Dungeons/gym.tscn): `VirtueGrid` default columns count.
