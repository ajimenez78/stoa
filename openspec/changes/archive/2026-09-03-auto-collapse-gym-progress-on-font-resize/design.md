## Context

See `proposal.md` for context.
Currently in `Dungeons/Scripts/gym.gd`, `_on_font_increase_pressed()` and `_on_font_decrease_pressed()` update `_current_scale_index` and call `_apply_font_scale()`. They do not touch `_progress_expanded` or the visibility of `virtue_grid` and `level_hint_label`.

## Goals / Non-Goals

**Goals:**
- Automatically set `_progress_expanded = false` and update header visibility when font scaling buttons (`_on_font_increase_pressed` or `_on_font_decrease_pressed`) are triggered if `_progress_expanded` is `true`.
- Helper function `_collapse_progress_panel()` to keep UI state consistent.

**Non-Goals:**
- Changing automatic font scale initialization index.
- Automatically re-expanding progress panel when decreasing font size.

## Decisions

### Decision 1: Dedicated `_collapse_progress_panel()` Helper
- **Choice**: Extract collapse logic into `_collapse_progress_panel()`.
- **Rationale**: Keeps `_on_toggle_progress_pressed()`, `_on_font_increase_pressed()`, and `_on_font_decrease_pressed()` clean, readable, and consistent.

```gdscript
func _collapse_progress_panel() -> void:
	if not _progress_expanded:
		return
	_progress_expanded = false
	if virtue_grid:
		virtue_grid.visible = false
	if level_hint_label:
		level_hint_label.visible = false
	if toggle_progress_button:
		toggle_progress_button.text = " ▼ "
```

## Risks / Trade-offs

- **[Risk]** User might be surprised when progress panel collapses upon changing font size.
  - **Mitigation**: The toggle button indicator updates to `▼`, allowing one-click re-expansion at any time.
