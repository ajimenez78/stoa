## ADDED Requirements

### Requirement: Acceso directo a Créditos desde el menú de Configuración

El menú modal de configuración (`SettingsMenu`) SHALL incluir una sección o botón que permita abrir el diálogo de créditos y licencias directamente.

#### Scenario: Apertura de créditos desde Configuración
- **WHEN** el usuario presiona el botón "Créditos y Licencias" dentro del menú de configuración
- **THEN** se despliega el cuadro modal `CreditsDialog` sobre la interfaz activa
