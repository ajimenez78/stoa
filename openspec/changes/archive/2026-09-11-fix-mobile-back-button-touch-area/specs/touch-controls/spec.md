## Purpose

Provides touch navigation controls, safe area positioning, and touch target sizing standards for mobile UI overlays in Stoa.

## ADDED Requirements

### Requirement: Estancia Back Button Position and Safe Area
The estancia back control button (`$TouchControls/BackButton`) MUST be positioned outside of screen edge deadzones, notches, rounded display corners, and OS system gesture regions.

#### Scenario: Back button rendering on mobile landscape
- **WHEN** the player enters any estancia or dungeon in mobile landscape orientation
- **THEN** the back button is rendered with a left offset of at least 28px and top offset of at least 18px to align with estancia UI margins and avoid screen bezel touch rejection

### Requirement: Estancia Back Button Minimum Touch Target
The estancia back control button MUST provide a minimum touch hit target size of 64 × 64 pixels to ensure reliable touch detection on mobile devices.

#### Scenario: Back button touch dimensions
- **WHEN** a player taps the back button on a touch screen
- **THEN** the entire 64 × 64 pixel touch surface registers the tap event reliably without requiring pinpoint accuracy

### Requirement: Estancia Back Button Visual Touch Feedback
The estancia back control button MUST display a semi-transparent background container and distinct press states to visually delineate the touchable boundary.

#### Scenario: Back button pressed state
- **WHEN** the back button is touched or pressed
- **THEN** the button displays visual press state feedback before triggering the estancia exit transition
