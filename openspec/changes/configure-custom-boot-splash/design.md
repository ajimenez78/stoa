## Context

Currently, Godot's `application/boot_splash/*` properties are not set in `project.godot`, causing Godot to display its built-in fallback engine logo splash screen on all platforms. On Android exports, `export_presets.cfg` has `splash_screen/disable_godot_boot_splash=false` and `splash_screen/icon=""`. See `proposal.md` for motivation.

## Goals / Non-Goals

**Goals:**
- Configure `project.godot` `[application]` section with:
  - `boot_splash/image="res://icon.png"` (or `res://assets/icons/app_icon_1024.png`)
  - `boot_splash/bg_color=Color(0.12, 0.12, 0.14, 1)`
  - `boot_splash/show_image=true`
  - `boot_splash/fullsize=false`
  - `boot_splash/use_filter=true`
- Configure `export_presets.cfg` Android section with:
  - `splash_screen/disable_godot_boot_splash=true`
  - `splash_screen/icon="res://assets/icons/android/icon_192.png"`
  - `splash_screen/background_color=Color(0.12, 0.12, 0.14, 1)`

**Non-Goals:**
- Modifying engine C++ source code or custom Android build templates.

## Decisions

- **Decision**: Use `res://icon.png` as boot splash image and `#1E1E24` / `Color(0.12, 0.12, 0.14, 1)` as background color.
- **Rationale**: Reuses existing high-res Stoa column and laurel wreath branding icon while providing a seamless dark background transition into the main menu/game scenes.

## Risks / Trade-offs

- [Risk] Custom boot splash aspect ratio on tall mobile screens → Mitigation: Set `boot_splash/fullsize=false` and matching background color so the icon stays centered without stretching.
