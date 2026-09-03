## Why

When completing a daily practice in the Gimnasio screen (`gym.gd`) after modifying font size (increasing or decreasing scale factor), returning to the practice list screen causes visual distortion where practice cards jump dramatically in size or appear zoomed in.

This occurs because when font size is scaled up (e.g. scale factor 1.4 - 2.0), text labels require significantly more vertical space (170px+ vs 90px). When cards are rebuilt while `practice_list` is hidden, `MissionCard.update_adaptive_minimum_size()` sees `size.x == 0` and falls back to a tiny baseline height (`60 * scale_factor`). When `practice_list` becomes visible, `resized` fires on each card, causing all cards to suddenly expand from ~96px to ~175px+. This sudden 400px+ height explosion across the list gives the visual illusion that a massive zoom was applied upon completing a practice.

## What Changes

- Update `update_adaptive_minimum_size()` in `Dungeons/UI/mission_card.gd` to estimate realistic card layout width from the viewport size (`get_viewport_rect().size.x`) even when `size.x <= 50` (hidden container), ensuring `custom_minimum_size.y` is accurately set up front for the modified font scale.
- Update `_cache_base_font_sizes()` in `Dungeons/Scripts/gym.gd` and `Dungeons/Scripts/home.gd` to reliably record unscaled base font sizes without losing custom label scene overrides.
- Clean up dead node keys in `_base_font_sizes` dictionary when cards are freed.
- Ensure `_show_practice_list()` collapses the progress panel and resets `practice_scroll.scroll_vertical = 0` upon returning to practice list view.

## Capabilities

### New Capabilities
- `gym/practice-card-adaptive-layout`: Ensures practice card heights and layout dimensions remain stable across visibility transitions under all font scale settings.

### Modified Capabilities

## Impact

- `Dungeons/UI/mission_card.gd`
- `Dungeons/Scripts/gym.gd`
- `Dungeons/Scripts/home.gd`
