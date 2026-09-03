## 1. Gym Progress Lifecycle Data Refresh

- [x] 1.1 Update `Dungeons/Scripts/gym.gd` to reload progress data and refresh UI (`_progress = ProgressStore.load_progress()` and `_refresh()`) when entering the scene / becoming visible.

## 2. Guarded Base Font Size Caching

- [x] 2.1 Update `_cache_base_font_sizes()` in `Dungeons/Scripts/gym.gd` to check `if not _base_font_sizes.has(child):` before reading `get_theme_font_size("font_size")`, ensuring base font sizes are cached strictly once per control and never overwritten with scaled sizes.
- [x] 2.2 Update `_cache_base_font_sizes()` in `Dungeons/Scripts/home.gd` to apply the same `if not _base_font_sizes.has(child):` guard.

## 3. Verification

- [x] 3.1 Verify headless Godot build and run clean execution without errors or warnings.
