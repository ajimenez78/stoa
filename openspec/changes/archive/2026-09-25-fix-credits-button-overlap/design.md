## Context

Ver `proposal.md` y `specs/credits-and-attribution/spec.md`. En `home.tscn`, `gym.tscn` y `stoa.tscn`, el panel de controles superiores `TopControlsPanel` está alineado al extremo derecho (`size_flags_horizontal = 8`). El botón flotante de ajustes `⚙` (`settings_menu.tscn`) se renderiza en un `CanvasLayer` superior (`layer = 100`) fijado a la derecha (`anchor_right = 1.0` con `offset_left = -72`), causando un solapamiento directo sobre el botón ` ℹ ` (`CreditsButton`).

## Goals / Non-Goals

**Goals:**
- Desplazar o añadir un margen a la derecha en `TopControlsPanel` de ~68-72px para evitar el solapamiento con `SettingsButton` (`⚙`).
- Añadir una opción en `settings_menu.tscn` para instanciar/abrir el modal de créditos desde el propio menú de configuración.

**Non-Goals:**
- Cambiar el diseño visual general ni la tipografía del botón `⚙` o ` ℹ `.

## Decisions

### Decisión 1: Margen derecho en `TopControlsPanel`

- **Enfoque:** En `home.tscn` y `gym.tscn`, ajustar el margen/offset o aplicar un `margin_right = 68` en `MarginContainer` o contenedor para dejar un hueco reservado al botón flotante `⚙`.

### Decisión 2: Opción de Créditos en `SettingsMenu`

- **Enfoque:** Añadir una fila adicional con un botón "Créditos y Licencias" en `settings_menu.tscn` y conectar en `settings_menu.gd` la apertura de `credits_dialog.tscn`.

## Risks / Trade-offs

- **[Riesgo]** Ancho reducido en pantallas móviles muy estrechas.
  - **Mitigación:** La aplicación está configurada en orientación horizontal (`landscape`) en `project.godot`, garantizando espacio horizontal suficiente.
