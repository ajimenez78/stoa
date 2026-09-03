## 1. Practice Detail Progress Panel & Font Scaling

- [x] 1.1 Update `_show_practice_detail()` in `Dungeons/Scripts/gym.gd` to invoke `_collapse_progress_panel()`, ensuring top vertical space stays compact when viewing practice instructions.
- [x] 1.2 Update `_cache_base_font_sizes()` and `_apply_font_scale()` in `Dungeons/Scripts/gym.gd` to support `RichTextLabel` font size overrides (`normal_font_size` and `bold_font_size`).
- [x] 1.3 Ensure `PracticeDetailScroll` in `Dungeons/gym.tscn` expands cleanly with `SCROLL_MODE_DISABLED` on horizontal scroll and `SIZE_EXPAND_FILL` on vertical flags.

## 2. Verification

- [x] 2.1 Verify clean GDScript compilation using Godot Engine v4.7.1 headless runner.
