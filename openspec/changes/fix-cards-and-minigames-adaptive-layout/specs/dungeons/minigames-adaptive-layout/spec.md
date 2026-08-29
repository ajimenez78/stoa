## Purpose

Defines reactive, width-aware layout sizing for weekly challenges, minigames, drop zones, and situation cards.

## ADDED Requirements

### Requirement: Tree-aware and resize-reactive minimum height calculation
`MissionCard`, `ChallengeCard`, `PromptCard`, `DropZone`, and `SituationCard` SHALL NOT calculate `get_combined_minimum_size()` when `is_inside_tree()` is false. They SHALL recalculate adaptive minimum height upon receiving the `resized` signal when inside the scene tree.

#### Scenario: Instantiating card before scene tree insertion
- **WHEN** any card control is instantiated (`instantiate()`) or before being added to a container
- **THEN** `custom_minimum_size.y` is set strictly to `base_min_h` without evaluating pre-tree wrap heights

#### Scenario: Container resizing card in layout tree
- **WHEN** the parent container assigns or changes the card's width (`resized` signal)
- **THEN** `update_adaptive_minimum_size()` is automatically called, sizing `custom_minimum_size.y` precisely to `max(base_min_h, content_min_h)` for the allocated layout width

#### Scenario: Opening minigames or spawning situation cards
- **WHEN** a minigame is opened or situation cards are spawned during game play
- **THEN** adaptive heights apply deferred after scene tree insertion, maintaining compact drop zones and situation cards
