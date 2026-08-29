## Purpose

Provides mobile-optimized interface controls, touch gesture pass-through, responsive layouts, and dynamic font size configuration for the Gym (Gimnasio) stance.

## ADDED Requirements

### Requirement: Dynamic Font Scaling
The Gym stance SHALL provide top controls with font scale decrease (`A-`) and font scale increase (`A+`) buttons that adjust text font sizes dynamically across all Gym controls and cards.

#### Scenario: User changes font scale
- **WHEN** user taps `A-` or `A+` in the Gym top controls panel
- **THEN** system scales all text font sizes up or down across virtue meters, practice cards, challenge cards, minigame cards, and detail views within the defined scale bounds (0.85x to 2.0x)

#### Scenario: Initial font scale on mobile devices
- **WHEN** Gym stance initializes on a mobile device or viewport narrower than 600px
- **THEN** system sets the initial font scale index to 3 (1.4x scale factor)

### Requirement: Touch Drag Pass-Through
The Gym stance SHALL pass vertical touch drag gestures from cards, virtue meters, and panel controls directly up to `ScrollContainer` to enable smooth touch scrolling across the screen.

#### Scenario: User drags finger over cards or virtue meters
- **WHEN** user performs a vertical touch drag gesture on any card or virtue meter
- **THEN** system passes the touch event to `ScrollContainer` and scrolls the view vertically without blocking

#### Scenario: User taps a button
- **WHEN** user taps a button or mission card in the Gym stance
- **THEN** system processes the button tap normally to trigger its action

### Requirement: Single-Column Responsive Layout
The Gym stance SHALL adjust grid layouts to a single vertical column when viewed on narrow mobile screens.

#### Scenario: Mobile viewport layout
- **WHEN** viewport width is less than 600px
- **THEN** system arranges virtue meters, daily practice cards, and minigame cards into single-column vertical stacks
