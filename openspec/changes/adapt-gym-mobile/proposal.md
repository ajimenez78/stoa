## Why

Following the successful mobile view adaptation of the Stoa and Home stances, the Gym (Gimnasio) stance requires the same mobile adaptations. On mobile devices, text legibility needs to be user-configurable, touch drag gestures over cards and containers must pass through smoothly to the scroll view, and multi-column grids must adjust to single-column layouts for small screen sizes.

## What Changes

- **Top Controls & Dynamic Font Scaling**: Add `TopControlsPanel` with `A-` / `A+` buttons for configurable font scaling (from 0.85x to 2.0x). Automatically default to scale index 3 (1.4x) on mobile/touchscreen devices and scale index 1 (1.0x) on desktop.
- **Touch Drag Scroll Pass-Through**: Configure `mouse_filter` recursively across all containers, cards, virtue meters, and detail views (`MOUSE_FILTER_PASS` on buttons, `MOUSE_FILTER_IGNORE` on containers/labels) so vertical touch drag gestures pass directly to `ScrollContainer`.
- **Responsive Mobile Layout**: Dynamically adapt `virtue_grid`, `practice_grid`, and `minigame_grid` to single-column layouts on small screens (`viewport_width < 600px`).
- **Enhanced Mobile Legibility & Card Opacity**: Increase panel and card background opacity for higher contrast on mobile devices, and ensure card containers scale height dynamically to prevent text overflow.

## Capabilities

### New Capabilities
- `adapt-gym-mobile`: Adapt the Gym stance interface for mobile screens, including dynamic font scaling, single-column responsive grids, touch drag pass-through, and enhanced card contrast.

### Modified Capabilities
<!-- None -->

## Impact

- `Dungeons/gym.tscn`: Add top controls panel, update layout margins and scroll container structures.
- `Dungeons/Scripts/gym.gd`: Add font scale index logic, touch pass-through configuration, and responsive layout updates.
- `Dungeons/UI/mission_card.tscn`, `Dungeons/UI/challenge_card.tscn`, `Dungeons/UI/virtue_meter.tscn`: Ensure mouse filter pass-through and height scaling.
