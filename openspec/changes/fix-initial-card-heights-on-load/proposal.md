## Why

When entering daily practices, weekly challenges, or minigames for the first time, cards initially render with an inflated box height. This occurs because `get_combined_minimum_size()` is evaluated before Godot completes the layout pass, measuring text wrap height on unconstrained or near-zero widths and setting a massive `custom_minimum_size.y`. Changing font size triggers a re-calculation after layout, which collapses the cards to their proper height.

## What Changes

- Update `update_adaptive_minimum_size()` in `MissionCard` (`mission_card.gd`), `ChallengeCard` (`challenge_card.gd`), and `DropZone` (`drop_zone.gd`) to only measure `get_combined_minimum_size()` when the control has been assigned a valid container width (`size.x > 50`), falling back to compact `base_min_h` when unlaid out.
- Update baseline minimum heights and initial scene dimensions in `ChallengeCard` (`challenge_card.tscn` / `challenge_card.gd`) from 170px to compact 72px.
- Defer initial font scale and height application in `gym.gd` (`_refresh()`) to guarantee it runs after the initial layout pass.

## Capabilities

### New Capabilities
- `dungeons/card-sizing`: Compact baseline sizing and width-aware adaptive height calculations for Gym UI cards.

### Modified Capabilities
<!-- None -->

## Impact

- [`Dungeons/UI/mission_card.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/UI/mission_card.gd)
- [`Dungeons/UI/challenge_card.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/UI/challenge_card.gd)
- [`Dungeons/UI/challenge_card.tscn`](file:///home/arturo/Proyectos/github/stoa/Dungeons/UI/challenge_card.tscn)
- [`Dungeons/Minigames/drop_zone.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/Minigames/drop_zone.gd)
- [`Dungeons/Scripts/gym.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/Scripts/gym.gd)
