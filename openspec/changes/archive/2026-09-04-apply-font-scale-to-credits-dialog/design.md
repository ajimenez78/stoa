## Context

Ver `proposal.md` para la motivación.

`CreditsDialog` es una escena Control instanciada dinámicamente desde `home.gd` o `gym.gd`. Tanto `home.gd` como `gym.gd` gestionan el estado del escalado de fuente mediante un arreglo de factores `FONT_SCALES` y un índice activo `_current_scale_index`.

Actualmente `credits_dialog.gd` no registra los tamaños base de fuente ni dispone de una función para aplicar un multiplicador de escala a sus nodos hijos.

## Goals / Non-Goals

**Goals:**
- Proporcionar una API limpia en `CreditsDialog` (`set_font_scale(scale_factor: float)`) para recibir el factor de escala y aplicarlo a todos los controles de texto internos (`TitleLabel`, `BodyLabel`, `LinkButton`, `CloseButton`).
- Almacenar los tamaños base de fuente en `CreditsDialog` para evitar pérdida de precisión por redondeos acumulados.
- Actualizar `home.gd` y `gym.gd` para pasar el factor de escala actual (`FONT_SCALES[_current_scale_index]`) al instanciar u abrir `CreditsDialog`.

**Non-Goals:**
- Modificar el sistema de almacenamiento persistente `ProgressStore` para guardar la escala de fuente entre sesiones (se mantiene el comportamiento volátil actual según la sesión de UI).

## Decisions

1. **Gestión de Caching de Fuentes en `credits_dialog.gd`**:
   - `CreditsDialog` almacenará en `_base_font_sizes` los tamaños originales definidos en el archivo `.tscn` para cada Control interno.
   - *Alternativa considerada:* Obtener directamente `theme_override_font_sizes/font_size`, lo cual fallaría o se degradaría con escalados repetidos.

2. **Propagación desde las escenas principales (`home.gd` / `gym.gd`)**:
   - `_on_credits_pressed()` invocará `_credits_dialog.set_font_scale(FONT_SCALES[_current_scale_index])` justo antes o después de llamar a `open()`.
   - *Alternativa considerada:* Hacer que `CreditsDialog` busque al padre e intente leer variables privadas. Se rechazó por acoplamiento indeseado.

## Risks / Trade-offs

- **[Risk]** Texto desbordado en pantallas pequeñas cuando el escalado está al máximo (2.0x).
  - *Mitigación:* El contenedor `BodyLabel` se encuentra dentro de un `ScrollContainer` con filtrado de ratón/scroll activo y `autowrap_mode = 3` (WORD_SMART), permitiendo scroll vertical fluido sin cortar contenido.
