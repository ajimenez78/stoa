## 1. Reactive Card Sizing Implementation

- [x] 1.1 Update `MissionCard` (`mission_card.gd`) to track `_last_scale_factor`, connect `resized` in `_ready()`, and require `is_inside_tree()` in `update_adaptive_minimum_size()`.
- [x] 1.2 Update `ChallengeCard` (`challenge_card.gd`) to track `_last_scale_factor`, connect `resized` in `_ready()`, and require `is_inside_tree()` in `update_adaptive_minimum_size()`.
- [x] 1.3 Update `PromptCard` (`prompt_card.gd`) to track `_last_scale_factor`, connect `resized` in `_ready()`, and require `is_inside_tree()` in `update_adaptive_minimum_size()`.
- [x] 1.4 Update `DropZone` (`drop_zone.gd`) to track `_last_scale_factor`, connect `resized` in `_ready()`, and require `is_inside_tree()` in `update_adaptive_minimum_size()`.
- [x] 1.5 Update `SituationCard` (`situation_card.gd`) to track `_last_scale_factor`, connect `resized` in `_ready()`, and require `is_inside_tree()` in `update_adaptive_minimum_size()`.
- [x] 1.6 Update `_open_minigame()` in `gym.gd` and `start()` in `dichotomy_game.gd` to defer scaling/layout calls after scene tree insertion.

## 2. Verification

- [x] 2.1 Verify project builds cleanly in headless Godot mode with no errors or warnings.
