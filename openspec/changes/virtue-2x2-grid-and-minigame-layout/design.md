## Context

In `Dungeons/Scripts/gym.gd`, `_update_responsive_layout()` previously set `virtue_grid.columns = 1`, and `Dungeons/gym.tscn` set `columns = 1` on `VirtueGrid`. This stacked the 4 virtue meters vertically in a single 4-row column, occupying excess vertical space above the practices/minigames content area.

## Goals / Non-Goals

**Goals:**
- Set `virtue_grid.columns = 2` in `_update_responsive_layout()` in `Dungeons/Scripts/gym.gd`.
- Set `columns = 2` on `VirtueGrid` in `Dungeons/gym.tscn`.

**Non-Goals:**
- Changing practice grid or minigame grid column counts (`columns = 1` remains unchanged).

## Decisions

- **Decision 1**: Set `virtue_grid.columns = 2` in `_update_responsive_layout()`.

## Risks / Trade-offs

- None identified.
