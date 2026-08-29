## Context

`_rebuild_minigame_cards()` in `gym.gd` and `_build_prompt_cards()` in `home.gd` both called `_apply_font_scale()` synchronously right after adding cards to their respective grid containers. Because grid containers assign layout bounds during tree processing, calling `_apply_font_scale()` synchronously caused cards to evaluate wrapped text minimum heights against default un-placed scene widths.

## Goals / Non-Goals

**Goals:**
- Replace synchronous `_apply_font_scale()` in `gym.gd` (`_rebuild_minigame_cards()`) with `call_deferred("_apply_font_scale")`.
- Replace synchronous `_apply_font_scale()` in `home.gd` (`_build_prompt_cards()`) with `call_deferred("_apply_font_scale")`.

**Non-Goals:**
- Modifying card layouts or Godot container node hierarchies.

## Decisions

- **Decision 1**: Defer font scale application in both builder routines to guarantee container widths are calculated prior to minimum height evaluation.
