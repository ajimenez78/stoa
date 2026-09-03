## Purpose

Ensures that the Gym interface automatically adapts top container layouts and font sizes under high font scaling factors without overflowing the screen viewport.

## ADDED Requirements

### Requirement: Practice Detail Progress Panel Collapse
The system SHALL automatically collapse the progress panel whenever opening a practice description view to conserve vertical layout space.

#### Scenario: Opening practice description collapses progress panel
- **WHEN** the user selects a practice card to view its description
- **THEN** the progress panel collapses automatically so practice details fit vertically within the viewport

### Requirement: RichTextLabel Font Scale Support
The system SHALL apply font scale factors to RichTextLabel controls by scaling both `normal_font_size` and `bold_font_size` overrides.

#### Scenario: Font size adjustment scales RichTextLabel text
- **WHEN** the user modifies the font scale setting
- **THEN** both normal and bold font size overrides on RichTextLabel controls scale proportionally to match the active font scale factor

### Requirement: Screen Viewport Boundary Layout Containment
The system SHALL constrain vertical container dimensions in the Gym scene so that all content components flex and scroll within the screen viewport boundaries at any font scale factor.

#### Scenario: Max font scale prevents container overflow
- **WHEN** font scale is increased to its maximum setting in Gym view
- **THEN** all top controls, hero header, progress panel, and content scroll containers remain fully visible and accessible within the viewport
