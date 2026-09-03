## Context

In `Dungeons/gym.tscn`, `UI/Layout/Column/Progress` contains `Header/LevelLabel`, `LevelRow` (with `LevelBar` and `LevelHintLabel`), and `VirtueGrid`. When font size increases, the entire progress panel expands vertically. See `proposal.md` for motivation.

## Goals / Non-Goals

**Goals:**
- Add a toggle button (`ToggleProgressButton` / `%ToggleProgressButton`) in `UI/Layout/Column/Progress/Margin/Column/Header/`.
- Toggling controls visibility of `virtue_grid` and `level_hint_label` (or `LevelRow` hint text).
- Update button icon/text between `▲` (expanded) and `▼` (collapsed).
- Ensure `_apply_font_scale()` caches font sizes for the new toggle button and updates font scale cleanly.

**Non-Goals:**
- Changing minigame gameplay layouts or altering core `ProgressStore` level mechanics.

## Decisions

- **Decision**: Toggle visibility of `virtue_grid` and `level_hint_label` when clicking `ToggleProgressButton`.
  - Expanded: `virtue_grid.visible = true`, `level_hint_label.visible = true`, button label `▲`
  - Collapsed: `virtue_grid.visible = false`, `level_hint_label.visible = false`, button label `▼`
- **Rationale**: Keeps `LevelLabel` and `LevelBar` always visible as a compact summary while hiding the bulky 2x2 grid and hint label to free ~150-200px of vertical space.

## Risks / Trade-offs

- [Risk] Layout recalculation after toggling → Mitigation: Call `call_deferred("_apply_font_scale")` or allow VBoxContainer autolayout to resize the content scroll container immediately.
