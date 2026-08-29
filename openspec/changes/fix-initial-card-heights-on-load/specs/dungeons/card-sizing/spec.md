## Purpose

Defines layout and sizing rules for UI cards across Gym practices, challenges, and minigames.

## ADDED Requirements

### Requirement: Width-aware adaptive minimum height calculation
`MissionCard`, `ChallengeCard`, and `DropZone` SHALL NOT apply pre-layout `get_combined_minimum_size()` height overrides when `size.x <= 50`. In pre-layout state, `custom_minimum_size.y` SHALL default strictly to `base_min_h`.

#### Scenario: Instantiating cards before layout pass
- **WHEN** a `MissionCard`, `ChallengeCard`, or `DropZone` is instantiated and added to a container
- **THEN** `custom_minimum_size.y` is set to `base_min_h` without locking to inflated pre-layout wrap heights

#### Scenario: Recalculating heights after layout pass
- **WHEN** `update_adaptive_minimum_size()` is executed on a card with `size.x > 50`
- **THEN** `custom_minimum_size.y` adapts precisely to `max(base_min_h, content_min_h)`
