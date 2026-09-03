## Context

When entering Gym, `minigames_panel` is hidden (`visible = false`). Initial deferred scaling runs while `minigames_panel` is hidden. When the user navigates to the "Mini-juegos" tab, `minigames_panel` becomes visible, but card adaptive minimum heights were not recalculated for the visible layout pass.

## Goals / Non-Goals

**Goals:**
- Update `_show_panel()` in `gym.gd` to execute `call_deferred("_apply_font_scale")` so switching to any tab recalculates card heights for visible layout bounds.

**Non-Goals:**
- Altering tab selection UI buttons or animation transitions.

## Decisions

- **Decision 1**: Add `call_deferred("_apply_font_scale")` to `_show_panel()` in `gym.gd`.
