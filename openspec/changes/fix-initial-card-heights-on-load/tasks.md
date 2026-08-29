## 1. Width-Aware Card Minimum Heights

- [x] 1.1 Update `update_adaptive_minimum_size()` in `Dungeons/UI/mission_card.gd` to check `size.x > 50` before calculating `content_min_h`.
- [x] 1.2 Update `update_adaptive_minimum_size()` in `Dungeons/UI/challenge_card.gd` to check `size.x > 50` and reduce `base_min_h` to `72 * scale_factor`.
- [x] 1.3 Update `Dungeons/UI/challenge_card.tscn` scene minimum size and `offset_bottom` to 72.
- [x] 1.4 Update `update_adaptive_minimum_size()` in `Dungeons/Minigames/drop_zone.gd` to check `size.x > 50`.
- [x] 1.5 Update `gym.gd` to use `call_deferred("_apply_font_scale")` during `_ready()` and `_refresh()`.

## 2. Verification

- [x] 2.1 Verify project builds cleanly in headless Godot mode with no errors or warnings.
