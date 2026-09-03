## Context

See `proposal.md` for context.
Currently in `Dungeons/gym.tscn`, `PracticeDetail` is a `VBoxContainer` directly inside `Practices`. Unlike `PracticeList`, `Challenges`, and `MinigameList` which use `ScrollContainer` (`PracticeScroll`, `ChallengeScroll`, `MinigameScroll`), `PracticeDetail` lacks a `ScrollContainer`. When content (title, description, meta, steps panel, complete button) expands beyond screen bounds, vertical scrolling fails.

## Goals / Non-Goals

**Goals:**
- Add a `ScrollContainer` (`PracticeDetailScroll`) inside `PracticeDetail` (or wrap `PracticeDetail`'s inner scrollable content in a `ScrollContainer`).
- Ensure `_configure_scroll_pass_through` in `gym.gd` configures mouse filter pass-through for `PracticeDetailScroll` children so touch dragging works smoothly on mobile screens.
- Keep export bindings and node paths connected in `gym.gd` and `gym.tscn`.

**Non-Goals:**
- Altering the layout styling or visual appearance of practice details.

## Decisions

### Decision 1: `PracticeDetailScroll` ScrollContainer Structure
- **Choice**: Insert `PracticeDetailScroll` (`ScrollContainer`) inside `PracticeDetail` between `BackButton` and `CompleteButton`, or wrap the body (`TitleLabel`, `DescriptionLabel`, `MetaLabel`, `StepsPanel`, `Spacer`) in a `PracticeDetailScroll` container with `size_flags_vertical = SIZE_EXPAND_FILL`.
- **Rationale**: Keeps `BackButton` anchored at the top and `CompleteButton` anchored or included cleanly, while enabling full vertical scrollability for all text labels and steps.

### Decision 2: Scroll Pass-Through Recursive Configuration
- **Choice**: `_configure_scroll_pass_through(self)` in `gym.gd` recursively sets `mouse_filter = MOUSE_FILTER_PASS` on labels and containers inside `ScrollContainer`s.
- **Rationale**: Guarantees touch drag gestures on labels inside `PracticeDetailScroll` bubble up to the `ScrollContainer` for smooth touch scrolling on Android/iOS.

## Risks / Trade-offs

- **[Risk]** Broken node paths if exported node paths in `gym.tscn` are moved.
  - **Mitigation**: Keep exported node paths updated in `gym.tscn` to point to the new location under `PracticeDetailScroll`.
