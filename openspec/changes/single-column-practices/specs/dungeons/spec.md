## Purpose

Manages the layout, navigation, and display rules for stances in Stoa, ensuring single-column layout for daily practices, virtue meters, and minigames in the Gym stance.

## ADDED Requirements

### Requirement: Single-column distribution for Gym practices, virtues, and minigames
The Gym stance SHALL layout daily practices, virtue meters, and minigames in a single-column grid across all screen sizes and device viewports.

#### Scenario: Displaying Gym stance grids
- **WHEN** the user opens or views the Gym stance on mobile or desktop screens
- **THEN** `practice_grid`, `virtue_grid`, and `minigame_grid` display their items in 1 single column
