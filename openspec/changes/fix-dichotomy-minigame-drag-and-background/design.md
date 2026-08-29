## Context

In `Dungeons/Scripts/gym.gd`, `_configure_scroll_pass_through()` was previously called on newly loaded minigames (`game`). This helper function set `mouse_filter = Control.MOUSE_FILTER_IGNORE` on all `Control` nodes except `BaseButton`, preventing `SituationCard` (`PanelContainer`) and `DropZone` (`PanelContainer`) from detecting drag-and-drop gestures (`_get_drag_data`, `_can_drop_data`, `_drop_data`). In addition, `DropZone`'s default StyleBox Flat background used low alpha opacity (`0.28`), creating a faint semi-translucent appearance.

## Goals / Non-Goals

**Goals:**
- Do NOT run `_configure_scroll_pass_through()` on active minigame scenes so that interactive minigame controls retain their configured mouse filters.
- Update `DropZone` background style in `drop_zone.tscn` to use solid, crisp opacity (`Color(0.96, 0.94, 0.90, 1.0)`) and clear borders.

**Non-Goals:**
- Modifying static mission card scroll behavior in `minigame_grid`.

## Decisions

- **Decision 1**: Omit `_configure_scroll_pass_through(game)` in `_open_minigame()`.
- **Decision 2**: Update `drop_zone.tscn` `ZonePanel` stylebox background to solid opaque theme color (`bg_color = Color(0.96078, 0.94118, 0.90196, 1)` and `border_color = Color(0.85, 0.80, 0.72, 1)`).

## Risks / Trade-offs

- None.
