## Why

When users increase the font size in the Gimnasio screen, vertical screen real estate for content cards (practices, challenges, minigames) becomes constrained. Automatically collapsing the progress panel on the first font size change eliminates manual friction and immediately optimizes viewport space for reading and interacting.

## What Changes

- Automatically collapse the progress panel when the user changes font scale for the first time in Gimnasio if the panel is currently expanded.
- Update the toggle button text indicator (`▼`) and state flags accordingly.
- Keep manual toggle controls available so the user can re-expand the progress panel at any time.

## Capabilities

### New Capabilities

- `gym/auto-collapse-progress-on-font-change`: Automatic collapsing behavior of the Gimnasio progress panel upon font size adjustments.

### Modified Capabilities

None.

## Impact

- `Dungeons/Scripts/gym.gd`: Font scaling press handlers (`_on_font_increase_pressed`, `_on_font_decrease_pressed`).
