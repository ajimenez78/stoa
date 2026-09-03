## Purpose

Allows collapsing and expanding the Gimnasio top Progress Panel to optimize vertical screen space for practices, challenges, and minigame content when font sizes are increased.

## ADDED Requirements

### Requirement: Toggle Progress Panel State
The Gimnasio screen SHALL provide an interactive toggle control on the Progress Panel header that switches between an expanded and collapsed state.

#### Scenario: User toggles to collapse progress panel
- **WHEN** the user taps the toggle control while the Progress Panel is expanded
- **THEN** the Progress Panel collapses, hiding the 2x2 Virtue Grid and Level Hint Label, and updating the toggle indicator to collapsed (`▼` / `►`)

#### Scenario: User toggles to expand progress panel
- **WHEN** the user taps the toggle control while the Progress Panel is collapsed
- **THEN** the Progress Panel expands, revealing the 2x2 Virtue Grid and Level Hint Label, and updating the toggle indicator to expanded (`▲` / `▼`)

### Requirement: Layout Adaptation and Vertical Space Recovery
When the Progress Panel is collapsed, the vertical space previously occupied by the Virtue Grid and Level Hint Label SHALL be reallocated automatically to the content ScrollContainers (Practices, Challenges, Minigames).

#### Scenario: Large font scale with collapsed progress panel
- **WHEN** the font scale is increased (e.g. 1.4x - 2.0x) and the Progress Panel is collapsed
- **THEN** the content ScrollContainer expands vertically to occupy the freed screen space
