## Purpose

Ensures the practice detail view in the Gimnasio screen is scrollable so all descriptions, steps, and action buttons are accessible on any screen size.

## ADDED Requirements

### Requirement: Practice detail view content scrolling
The practice detail view SHALL enclose its content within a `ScrollContainer` so that long descriptions, step lists, and action buttons can be scrolled vertically on any device viewport size.

#### Scenario: Long practice description exceeds vertical viewport
- **WHEN** the user opens a practice detail whose text content exceeds available vertical space
- **THEN** the system enables vertical scrolling allowing the user to scroll to read the complete description, steps, and reach the completion button
