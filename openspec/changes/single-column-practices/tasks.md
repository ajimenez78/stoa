## 1. Single Column Layout Updates

- [x] 1.1 Update `Dungeons/Scripts/gym.gd` `_update_responsive_layout()` to set `practice_grid.columns = 1`, `virtue_grid.columns = 1`, and `minigame_grid.columns = 1` unconditionally across all screen widths.
- [x] 1.2 Update `Dungeons/gym.tscn` default grid properties for `VirtueGrid`, `PracticeGrid`, and `MinigameGrid` to `columns = 1`.

## 2. Verification

- [x] 2.1 Run Godot in headless mode and verify project loads cleanly without GDScript errors or warnings.
