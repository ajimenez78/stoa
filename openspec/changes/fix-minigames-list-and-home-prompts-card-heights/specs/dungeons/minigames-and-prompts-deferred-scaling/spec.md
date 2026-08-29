## Purpose

Defines deferred scaling and adaptive layout timing for the minigames list grid in the gym and the prompt cards grid on the home screen.

## ADDED Requirements

### Requirement: Deferred font scale application after container layout pass
`_rebuild_minigame_cards()` in `gym.gd` and `_build_prompt_cards()` in `home.gd` SHALL defer `_apply_font_scale()` execution using `call_deferred("_apply_font_scale")`.

#### Scenario: Building minigame card grid in Gym
- **WHEN** `_rebuild_minigame_cards()` instantiates minigame `MissionCard` instances into `minigame_grid`
- **THEN** font scale application and height calculations execute deferred after `minigame_grid` completes container width layout

#### Scenario: Building prompt cards in Home screen
- **WHEN** `_build_prompt_cards()` instantiates `PromptCard` instances into `prompt_grid`
- **THEN** font scale application and height calculations execute deferred after `prompt_grid` completes container width layout
