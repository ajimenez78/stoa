## Context

The Gym (Gimnasio) stance (`gym.tscn` and `gym.gd`) currently displays level progress, virtue meters, daily practices, weekly challenges, and minigames using desktop-oriented multi-column grids and fixed font sizes. See `proposal.md` for motivation.

## Goals / Non-Goals

**Goals:**
- Add top controls panel with `A-` / `A+` buttons and a scale label to `gym.tscn`.
- Implement dynamic font scaling in `gym.gd` supporting `FONT_SCALES = [0.85, 1.0, 1.2, 1.4, 1.6, 1.8, 2.0]`.
- Detect mobile devices (`OS.has_feature("mobile")`, `DisplayServer.is_touchscreen_available()`, or viewport width < 600px) to set initial scale index to 3 (1.4x).
- Implement recursive `_configure_scroll_pass_through()` setting `mouse_filter = MOUSE_FILTER_PASS` on buttons and `MOUSE_FILTER_IGNORE` on containers.
- Reconfigure `virtue_grid`, `practice_grid`, and `minigame_grid` to 1 column on viewports under 600px in `_update_responsive_layout()`.

**Non-Goals:**
- Modifying minigame gameplay logic or rules.
- Redesigning the underlying data structures in `gym_missions.json`.

## Decisions

1. **TopControlsPanel Structure**: Insert `TopControlsPanel` in `gym.tscn` at the top of the main `ScrollContainer/Column`, copying the structure and theme styling used in `home.tscn` and `stoa.tscn`.
2. **Font Scale Management**: Cache base font sizes across all controls in `gym.gd` via `_cache_base_font_sizes()` and apply scale adjustments via `_apply_font_scale()`. Re-apply font scaling whenever cards are rebuilt dynamically.
3. **Touch Event Pass-Through**: Call `_configure_scroll_pass_through()` on the `ScrollContainer` root in `_ready()` and on individual card instances when instantiated in `_rebuild_practice_cards()`, `_rebuild_challenge_cards()`, `_rebuild_minigame_cards()`, and `_build_virtue_meters()`.

## Risks / Trade-offs

- [Risk] Larger font scale factors (e.g. 1.8x, 2.0x) causing text wrapping overflow on mission cards → [Mitigation] Ensure card containers have flexible vertical size flags (`SIZE_EXPAND_FILL`) and text labels enable autowrap.
