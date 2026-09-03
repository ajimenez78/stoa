## Context

See proposal.md - Why.

When font scale is modified by the user (e.g. scale factor 1.4 - 2.0), text labels inside `MissionCard` require much greater height when autowrapped.
When cards are instantiated during `_rebuild_practice_cards()`, `practice_list` is hidden (`practice_detail.visible = true`), so `MissionCard.size.x` is `0`.
In `MissionCard.update_adaptive_minimum_size()`, `if is_inside_tree() and size.x > 50` evaluated to `false`, forcing `custom_minimum_size.y = base_min_h` (`60 * scale_factor`).
When returning to `practice_list`, `practice_list.visible = true` triggered `resized` on each card. `update_adaptive_minimum_size()` then re-calculated height with `size.x > 50`, causing `custom_minimum_size.y` to jump from ~96px to ~175px+ per card.
At scale factor 1.0, this jump is negligible (~30px total list shift), but at scaled font sizes, it causes a multi-hundred pixel layout explosion that appears as an aggressive zoom.

## Goals / Non-Goals

**Goals:**
- Eliminate card height jumps when returning to `practice_list` after completing a practice at any font scale setting.
- Ensure `MissionCard.update_adaptive_minimum_size()` accurately computes minimum height regardless of container visibility.
- Ensure `_base_font_sizes` dictionary cleans up freed node references and maintains accurate unscaled font sizes.

**Non-Goals:**
- Modifying mission card themes or colors.

## Decisions

### Decision 1: Viewport width fallback for hidden card minimum height calculation
In `MissionCard.update_adaptive_minimum_size(scale_factor)`:
- Determine effective width: `var effective_w := size.x if (is_inside_tree() and size.x > 50) else max(280.0, get_viewport_rect().size.x - 40.0)`.
- Use `effective_w` when measuring content minimum height via `$Margin.get_combined_minimum_size().y`, ensuring stable `custom_minimum_size.y` is calculated for the active font scale before the container is made visible.

### Decision 2: Clean font size caching and stale key removal
In `_cache_base_font_sizes(node)`:
- Cache `child.get_theme_font_size("font_size")` for new controls before `_apply_font_scale()` modifies overrides.
- Remove invalid/freed keys from `_base_font_sizes` when rebuilding cards.

### Decision 3: Progress panel collapse and scroll reset
In `gym.gd`:
- `_show_practice_list()` collapses progress panel (`_collapse_progress_panel()`) and resets `practice_scroll.scroll_vertical = 0`.

## Risks / Trade-offs

- None identified.
