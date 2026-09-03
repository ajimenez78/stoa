## Context

See `proposal.md` for background.
Currently, `Dungeons/Scripts/gym.gd` initializes `_progress` and calls `_refresh()` in `_ready()`. When dungeons are pre-instantiated or kept in memory across level transitions, `_ready()` does not execute again upon re-entering the Gimnasio, causing stale data ("Nivel 1") to be displayed.

In addition, `_cache_base_font_sizes()` traverses child controls and writes `_base_font_sizes[child] = child.get_theme_font_size("font_size")`. When font overrides are active, `get_theme_font_size` returns the overridden (scaled) size. Re-executing `_cache_base_font_sizes()` (such as on card generation or toggle actions) overwrites `_base_font_sizes[child]` with the scaled value, causing subsequent `_apply_font_scale()` calls to compound the scale exponentially.

## Goals / Non-Goals

**Goals:**
- Reload progress data (`_progress = ProgressStore.load_progress()`) and execute `_refresh()` upon node entering tree / becoming visible.
- Ensure `_cache_base_font_sizes()` caches the unscaled font size strictly ONCE using `if not _base_font_sizes.has(child):`.
- Apply the same safeguard in `Dungeons/Scripts/home.gd`.

**Non-Goals:**
- Modifying the font scaling factor ratios or index bounds.
- Redesigning the layout or styling of the Gimnasio header or virtue grid.

## Decisions

### Decision 1: Visibility & Tree Entrance Lifecycle Hook
- **Choice**: Call `_refresh_progress()` on `NOTIFICATION_VISIBILITY_CHANGED` and when node enters tree if visible.
- **Rationale**: Guarantees that even if `Gym` is instantiated once and re-shown multiple times, user progress level is always fresh.

### Decision 2: Guarded Base Font Size Caching
- **Choice**: In `_cache_base_font_sizes(node: Node)`, only store font size if `not _base_font_sizes.has(child)` AND if `child` does not currently have a custom font size override from `add_theme_font_size_override`.
- **Rationale**: Prevents scaled font sizes from polluting the base font size cache, making font scaling completely idempotent regardless of how many times UI updates or card rebuilds occur.

## Risks / Trade-offs

- **[Risk]** Rapid visibility changes calling `_refresh()` too frequently.
  - **Mitigation**: `ProgressStore.load_progress()` is a light JSON read from local disk / memory; caching `_progress` and calling `_refresh()` on visibility change is negligible in CPU/disk impact.
