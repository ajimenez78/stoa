# dungeons/tab-visibility-adaptive-scaling

## Purpose

Defines adaptive layout recalculation triggered by tab panel visibility changes in Gym.

## Requirements

### Requirement: Recalculate adaptive heights on panel visibility change
`_show_panel()` in `gym.gd` SHALL invoke `call_deferred("_apply_font_scale")` whenever a panel is selected.

#### Scenario: Switching to mini-games tab for the first time
- **WHEN** the user selects the "Mini-juegos" tab (`_show_minigames()`)
- **THEN** `_show_panel()` displays `minigames_panel` and triggers `call_deferred("_apply_font_scale")`, updating `minigame_grid` card heights for the visible container width
