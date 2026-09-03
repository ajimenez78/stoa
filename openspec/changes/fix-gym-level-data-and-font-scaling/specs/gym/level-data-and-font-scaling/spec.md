## Purpose

Ensures the Gimnasio screen displays current user progress levels immediately on load and maintains stable font sizes when toggling UI elements.

## ADDED Requirements

### Requirement: Gimnasio Progress Data Synchronization
The Gimnasio screen SHALL load and display current user progress data and level indicators immediately when displayed to the user, without requiring user interaction to trigger a UI refresh.

#### Scenario: Displaying Gimnasio progress on enter
- **WHEN** the player enters or displays the Gimnasio screen
- **THEN** the LevelLabel and virtue meters display the up-to-date saved progress level immediately

### Requirement: Idempotent Font Scaling on Progress Toggle
The Gimnasio screen font scaling system SHALL maintain fixed, idempotent base font sizes when toggling progress visibility or re-caching node hierarchies, preventing font size escalation.

#### Scenario: Toggling progress section collapse
- **WHEN** the user presses the toggle progress button multiple times
- **THEN** the font size of controls on the screen remains constant according to the current selected font scale index
