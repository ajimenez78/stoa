## Purpose

Garantiza la presentación clara y accesible de la atribución de derechos de autor y créditos de licencias de terceros, adaptando la tipografía según las preferencias de accesibilidad del usuario.

## ADDED Requirements

### Requirement: Escalado adaptativo de fuente en el diálogo de créditos

El cuadro de diálogo de créditos (`CreditsDialog`) SHALL aplicar el factor de escalado de fuente activo seleccionado por el usuario en la interfaz principal tanto al inicializarse como cuando se actualiza dinámicamente el tamaño de la letra.


#### Scenario: Apertura del diálogo con escalado de fuente personalizado
- **WHEN** el usuario presiona el botón de información `(i)` habiendo ajustado previamente el tamaño de letra en la interfaz
- **THEN** el cuadro de diálogo de créditos se muestra renderizando sus elementos de texto (título, cuerpo, botones) ajustados proporcionalmente al factor de escala activo sin truncamiento de texto

#### Scenario: Ajuste dinámico de escala de fuente con el diálogo abierto
- **WHEN** se notifica un cambio en el factor de escalado de fuente global o se abre el diálogo de créditos
- **THEN** los controles de texto internos (`TitleLabel`, `BodyLabel`, `LinkButton`, `CloseButton`) recalculan e imponen su tamaño de fuente renderizado acorde al factor de escala seleccionado
