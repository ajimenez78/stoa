## Why

When launching on mobile (Android), Godot currently displays the default engine boot splash screen ("GODOT Game Engine") before loading the main scene. Replacing or disabling the default engine splash screen with custom Stoa boot splash branding creates a seamless, professional startup experience matching Stoa's visual theme.

## What Changes

- Configure Godot boot splash settings in `project.godot`:
  - `application/boot_splash/image="res://icon.png"` (or custom splash image)
  - `application/boot_splash/bg_color=Color(0.1, 0.1, 0.11, 1)` (dark theme background)
  - `application/boot_splash/show_image=true`
  - `application/boot_splash/fullsize=false`
  - `application/boot_splash/use_filter=true`
- Configure Android export splash settings in `export_presets.cfg`:
  - Set `splash_screen/disable_godot_boot_splash=true` to suppress the engine logo on Android
  - Set `splash_screen/icon="res://icon.png"` and dark background color matching Stoa palette

## Capabilities

### Modified Capabilities
- `branding/app-and-export-icons`: Add boot splash screen requirements for engine and mobile export configurations.

## Impact

- `project.godot`: Adds `[application] boot_splash/*` properties.
- `export_presets.cfg`: Updates Android `splash_screen/*` preset options.
