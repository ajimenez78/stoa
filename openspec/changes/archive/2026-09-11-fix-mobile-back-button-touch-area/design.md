## Context

See `proposal.md` for motivation.

In `Apprentice/apprentice.tscn`, `$TouchControls/BackButton` is a Godot `Button` child node under `$TouchControls` (CanvasLayer layer 100).

Currently, it uses raw manual offsets (`16.0, 13.0, 67.0, 65.0`) resulting in a 51 × 52 px rectangle positioned close to the top-left screen edge.

## Goals / Non-Goals

**Goals:**
- Adjust `$TouchControls/BackButton` position and margins to `(32, 18)` with dimensions `64 × 64 px` (`custom_minimum_size = Vector2(64, 64)`).
- Apply a semi-transparent glass `StyleBoxFlat` background to `$TouchControls/BackButton` matching the aesthetic of Gym UI (`StyleBoxFlat_glass`).
- Preserve the existing node path (`$TouchControls/BackButton`) and script signal connections (`_on_back_button_pressed`).

**Non-Goals:**
- Changing virtual joystick or movement controls behavior outside of estancias.
- Altering the scene hierarchy under `TouchControls`.

## Decisions

### Decision 1: Direct Button Node Styling and Custom Minimum Size (64 × 64 px)
- **Rationale**: Setting `custom_minimum_size = Vector2(64, 64)` and `offset_left = 32.0`, `offset_top = 18.0`, `offset_right = 96.0`, `offset_bottom = 82.0` on the `Button` node directly avoids introducing extra container nodes. This keeps the Node path `$TouchControls/BackButton` unchanged for `apprentice.gd`.
- **Alternatives Considered**: Wrapping `BackButton` in a `MarginContainer`. Rejected to prevent node path changes or potential broken references in scripts.

### Decision 2: Glass Theme Overrides (`StyleBoxFlat`)
- **Rationale**: Adding `StyleBoxFlat` normal/hover/pressed overrides (`bg_color` with 0.62 alpha and 8px corner radius) gives immediate visual feedback on touch and clearly highlights the 64 × 64 px touch target.
- **Alternatives Considered**: Using a plain transparent icon. Rejected because users need visual confirmation of the button's touch bounds.

## Risks / Trade-offs

- **[Risk]** Larger button size (64 × 64 px) might overlap with top-left content if new elements are added to estancias.
  - **Mitigation**: Estancias like Gym place top controls (`TopControlsPanel`) on the top-right (`size_flags_horizontal = 8`). The top-left region is reserved for navigation exit.
