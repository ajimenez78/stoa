## Why

Weekly challenge cards, minigame cards, and dichotomy minigame elements (drop zones and situation cards) continue to render with inflated box heights on initial load. This happens because cards evaluate `get_combined_minimum_size()` upon instantiation when `is_inside_tree()` is false or before container layout pass, reading scene default widths (e.g. 560px) rather than actual container layout widths. Furthermore, no listener re-evaluates adaptive heights upon node resize (`resized` signal), causing box heights to lock until a font size change manually forces a scale re-application.

## What Changes

- Update `update_adaptive_minimum_size()` across all cards (`MissionCard`, `ChallengeCard`, `PromptCard`, `DropZone`, `SituationCard`) to require `is_inside_tree()` and active container layout before calculating content minimum heights, defaulting to compact `base_min_h` otherwise.
- Connect the `resized` signal in `_ready()` on all card types so adaptive heights automatically recalculate whenever the container assigns or updates actual layout width.
- Ensure `_open_minigame()` and `_rebuild_minigame_cards()` in `gym.gd` trigger `call_deferred("_apply_font_scale")` after minigames and situation cards are added to the scene tree.
- Reduce default initial scene dimensions and baseline heights in `.tscn` files (`challenge_card.tscn`, `mission_card.tscn`, `drop_zone.tscn`, `situation_card.tscn`) to compact defaults.

## Capabilities

### New Capabilities
- `dungeons/minigames-adaptive-layout`: Reactive, width-aware layout sizing for weekly challenges, minigames, drop zones, and situation cards.

### Modified Capabilities
<!-- None -->

## Impact

- [`Dungeons/UI/mission_card.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/UI/mission_card.gd)
- [`Dungeons/UI/challenge_card.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/UI/challenge_card.gd)
- [`Dungeons/UI/prompt_card.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/UI/prompt_card.gd)
- [`Dungeons/Minigames/drop_zone.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/Minigames/drop_zone.gd)
- [`Dungeons/Minigames/situation_card.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/Minigames/situation_card.gd)
- [`Dungeons/Minigames/dichotomy_game.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/Minigames/dichotomy_game.gd)
- [`Dungeons/Scripts/gym.gd`](file:///home/arturo/Proyectos/github/stoa/Dungeons/Scripts/gym.gd)
