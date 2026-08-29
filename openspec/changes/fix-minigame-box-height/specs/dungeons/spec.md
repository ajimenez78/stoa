## Purpose

Defines layout and initial height calculation rules for minigame cards and minigame play containers in Gym stance.

## ADDED Requirements

### Requirement: Immediate initial adaptive height calculation for minigames
When minigame cards are instantiated or when a minigame is opened for the first time, the system SHALL calculate adaptive minimum heights immediately using the active font scale factor and content margins.

#### Scenario: Instantiating minigames on initial entry
- **WHEN** the user opens the Gym minigames tab or launches "Dicotomía de control" for the first time
- **THEN** minigame cards and drop zones render with tight, content-fitted adaptive minimum heights matching the active font scale without requiring manual font size changes
