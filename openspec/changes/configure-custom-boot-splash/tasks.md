## 1. Project & Export Configuration

- [x] 1.1 Update `project.godot` to set `application/boot_splash/image`, `application/boot_splash/bg_color`, `application/boot_splash/show_image`, `application/boot_splash/fullsize`, and `application/boot_splash/use_filter`
- [x] 1.2 Update `export_presets.cfg` Android preset to set `splash_screen/disable_godot_boot_splash=true`, `splash_screen/icon="res://assets/icons/android/icon_192.png"`, and `splash_screen/background_color` matching theme

## 2. Verification

- [x] 2.1 Verify `project.godot` and `export_presets.cfg` build cleanly in headless Godot mode with zero errors or warnings
