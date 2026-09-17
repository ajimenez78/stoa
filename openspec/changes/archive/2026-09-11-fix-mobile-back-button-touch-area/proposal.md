## Why

In mobile landscape orientation, the estancia exit button (`$TouchControls/BackButton`) is positioned at `(16, 13)` with a small touch area (51 × 52 px). This makes it difficult to tap on mobile devices due to camera cutouts, rounded screen corners, status bars, and system edge-gesture rejection zones.

## What Changes

- Relocate `$TouchControls/BackButton` away from the screen edge (`x: 32px`, `y: 18px`), aligning it with estancia UI margins.
- Expand the touch target size to a minimum of 64 × 64 px for easy and reliable thumb presses on mobile screens.
- Add a semi-transparent glass background style (`StyleBoxFlat`) to give clear visual feedback and delimit the touch target.
- Ensure system back requests (`NOTIFICATION_WM_GO_BACK_REQUEST`) reliably exit estancias on Android/mobile.

## Capabilities

### New Capabilities
- `touch-controls`: Standardized touch navigation overlay guidelines including safe-area margins, minimum touch target dimensions, and visual feedback for mobile controls.

### Modified Capabilities

## Impact

- `Apprentice/apprentice.tscn`: Updates `$TouchControls/BackButton` transform, anchor, margins, minimum size, and theme/style overrides.
- `Apprentice/Scripts/apprentice.gd`: Ensures touch control visibility and event handling remain robust across window resize/orientation changes.
