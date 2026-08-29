## Context

Card controls were setting `custom_minimum_size.y` during `setup()` or `_ready()` prior to scene tree insertion and container layout assignment. Because `.tscn` files specify default scene sizes (e.g. 560px x 170px), `get_combined_minimum_size()` evaluated at un-placed scene defaults. Additionally, cards lacked a `resized` signal listener, preventing them from updating height when their parent containers actually assigned real screen widths.

## Goals / Non-Goals

**Goals:**
- Add `_last_scale_factor` property and `resized.connect()` listener across `MissionCard`, `ChallengeCard`, `PromptCard`, `DropZone`, and `SituationCard`.
- Guard `get_combined_minimum_size()` in `update_adaptive_minimum_size()` with `is_inside_tree()`.
- Ensure `_open_minigame()` in `gym.gd` and `start()` in `dichotomy_game.gd` trigger deferred font scale / adaptive height updates.

**Non-Goals:**
- Altering minigame game logic or score rules.

## Decisions

- **Decision 1**: Combine `is_inside_tree()` guard with `resized` signal connection on all cards to guarantee adaptive height calculations happen only when laid out in the active scene tree.
