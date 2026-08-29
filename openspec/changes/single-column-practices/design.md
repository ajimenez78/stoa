## Context

The Gym stance (`Dungeons/gym.tscn` and `Dungeons/Scripts/gym.gd`) displays daily practices, virtues, and minigames inside `GridContainer` controls. Previously, `_update_responsive_layout()` switched between 1 column for viewports `< 600px` and 2 columns for wider screens.

## Goals / Non-Goals

**Goals:**
- Force `practice_grid`, `virtue_grid`, and `minigame_grid` to always use `columns = 1`.
- Ensure all practice cards span full width in the Gym stance across all screen sizes.

**Non-Goals:**
- Changing column layouts outside the Gym stance (e.g., Home or Stoa stances).
- Modifying card internal padding or font sizes.

## Decisions

- **Decision 1: Enforce single-column layout in `gym.gd`**:
  - In `_update_responsive_layout()`, explicitly set `virtue_grid.columns = 1`, `practice_grid.columns = 1`, and `minigame_grid.columns = 1`.
  - In `Dungeons/gym.tscn`, update the `columns` property of `VirtueGrid`, `PracticeGrid`, and `MinigameGrid` from `2` to `1`.

## Risks / Trade-offs

- **[Risk] Cards take up more vertical scrolling space on large screens** → **Mitigation**: Scrolling is smooth and natural; full-width cards provide vastly superior text legibility.
