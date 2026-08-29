## Context

Previously, `_rebuild_minigame_cards()` in `Dungeons/Scripts/gym.gd` created `MissionCard` instances and called `card.setup_minigame(...)`. `setup_minigame()` called `update_adaptive_minimum_size()` with the default `scale_factor = 1.0` and a hardcoded base height of 92px. On mobile devices where `_current_scale_index` defaults to 3 (`1.4x`), cards were instantiated with unscaled base heights until `_apply_font_scale()` was manually triggered. Additionally, `DropZone` had a default `base_min_h = 84px`, making "Dicotomía de control" boxes excessively tall when initially rendered.

## Goals / Non-Goals

**Goals:**
- Update `_rebuild_minigame_cards()` and `_open_minigame()` in `gym.gd` to pass the active font scale factor (`_font_scales[_current_scale_index]`) during card setup and minigame launch.
- Adjust base minimum height baseline in `drop_zone.gd` from 84px to 48px and in `mission_card.gd` from 92px to 60px so containers tightly fit content on first render.

**Non-Goals:**
- Changing minigame gameplay logic or scoring.

## Decisions

- **Decision 1: Immediate active scale propagation**:
  - In `gym.gd`: After `_rebuild_minigame_cards()` finishes adding cards, call `_update_card_heights(_font_scales[_current_scale_index])` and `_apply_font_scale()`.
  - In `_open_minigame()`: Call `_apply_font_scale()` after adding the minigame instance to `minigame_host`.
- **Decision 2: Compact baseline heights**:
  - Update `drop_zone.gd` base minimum height to `48 * scale_factor` (so empty drop zones aren't artificially tall).
  - Update `mission_card.gd` base minimum height to `60 * scale_factor` for minigame cards.

## Risks / Trade-offs

- None identified.
