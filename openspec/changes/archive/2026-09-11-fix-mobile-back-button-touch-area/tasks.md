## 1. Scene Configuration & Layout

- [x] 1.1 Reconfigure `$TouchControls/BackButton` transform and size properties in `Apprentice/apprentice.tscn` (`custom_minimum_size = Vector2(64, 64)`, `offset_left = 32.0`, `offset_top = 18.0`, `offset_right = 96.0`, `offset_bottom = 82.0`) and verify scene node properties.
- [x] 1.2 Add `StyleBoxFlat` theme overrides for normal, hover, pressed, and focus states on `$TouchControls/BackButton` in `Apprentice/apprentice.tscn` to match Gym glass styling (`bg_color = Color(0.96, 0.96, 0.94, 0.62)`, `corner_radius = 8`).

## 2. Touch Interaction & Verification

- [x] 2.1 Verify `Apprentice/Scripts/apprentice.gd` touch controls visibility logic (`_update_touch_controls()`) operates cleanly with the updated button dimensions and path `$TouchControls/BackButton`.
- [x] 2.2 Verify Godot project builds cleanly without scene syntax errors or missing resource warnings.
