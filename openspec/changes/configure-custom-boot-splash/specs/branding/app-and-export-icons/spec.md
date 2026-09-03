## ADDED Requirements

### Requirement: Custom Boot Splash Configuration
The Godot engine project configuration (`project.godot`) SHALL specify a custom boot splash image (`application/boot_splash/image`) and dark background color (`application/boot_splash/bg_color`).

#### Scenario: Application initial boot
- **WHEN** the application starts up before the main scene finishes loading
- **THEN** Godot displays the custom Stoa boot splash image against a dark background rather than the default engine splash screen

### Requirement: Android Boot Splash Settings
The Android export preset in `export_presets.cfg` SHALL configure `splash_screen/disable_godot_boot_splash=true` (or custom `splash_screen/icon` and matching dark background color).

#### Scenario: Android app launch
- **WHEN** launching the application on an Android device
- **THEN** the Android native splash transitions into the Stoa boot splash without showing the default "GODOT Game Engine" screen
