## Why

The Stoa application currently uses Godot's default placeholder engine logo (`icon.svg`), which lacks custom branding for mobile device launcher icons and web favicons. Adding a dedicated, custom-designed Stoic application icon improves brand identity, visual recognition, and export polish across mobile (Android) and web deployments.

## What Changes

- Create master high-resolution app icon asset (`res://assets/icons/app_icon_1024.png`) featuring a stylized Greco-Roman column and golden laurel wreath design on dark marble stone.
- Generate derived icon variants:
  - `res://icon.png` (Godot main project icon)
  - Mobile Android icons: `res://assets/icons/android/icon_192.png`, `adaptive_fg.png`, `adaptive_bg.png`
  - Web export icons: `res://assets/icons/web/favicon.png`, `pwa_144.png`, `pwa_180.png`, `pwa_512.png`
- Configure `project.godot` to use `res://icon.png` as the main application icon.
- Configure `export_presets.cfg` for Android launcher icon paths and Web export/PWA icon settings.

## Capabilities

### New Capabilities
- `branding/app-and-export-icons`: Defines standard application icon assets and export presets for mobile and web deployments.

### Modified Capabilities

## Impact

- **Project Configuration**: `project.godot` (`config/icon`).
- **Export Configuration**: `export_presets.cfg` (Android launcher icons and Web PWA icons).
- **Assets**: New directory structure `res://assets/icons/` containing icon PNG files for various export resolutions.
