## Why

When entering the Gimnasio screen, the progress level header displays stale data ("Nivel 1") until an interactive UI event forces a refresh. Additionally, pressing the toggle progress button (`ToggleProgressButton`) overwrites cached base font sizes with already-scaled values, causing font sizes across the screen to grow exponentially on every toggle or UI refresh.

## What Changes

- Refresh progress data and level labels immediately when entering or displaying the Gimnasio screen so saved user progress ("Nivel 2", etc.) is shown immediately without requiring user interaction.
- Fix `_cache_base_font_sizes()` in `Dungeons/Scripts/gym.gd` (and `Dungeons/Scripts/home.gd`) so it caches unscaled base font sizes strictly once per control and never overwrites them with already-scaled font sizes.
- Ensure toggle progress button presses preserve exact font scaling levels without compounding growth.

## Capabilities

### New Capabilities

- `gym/level-data-and-font-scaling`: Correct data loading and idempotent font size scaling for the Gimnasio screen and toggle controls.

### Modified Capabilities

None.

## Impact

- `Dungeons/Scripts/gym.gd`: Progress refresh lifecycle and base font size caching logic.
- `Dungeons/Scripts/home.gd`: Guard against re-caching scaled base font sizes.
