## 1. UI & Scene Setup

- [x] 1.1 Update `Dungeons/gym.tscn` to add a toggle button (`ToggleProgressButton`) in the Header of the Progress Panel and connect its node path.

## 2. Logic & Script Implementation

- [x] 2.1 Update `Dungeons/Scripts/gym.gd` to add `@export var toggle_progress_button: Button` (or `%ToggleProgressButton`), connect its `pressed` signal to a `_on_toggle_progress_pressed()` handler.
- [x] 2.2 Implement toggle state in `gym.gd` to switch `virtue_grid.visible` and `level_hint_label.visible` between `true` and `false`, updating the toggle button indicator (`▲` vs `▼`).

## 3. Verification

- [x] 3.1 Verify `project.godot` builds and runs cleanly in headless Godot mode with zero GDScript errors or warnings.
