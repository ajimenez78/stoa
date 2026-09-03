## Why

When completing a daily practice in the Gimnasio screen (`gym.gd`), returning to the practices list causes controls to appear zoomed in or oversized, obscuring parts of the list view content. This occurs because font caching logic records overridden font sizes when controls are re-cached or re-instantiated, causing theme font size overrides to scale compoundingly whenever `_apply_font_scale()` is invoked.

## What Changes

- Update `_cache_base_font_sizes()` in `Dungeons/Scripts/gym.gd` and `Dungeons/Scripts/home.gd` to detect existing theme font size overrides (`has_theme_font_size_override`), temporarily clearing them before reading unscaled base font sizes (`get_theme_font_size`), preventing compounding scaling.
- Ensure `_show_practice_list()` in `Dungeons/Scripts/gym.gd` collapses the progress panel and resets `PracticeScroll` vertical position to `0` when returning from practice details.

## Capabilities

### New Capabilities
- `gym/practice-completion-font-scaling`: Prevents font size compounding on practice card rebuilds and ensures clean practice list navigation upon completion.

### Modified Capabilities

## Impact

- `Dungeons/Scripts/gym.gd`
- `Dungeons/Scripts/home.gd`
- `Dungeons/gym.tscn`
