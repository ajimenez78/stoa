## Why

When users increase font size in the Gym screen (especially after viewing a practice description), all labels and containers scale up. Because top-level components (`TopControlsPanel`, `Hero`, `ProgressPanel`, `Tabs`) are placed inside a fixed vertical column (`UI/Layout/Column`), scaling their font sizes causes their cumulative height to exceed the viewport, resulting in container overflow and content being pushed off-screen.

## What Changes

- Ensure `ProgressPanel` is automatically collapsed when viewing a practice description (`_show_practice_detail`), preventing top-heavy vertical space consumption.
- Limit max vertical space consumption for top decorative header elements (`Hero`) at high font scales so main content containers retain room inside the viewport.
- Support `RichTextLabel` font size scaling in `_apply_font_scale()` by overriding `"normal_font_size"` and `"bold_font_size"`.
- Ensure all scroll containers in `Gym` (`PracticeScroll`, `PracticeDetailScroll`, `ChallengeScroll`, `MinigameScroll`) flex cleanly within viewport boundaries without pushing parent containers past screen limits.

## Capabilities

### New Capabilities
- `gym/font-scale-layout`: Defines layout responsiveness and container overflow prevention under scaled font sizes across list and detail views in Gym.

### Modified Capabilities

## Impact

- `Dungeons/Scripts/gym.gd`
- `Dungeons/UI/mission_card.gd`
- `Dungeons/gym.tscn`
