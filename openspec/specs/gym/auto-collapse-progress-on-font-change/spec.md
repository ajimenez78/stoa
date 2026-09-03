## Purpose

Automatically collapses the Gimnasio progress panel upon font size adjustments to conserve screen space for activity cards.

## Requirements

### Requirement: Auto-collapse progress panel on font size adjustment
When the user increases or decreases the font size in the Gimnasio screen, the system SHALL automatically collapse the progress panel if it is currently expanded.

#### Scenario: User increases font size while progress panel is expanded
- **WHEN** the user presses the font increase button while the progress panel is expanded
- **THEN** the system collapses the progress panel, hides `virtue_grid` and `level_hint_label`, and updates the toggle button indicator to " ▼ "

#### Scenario: User decreases font size while progress panel is expanded
- **WHEN** the user presses the font decrease button while the progress panel is expanded
- **THEN** the system collapses the progress panel, hides `virtue_grid` and `level_hint_label`, and updates the toggle button indicator to " ▼ "

#### Scenario: User adjusts font size when progress panel is already collapsed
- **WHEN** the user adjusts font size while the progress panel is already collapsed
- **THEN** the system maintains the progress panel in its collapsed state without error
