## Context

Currently, `project.godot` specifies `res://icon.svg` (default Godot logo), and `export_presets.cfg` leaves all mobile launcher icons and web PWA icon options empty. See `proposal.md` for motivation.

## Goals / Non-Goals

**Goals:**
- Generate a high-resolution master asset (`res://assets/icons/app_icon_1024.png`) and derived variants for main project icon, Android launcher icons, and Web/PWA icons.
- Update `project.godot` to point `config/icon` to `res://icon.png`.
- Update `export_presets.cfg` to populate Android launcher icon paths and Web export / PWA icon paths.

**Non-Goals:**
- Creating custom native Android/iOS native splash animations or native C++ export plugins.

## Decisions

- **Decision**: Store icon files in structured subdirectories under `res://assets/icons/`.
  - Master: `res://assets/icons/app_icon_1024.png`
  - Main icon: `res://icon.png` (512x512 PNG at root for engine fallback)
  - Android: `res://assets/icons/android/icon_192.png`, `adaptive_fg.png` (432x432), `adaptive_bg.png` (432x432)
  - Web: `res://assets/icons/web/favicon.png` (64x64), `pwa_144.png`, `pwa_180.png`, `pwa_512.png`
- **Rationale**: Keeps icon assets cleanly organized by target platform while satisfying Godot 4 export preset requirements.

## Risks / Trade-offs

- [Risk] Godot `.import` files generated on icon copy. → Mitigation: Allow Godot headless / editor import to register `.import` metadata cleanly.
