## 1. Componente `CreditsDialog` (GDScript)

- [x] 1.1 Implementar en `Dungeons/UI/credits_dialog.gd` el almacenamiento de tamaños base de fuente y la función `set_font_scale(scale_factor: float)` que aplica el override de tamaño de fuente a los controles internos.

## 2. Integración en Pantallas Principales

- [x] 2.1 Actualizar `_on_credits_pressed()` en `Dungeons/Scripts/home.gd` para aplicar `FONT_SCALES[_current_scale_index]` al cuadro de diálogo de créditos antes de mostrarlo.
- [x] 2.2 Actualizar `_on_credits_pressed()` en `Dungeons/Scripts/gym.gd` para aplicar `FONT_SCALES[_current_scale_index]` al cuadro de diálogo de créditos antes de mostrarlo.

## 3. Verificación y Pruebas

- [x] 3.1 Ejecutar la validación con `openspec validate apply-font-scale-to-credits-dialog` y comprobar el correcto comportamiento visual del cuadro de diálogo al cambiar los tamaños de fuente.
