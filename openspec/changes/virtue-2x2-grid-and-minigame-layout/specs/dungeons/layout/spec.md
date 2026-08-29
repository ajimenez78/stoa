## Purpose

Defines Gym stance layout constraints for virtue progress representation.

## ADDED Requirements

### Requirement: 2x2 matrix for virtue progress grid
The Gym virtue progress grid (`VirtueGrid`) SHALL arrange the four stoic virtues into a 2-column, 2-row grid (`columns = 2`), reducing header vertical footprint across all display resolutions.

#### Scenario: Displaying virtue progress in Gym
- **WHEN** the Gym stance is rendered
- **THEN** `VirtueGrid` displays virtues in a compact 2x2 matrix layout
