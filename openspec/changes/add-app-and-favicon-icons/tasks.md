## 1. Asset Generation & Directory Setup

- [x] 1.1 Create directory structure `assets/icons/android/` and `assets/icons/web/`
- [x] 1.2 Save master high-resolution icon `res://assets/icons/app_icon_1024.png` and generate `res://icon.png` (512x512)
- [x] 1.3 Generate Android launcher icons (`icon_192.png`, `adaptive_fg.png`, `adaptive_bg.png`) in `assets/icons/android/`
- [x] 1.4 Generate Web export / PWA icons (`favicon.png`, `pwa_144.png`, `pwa_180.png`, `pwa_512.png`) in `assets/icons/web/`

## 2. Godot & Export Preset Configurations

- [x] 2.1 Update `project.godot` to set `config/icon="res://icon.png"`
- [x] 2.2 Update `export_presets.cfg` Android section to populate `launcher_icons/main_192x192`, `adaptive_foreground_432x432`, `adaptive_background_432x432`
- [x] 2.3 Update `export_presets.cfg` Web section to configure PWA icon paths (`pwa_144.png`, `pwa_180.png`, `pwa_512.png`)

## 3. Verification

- [x] 3.1 Verify project builds cleanly in headless Godot mode with no errors or warnings
