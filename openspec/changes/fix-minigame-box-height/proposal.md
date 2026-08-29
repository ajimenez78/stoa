## Why

When entering the minigames section or opening a minigame (such as "Dicotomía de control") for the first time, the minigame card or drop zone container uses an unnecessarily large initial default minimum height (92px/84px) or does not apply the active font scale factor immediately upon card instantiation, causing the box to look too tall until font scaling is manually toggled.

## What Changes

- Apply active font scale factor immediately during card instantiation in `_rebuild_minigame_cards()` in `Dungeons/Scripts/gym.gd`.
- Reduce default initial static minimum height in `mission_card.gd` and `drop_zone.gd` so containers tightly wrap content dynamically.
- Call `_apply_font_scale()` upon opening a minigame in `_open_minigame()` to ensure minigame elements calculate adaptive heights instantly on first open.

## Capabilities

### New Capabilities
- `dungeons`: Layout and initial height calculation for minigame cards and game containers in Gym stance.

### Modified Capabilities
<!-- None -->

## Impact

- `Dungeons/Scripts/gym.gd`: `_rebuild_minigame_cards()` and `_open_minigame()`.
- `Dungeons/UI/mission_card.gd`: `update_adaptive_minimum_size()`.
- `Dungeons/Minigames/drop_zone.gd`: `update_adaptive_minimum_size()`.
