## ADDED Requirements

### Requirement: Disposición libre de superposiciones para el botón de créditos

El botón de acceso al diálogo de créditos (`CreditsButton`, ` ℹ `) SHALL disponer de una separación o margen mínimo con respecto a los bordes de la pantalla y el botón flotante de configuración (`⚙`), de forma que permanezca completamente visible y cliqueable en todo momento.

#### Scenario: Visualización del botón de créditos en la pantalla principal o gimnasio
- **WHEN** la pantalla de inicio o gimnasio se carga y muestra la barra de controles superiores `TopControlsPanel`
- **THEN** el botón ` ℹ ` se renderiza sin oclusión por parte del botón flotante de configuración `⚙`
