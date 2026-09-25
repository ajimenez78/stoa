## 1. Actualización de la Escena e Interfaz UI

- [x] 1.1 Modificar `Dungeons/UI/credits_dialog.tscn` para añadir las etiquetas de categoría ("Política de Privacidad"), descripción y el botón interactivo "🌐 Ver Política de Privacidad" (`PrivacyLinkButton`) dentro de `CreditsList`.
- [x] 1.2 Actualizar `Dungeons/UI/credits_dialog.gd` para conectar la señal `pressed` de `PrivacyLinkButton` al método que ejecuta `OS.shell_open("https://arturo-jimenez.es/stoa-privacy-policy/")`.

## 2. Verificación e Integración con Escalado Adaptativo

- [x] 2.1 Verificar que el escalado de fuente adaptativo (`set_font_scale()`) en `credits_dialog.gd` detecta y escala adecuadamente las nuevas etiquetas y botón en `credits_dialog.tscn`.

## 3. Actualización de la Documentación del Repositorio

- [x] 3.1 Actualizar `README.md` y `CREDITS.md` añadiendo la referencia y enlace directo a la Política de Privacidad (`https://arturo-jimenez.es/stoa-privacy-policy/`).
