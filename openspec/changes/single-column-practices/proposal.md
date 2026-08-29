## Why

In the Gimnasio Estoico (Gym stance), daily practices, virtue meters, and minigames were previously displayed in a 2-column grid layout on wider screens. However, two-column layouts cause text cramming and narrow cards for practices with longer descriptions or larger font scaling, whereas a single-column layout gives each practice full width and optimal readability across all screen sizes.

## What Changes

- Update `Dungeons/Scripts/gym.gd` layout configuration to set `practice_grid`, `virtue_grid`, and `minigame_grid` columns permanently to 1 column regardless of screen width.
- Adjust `_update_responsive_layout()` to ensure single-column distribution across all viewports.
- Update `Dungeons/gym.tscn` grid default properties to 1 column.

## Capabilities

### New Capabilities
- `dungeons`: Layout and display rules for stances in Stoa, ensuring single-column layout for practices, virtues, and minigames in the Gym.

### Modified Capabilities
<!-- None -->

## Impact

- `Dungeons/gym.tscn`: Default column count for grid containers.
- `Dungeons/Scripts/gym.gd`: `_update_responsive_layout()`, `_ready()`, and grid instantiation logic.
