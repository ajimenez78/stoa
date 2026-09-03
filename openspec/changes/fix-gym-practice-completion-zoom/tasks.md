## 1. Unscaled Font Caching Implementation

- [x] 1.1 Update `_cache_base_font_sizes()` in `Dungeons/Scripts/gym.gd` and `Dungeons/Scripts/home.gd` to clear `font_size` theme overrides before reading base font sizes, preventing compounding font scale zoom.
- [x] 1.2 Export `practice_scroll` in `Dungeons/Scripts/gym.gd` and update `_show_practice_list()` to reset `practice_scroll.scroll_vertical = 0` when returning to practice list view.

## 2. Verification

- [x] 2.1 Verify clean build using Godot Engine v4.7.1 headless runner without GDScript errors.
