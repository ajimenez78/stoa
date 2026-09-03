## 1. Stable Adaptive Card Sizing & Font Scale Caching

- [x] 1.1 Update `update_adaptive_minimum_size()` in `Dungeons/UI/mission_card.gd` to estimate viewport layout width when `size.x <= 50`, computing stable `custom_minimum_size.y` before `practice_list` becomes visible.
- [x] 1.2 Update `_cache_base_font_sizes()` in `Dungeons/Scripts/gym.gd` and `Dungeons/Scripts/home.gd` to mathematically recover unscaled base font sizes (`override_size / scale_factor`) when caching controls with existing overrides.
- [x] 1.3 Ensure `_show_practice_list()` in `Dungeons/Scripts/gym.gd` collapses the progress panel and resets `practice_scroll.scroll_vertical = 0`.

## 2. Verification

- [x] 2.1 Verify clean build using Godot Engine v4.7.1 headless runner without GDScript errors.
