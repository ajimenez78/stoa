## 1. Minigame Card & Container Height Adjustments

- [x] 1.1 Update `Dungeons/Minigames/drop_zone.gd` `update_adaptive_minimum_size()` to use a compact base minimum height (`48 * scale_factor`).
- [x] 1.2 Update `Dungeons/UI/mission_card.gd` `update_adaptive_minimum_size()` to use a compact base minimum height (`60 * scale_factor`).
- [x] 1.3 Update `Dungeons/Scripts/gym.gd` `_rebuild_minigame_cards()` and `_open_minigame()` to trigger active font scale application immediately upon card instantiation and minigame launch.

## 2. Verification

- [x] 2.1 Run Godot in headless mode and verify project loads cleanly without GDScript errors or warnings.
