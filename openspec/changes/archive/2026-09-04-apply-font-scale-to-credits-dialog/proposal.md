## Why

Actualmente, cuando el usuario ajusta el tamaño de la letra (`A-` / `A+`) en la interfaz principal (`home.tscn` o `gym.tscn`), la ventana emergente de atribución y créditos (`credits_dialog.tscn`) no aplica el factor de escalado de fuente seleccionado, manteniendo siempre los tamaños por defecto. Esto genera una inconsistencia visual y dificulta la accesibilidad para usuarios que requieren un tamaño de texto mayor.

## What Changes

- Aplicar el factor de escala de fuente activo en la escena receptora al instanciar y abrir el diálogo de créditos (`credits_dialog.tscn`).
- Hacer que la escena `CreditsDialog` registre y escale dinámicamente sus etiquetas (`TitleLabel`, `BodyLabel`, `LinkButton`, `CloseButton`) según el multiplicador de tamaño de fuente actual.
- Asegurar que la altura mínima adaptativa y el contenedor con desplazamiento (`ScrollContainer`) del cuadro de diálogo de créditos acomoden adecuadamente los textos en cualquier nivel de escalado de fuente sin truncamiento.

## Capabilities

### New Capabilities
- `credits-and-attribution`: Define los requisitos para la presentación de créditos de atribución en el juego, incluyendo su adaptación al escalado de fuente activo de la interfaz.

### Modified Capabilities
(Ninguna)

## Impact

- `Dungeons/UI/credits_dialog.gd`: Métodos para recibir/aplicar el factor de escala de fuente y actualizar sus controles internos.
- `Dungeons/Scripts/home.gd` y `Dungeons/Scripts/gym.gd`: Pasar o aplicar la escala de fuente actual al abrir `CreditsDialog`.
