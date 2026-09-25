## Purpose

Garantiza la presentación clara y accesible de la atribución de derechos de autor y créditos de licencias de terceros, adaptando la tipografía según las preferencias de accesibilidad del usuario.

## Requirements

### Requirement: Escalado adaptativo de fuente en el diálogo de créditos

El cuadro de diálogo de créditos (`CreditsDialog`) SHALL aplicar el factor de escalado de fuente activo seleccionado por el usuario en la interfaz principal tanto al inicializarse como cuando se actualiza dinámicamente el tamaño de la letra.

#### Scenario: Apertura del diálogo con escalado de fuente personalizado
- **WHEN** el usuario presiona el botón de información `(i)` habiendo ajustado previamente el tamaño de letra en la interfaz
- **THEN** el cuadro de diálogo de créditos se muestra renderizando sus elementos de texto (título, cuerpo, botones) ajustados proporcionalmente al factor de escala activo sin truncamiento de texto

#### Scenario: Ajuste dinámico de escala de fuente con el diálogo abierto
- **WHEN** se notifica un cambio en el factor de escalado de fuente global o se abre el diálogo de créditos
- **THEN** los controles de texto internos (`TitleLabel`, `BodyLabel`, `LinkButton`, `CloseButton`) recalculan e imponen su tamaño de fuente renderizado acorde al factor de escala seleccionado

### Requirement: Enlace accesible a la Política de Privacidad

El cuadro de diálogo `CreditsDialog` SHALL incorporar un apartado visible y accesible dedicado a la Política de Privacidad con un botón interactivo que permita al usuario consultar la URL externa oficial `https://arturo-jimenez.es/stoa-privacy-policy/`.

#### Scenario: Clic en el botón de política de privacidad
- **WHEN** el usuario presiona el botón "🌐 Ver Política de Privacidad" dentro del modal de créditos y licencias
- **THEN** la aplicación invoca el método `OS.shell_open()` abriendo la URL `https://arturo-jimenez.es/stoa-privacy-policy/` en el navegador web del sistema

#### Scenario: Escalado adaptativo de fuente en los controles de privacidad
- **WHEN** el cuadro de diálogo `CreditsDialog` aplica el factor de escalado de fuente activo
- **THEN** la etiqueta de categoría, la etiqueta descriptiva y el botón de enlace de la sección de Política de Privacidad recalculan e imponen su tamaño de fuente de manera proporcional al factor de escala global seleccionado

### Requirement: Disposición libre de superposiciones para el botón de créditos

El botón de acceso al diálogo de créditos (`CreditsButton`, ` ℹ `) SHALL disponer de una separación o margen mínimo con respecto a los bordes de la pantalla y el botón flotante de configuración (`⚙`), de forma que permanezca completamente visible y cliqueable en todo momento.

#### Scenario: Visualización del botón de créditos en la pantalla principal o gimnasio
- **WHEN** la pantalla de inicio o gimnasio se carga y muestra la barra de controles superiores `TopControlsPanel`
- **THEN** el botón ` ℹ ` se renderiza sin oclusión por parte del botón flotante de configuración `⚙`
