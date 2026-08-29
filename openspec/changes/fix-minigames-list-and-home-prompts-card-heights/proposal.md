## Why

In `gym.gd` and `home.gd`, `_rebuild_minigame_cards()` and `_build_prompt_cards()` invoke `_apply_font_scale()` synchronously right after adding instantiated cards to `minigame_grid` and `prompt_grid`. At the moment `add_child()` completes, the cards are in the scene tree but the grid containers have not yet executed their layout pass. Consequently, `_apply_font_scale()` evaluates card heights using pre-layout scene default widths (e.g. 560px), inflating box minimum heights on initial load.

## What Changes

- Update `_rebuild_minigame_cards()` in `gym.gd` to use `call_deferred("_apply_font_scale")` instead of calling `_apply_font_scale()` synchronously.
- Update `_build_prompt_cards()` in `home.gd` to use `call_deferred("_apply_font_scale")` instead of calling `_apply_font_scale()` synchronously.
- Ensure all grid/list card generation passes defer font scaling and height calculations until grid layout allocation is complete.

## Capabilities

### New Capabilities
- `dungeons/minigames-and-prompts-deferred-scaling`: Deferred font scale and height calculation for minigame card list and home prompt cards.

### Modified Capabilities
<!-- None -->

## Impact

- [`Dungeons/Scripts/gym.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/Scripts/gym.gd)
- [`Dungeons/Scripts/home.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/Scripts/home.gd)
