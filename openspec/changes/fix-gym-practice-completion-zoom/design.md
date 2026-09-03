## Context

See proposal.md - Why.

When cards or UI components in `gym.gd` and `home.gd` are re-cached or re-instantiated, `_cache_base_font_sizes()` calls `child.get_theme_font_size("font_size")`. If the control already has a theme font size override from a previous `_apply_font_scale()` call, `get_theme_font_size()` returns the scaled override value instead of the theme's original base font size. When stored into `_base_font_sizes[child]`, subsequent calls to `_apply_font_scale()` multiply this already-scaled size by `scale_factor` again, causing font sizes to multiply exponentially (the "zoom" effect).

## Goals / Non-Goals

**Goals:**
- Fix font size caching in `gym.gd` and `home.gd` to ensure `_base_font_sizes` always holds the true unscaled base font size regardless of active overrides.
- Ensure `_show_practice_list()` resets `PracticeScroll` vertical scroll position to `0` and collapses the progress panel when returning from practice details.

**Non-Goals:**
- Altering the overall theme base font sizes or font scale factor array `FONT_SCALES`.

## Decisions

### Decision 1: Temporarily remove theme font size override when caching base sizes

- **Choice**: In `_cache_base_font_sizes(node: Node)`, if `child.has_theme_font_size_override("font_size")` is true, temporarily remove the override via `remove_theme_font_size_override("font_size")`, read the unscaled `get_theme_font_size("font_size")`, record it in `_base_font_sizes[child]`, and immediately re-apply the current scaled override using `add_theme_font_size_override("font_size", scaled_size)`.
- **Alternative Considered**: Resetting all theme overrides globally before re-caching. This would be slower and risk flashing unscaled UI during card rebuilds.

### Decision 2: Scroll reset and progress panel state on practice list return

- **Choice**: In `_show_practice_list()`, check if `practice_scroll` exists and set `practice_scroll.scroll_vertical = 0`, and collapse progress panel if appropriate.
- **Alternative Considered**: Retaining previous scroll position. Resetting scroll position gives the user a predictable, clean top-of-list view after completing a mission.

## Risks / Trade-offs

- None identified.
