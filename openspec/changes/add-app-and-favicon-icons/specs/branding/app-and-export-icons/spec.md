## Purpose

Defines application icon asset requirements and export preset icon configurations for mobile and web targets.

## ADDED Requirements

### Requirement: Main Application Icon Configuration
The Godot project configuration (`project.godot`) SHALL specify `res://icon.png` as the primary application icon under `[application] config/icon`.

#### Scenario: Launching or inspecting the project
- **WHEN** the Godot project is loaded in editor or built with default export fallbacks
- **THEN** Godot references `res://icon.png` as the application icon

### Requirement: Android Export Icon Options
The Android export preset in `export_presets.cfg` SHALL configure valid image file paths for mobile launcher icons (`launcher_icons/main_192x192`, `adaptive_foreground_432x432`, `adaptive_background_432x432`).

#### Scenario: Exporting Android build
- **WHEN** building or exporting the project for Android
- **THEN** the Android launcher displays the custom Stoa Greco-Roman column and laurel icon

### Requirement: Web Export Favicon and PWA Icon Options
The Web export preset in `export_presets.cfg` SHALL enable `html/export_icon=true` and configure PWA icon resolution paths (`progressive_web_app/icon_144x144`, `icon_180x180`, `icon_512x512`).

#### Scenario: Accessing Web export in browser
- **WHEN** loading the Web export in a browser or installing as a PWA
- **THEN** the browser tab displays the custom Stoa favicon and the PWA installer uses the high-res app icon
