## Why

Para cumplir con la transparencia en la gestión de datos y proporcionar un acceso claro y accesible a la política de privacidad desde la aplicación y la documentación del repositorio, es necesario incluir un apartado dedicado a la Política de Privacidad que redirija a la URL oficial `https://arturo-jimenez.es/stoa-privacy-policy/`.

## What Changes

- **Ampliación de `CreditsDialog`**: Incluir una sección para "Política de Privacidad" dentro del cuadro de diálogo modal de créditos y licencias (`Dungeons/UI/credits_dialog.tscn`), agregando un botón interactivo que abre la URL en el navegador externo mediante `OS.shell_open()`.
- **Integración con escalado adaptativo**: Garantizar que la nueva sección y su botón respeten el sistema de cacheo y escalado de fuentes (`set_font_scale()`) del modal.
- **Actualización de documentación**: Incluir el enlace a la Política de Privacidad en `README.md` y `CREDITS.md` para mantener la coherencia en el repositorio.

## Capabilities

### Modified Capabilities
- `credits-and-attribution`: Define los requisitos para presentar tanto los créditos de licencias como el acceso a la política de privacidad del juego mediante un enlace externo accesible y adaptable.

## Impact

- `Dungeons/UI/credits_dialog.tscn`: Modificación de la estructura de nodos en la UI agregando la categoría y el botón de política de privacidad.
- `Dungeons/UI/credits_dialog.gd`: Conexión de la señal del nuevo botón de política de privacidad con la llamada a `OS.shell_open("https://arturo-jimenez.es/stoa-privacy-policy/")`.
- `README.md` y `CREDITS.md`: Adición del enlace a la política de privacidad.
