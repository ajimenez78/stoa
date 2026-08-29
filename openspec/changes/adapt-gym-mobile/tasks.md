## 1. Top Controls & Layout Scene Updates

- [x] 1.1 Add `TopControlsPanel` with font scaling buttons (`font_decrease_button`, `font_increase_button`, `font_scale_label`) to `Dungeons/gym.tscn` and verify nodes exist.
- [x] 1.2 Update `mouse_filter` properties across `Dungeons/gym.tscn`, `Dungeons/UI/mission_card.tscn`, `Dungeons/UI/challenge_card.tscn`, and `Dungeons/UI/virtue_meter.tscn` to enable touch pass-through.

## 2. Dynamic Font Scaling & Touch Pass-Through

- [x] 2.1 Implement `_init_font_scale_index()`, `_cache_base_font_sizes()`, and `_apply_font_scale()` in `Dungeons/Scripts/gym.gd` and connect controls.
- [x] 2.2 Implement `_configure_scroll_pass_through()` in `gym.gd` and apply recursively to `ScrollContainer` and dynamically instantiated card instances.

## 3. Responsive Layout Adjustments

- [x] 3.1 Implement `_update_responsive_layout()` in `gym.gd` to reconfigure `virtue_grid`, `practice_grid`, and `minigame_grid` to 1 column on screens < 600px.

## 4. Verification & Testing

- [x] 4.1 Run Godot headless verification test to confirm clean loading of `Dungeons/gym.tscn` without GDScript errors or warnings.
