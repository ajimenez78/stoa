## Why

When the Gym screen loads in `gym.gd`, `_show_practices()` sets `minigames_panel.visible = false`. Consequently, when deferred font scaling executes during screen initialization, `minigame_grid` is hidden and lacks active layout bounds. When the user switches to the "Mini-juegos" tab for the first time, `minigames_panel` becomes visible, but adaptive minimum heights for minigame cards are not updated until font scale is manually adjusted.

## What Changes

- Update `_show_panel()` in `gym.gd` to trigger `call_deferred("_apply_font_scale")` whenever panel visibility changes.
- Ensures that switching to any tab (including opening the mini-games tab for the first time) immediately recalculates adaptive card heights against newly visible layout container bounds.

## Capabilities

### New Capabilities
- `dungeons/tab-visibility-adaptive-scaling`: Adaptive scaling and card height recalculation upon switching tab panel visibility in Gym.

### Modified Capabilities
<!-- None -->

## Impact

- [`Dungeons/Scripts/gym.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/Scripts/gym.gd)
