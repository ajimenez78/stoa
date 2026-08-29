## Why

In the minigame "Dicotomía de control", situations could not be dragged or played with because `_configure_scroll_pass_through()` in `gym.gd` was recursively setting `mouse_filter = Control.MOUSE_FILTER_IGNORE` on all non-button controls (including `SituationCard` and `DropZone`). Furthermore, drop zones used a semi-translucent background style (`Color(1, 1, 1, 0.28)`) that made drop zones faint and hard to distinguish.

## What Changes

- Remove calling `_configure_scroll_pass_through(game)` on active minigame instances in `_open_minigame()` in `Dungeons/Scripts/gym.gd` so interactive controls retain `MOUSE_FILTER_STOP` or `MOUSE_FILTER_PASS`.
- Ensure `DropZone` and `SituationCard` maintain proper mouse filter settings for drag and drop interactions.
- Update `DropZone` panel style background in `drop_zone.tscn` to a clear, opaque solid color so zones and situations are clearly visible.

## Capabilities

### New Capabilities
- `dungeons/minigames`: Interactive drag-and-drop gameplay and visual presentation for Dicotomía de control.

### Modified Capabilities
<!-- None -->

## Impact

- `Dungeons/Scripts/gym.gd`: `_open_minigame()`.
- `Dungeons/Minigames/drop_zone.tscn`: Background style panel opacity and color.
- `Dungeons/Minigames/dichotomy_game.tscn`: Layout and node hierarchy visibility.
