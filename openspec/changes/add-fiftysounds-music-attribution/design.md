## Context

Ver `proposal.md` y `specs/credits-and-attribution/spec.md`. El juego está desarrollado en Godot 4 y utiliza componentes Control en `Dungeons/UI/` con soporte para escalado adaptativo de fuentes y diseño móvil. La pista de audio `assets/Returning Home.mp3` requiere atribución de FiftySounds.

## Goals / Non-Goals

**Goals:**
- Crear la escena reusable `res://Dungeons/UI/credits_dialog.tscn` y su script `credits_dialog.gd` con soporte para responsive font scaling.
- Integrar el botón de apertura de créditos en la barra de herramientas de las pantallas principales (`home.tscn` y `gym.tscn`).
- Documentar las licencias y atribuciones de terceros en `README.md` y `CREDITS.md`.

**Non-Goals:**
- Modificar el sistema de audio o la reproducción de música existente.
- Implementar peticiones de red para cargar créditos externos.

## Decisions

### Decisión 1: Creación de escena Control `credits_dialog.tscn`
- **Enfoque:** Crear un diálogo personalizado dentro de `Dungeons/UI/` compuesto por un `PanelContainer` transparente/estilizado, un `VBoxContainer`, un `ScrollContainer` con los detalles del crédito y un botón `Button` ("Cerrar" / `X`).
- **Alternativa considerada:** Usar `AcceptDialog` nativo de Godot. Se descartó porque `AcceptDialog` no hereda automáticamente los estilos ni las fuentes adaptativas personalizadas (`FONT_SCALES`) del juego.

### Decisión 2: Responsividad y adaptación de fuente
- **Enfoque:** Implementar métodos en `credits_dialog.gd` para integrarse con la caché de tamaños de fuente (`_cache_base_font_sizes`) y aplicar el factor de escala activo.
- **Alternativa considerada:** Tamaño de texto fijo. Se descartó para evitar problemas de accesibilidad y legibilidad en pantallas móviles pequeñas o de alta densidad.

### Decisión 3: Estructura de documentación
- **Enfoque:** Crear `CREDITS.md` en la raíz para detallar todas las licencias de terceros presentes y futuras, y referenciarlo desde la sección `## Créditos` de `README.md`.

## Risks / Trade-offs

- **[Riesgo]** Desbordamiento de texto en pantallas pequeñas de smartphones.
  - **Mitigación:** Envolver el contenido textual dentro de un `ScrollContainer` con `custom_minimum_size` relativo y barras de desplazamiento automáticas.
