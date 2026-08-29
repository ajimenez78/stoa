## Context

Currently, `update_adaptive_minimum_size()` calls `margin.get_combined_minimum_size().y` unconditionally when cards are instantiated. Before Godot calculates container widths, `get_combined_minimum_size().y` evaluates text wrapping as if width were ~0, producing inflated values (e.g. 200px - 400px) that get assigned to `custom_minimum_size.y`. Containers then lock the cards to these excessive heights.

## Goals / Non-Goals

**Goals:**
- Guard `get_combined_minimum_size().y` in `mission_card.gd`, `challenge_card.gd`, and `drop_zone.gd` with a check for `size.x > 50`.
- Update `ChallengeCard` `base_min_h` to `72 * scale_factor` (down from 170) and scene `offset_bottom` to 72.
- Execute `_apply_font_scale()` via `call_deferred` after `_refresh()` in `gym.gd` to guarantee container layout sizes are resolved before scaling.

**Non-Goals:**
- Modifying game logic or completion mechanics.

## Decisions

- **Decision 1**: Guard `get_combined_minimum_size()` evaluation behind `size.x > 50`. When `size.x <= 50`, `custom_minimum_size.y = base_min_h`.

## Risks / Trade-offs

- None identified.
