## Context

In Gym (`Dungeons/Scripts/gym.gd` and `Dungeons/gym.tscn`), top-level controls (`TopControlsPanel`, `Hero`, `ProgressPanel`, `Tabs`) reside inside a single vertical `VBoxContainer` (`UI/Layout/Column`). When font scale increases (e.g. 1.4 - 2.0), the cumulative minimum height of all top elements expands dramatically. Inside `_show_practice_detail()`, `_collapse_progress_panel()` was not being invoked, leaving `ProgressPanel` fully expanded alongside `PracticeDetailScroll`.

Furthermore, `_apply_font_scale()` applied `"font_size"` theme overrides to controls, but `RichTextLabel` (`StepsLabel`) ignores `"font_size"` and instead uses `"normal_font_size"` and `"bold_font_size"`.

## Goals / Non-Goals

**Goals:**
- Automatically collapse `ProgressPanel` when opening `PracticeDetail` in `_show_practice_detail()`.
- Add `RichTextLabel` handling in `_apply_font_scale()` to scale `"normal_font_size"` and `"bold_font_size"` overrides.
- Ensure top containers (`Hero`, `TopControlsPanel`, `Tabs`) maintain responsive height constraints and do not overflow `UI/Layout/Column`.

**Non-Goals:**
- Altering the visual design or color theme of Gym controls.
- Refactoring the entire Gym scene tree outside of font scale and container sizing management.

## Decisions

### Decision 1: Collapse Progress Panel in `_show_practice_detail()`
When navigating into practice instructions, call `_collapse_progress_panel()` so `ProgressPanel` occupies minimal height (~40px instead of ~140px+), leaving maximum vertical space for `PracticeDetailScroll`.

### Decision 2: Handle `RichTextLabel` Font Scaling
In `_apply_font_scale()`, detect if `control is RichTextLabel`:
- Scale `"normal_font_size"` and `"bold_font_size"` overrides from base font sizes.
- Re-trigger BBCode layout recalculation so `StepsLabel` wraps correctly inside `PracticeDetailScroll`.

### Decision 3: Ensure Scroll Container Flexing
Ensure `PracticeDetailScroll` has `size_flags_vertical = Control.SIZE_EXPAND_FILL` and `horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED` so overflow stays strictly internal to the scroll container.

## Risks / Trade-offs

- **[Risk]** `RichTextLabel` base font size caching could pick up dynamic overrides.
  - **Mitigation**: Cache initial `normal_font_size` and `bold_font_size` in `_base_font_sizes` dictionary under specific property keys or dedicated metadata.
