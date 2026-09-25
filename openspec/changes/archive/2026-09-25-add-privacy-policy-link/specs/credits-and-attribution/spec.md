## ADDED Requirements

### Requirement: Enlace accesible a la Política de Privacidad

El cuadro de diálogo `CreditsDialog` SHALL incorporar un apartado visible y accesible dedicado a la Política de Privacidad con un botón interactivo que permita al usuario consultar la URL externa oficial `https://arturo-jimenez.es/stoa-privacy-policy/`.

#### Scenario: Clic en el botón de política de privacidad
- **WHEN** el usuario presiona el botón "🌐 Ver Política de Privacidad" dentro del modal de créditos y licencias
- **THEN** la aplicación invoca el método `OS.shell_open()` abriendo la URL `https://arturo-jimenez.es/stoa-privacy-policy/` en el navegador web del sistema

#### Scenario: Escalado adaptativo de fuente en los controles de privacidad
- **WHEN** el cuadro de diálogo `CreditsDialog` aplica el factor de escalado de fuente activo
- **THEN** la etiqueta de categoría, la etiqueta descriptiva y el botón de enlace de la sección de Política de Privacidad recalculan e imponen su tamaño de fuente de manera proporcional al factor de escala global seleccionado
