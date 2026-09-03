## Why

When viewing the description, steps, and completion details for a daily practice in the Gimnasio screen, the content currently overflows off the bottom of the screen without a scroll container, making lower sections (like action buttons or long practice steps) unscrollable and unreachable on smaller screens or larger font sizes.

## What Changes

- Wrap the practice detail content inside a `ScrollContainer` in `Dungeons/gym.tscn`.
- Ensure mouse scroll pass-through and touch drag scrolling work seamlessly in the practice detail view.

## Capabilities

### New Capabilities

- `gym/scrollable-practice-detail`: Enables scrolling for practice detail descriptions and action steps in the Gimnasio screen.

### Modified Capabilities

None.

## Impact

- `Dungeons/gym.tscn`: Node hierarchy for `PracticeDetail`.
- `Dungeons/Scripts/gym.gd`: Pass-through touch configuration and node path references if necessary.
