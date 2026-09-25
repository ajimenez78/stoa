## Why

En las pantallas principales (`home.tscn` y `gym.tscn`), el botón de créditos ` ℹ ` situado a la derecha del panel superior de controles (`TopControlsPanel`) queda tapado por el botón flotante de configuración `⚙` (`SettingsMenu`, renderizado en un `CanvasLayer` superior con margen derecho de 16px). Esto impide que el usuario vea o pueda pulsar el botón de créditos ` ℹ `.

## What Changes

- **Ajuste de margen en `TopControlsPanel`**: Aplicar un margen a la derecha en la disposición de `TopControlsPanel` (o dentro de sus contenedores contenedores en `home.tscn`, `gym.tscn` y `stoa.tscn`) para desplazar la barra de controles a la izquierda del botón de configuración `⚙`, garantizando que el botón de créditos ` ℹ ` sea plenamente visible e interactivo.
- **Acceso directo desde Configuración**: Incluir un botón "Créditos y Licencias" dentro de la propia ventana modal de `settings_menu.tscn` para poder abrir el diálogo de créditos también desde la pantalla de configuración.

## Capabilities

### Modified Capabilities
- `credits-and-attribution`: Garantizar que el botón de acceso al diálogo de créditos no sufra superposiciones por otros elementos de la interfaz.
- `settings-menu`: Garantizar la coexistencia armónica de la barra de controles superiores y el botón flotante de ajustes.

## Impact

- `Dungeons/home.tscn`, `Dungeons/gym.tscn`, `Dungeons/stoa.tscn`: Ajuste de márgenes/layout en `TopControlsPanel`.
- `UI/Settings/settings_menu.tscn` y `UI/Settings/settings_menu.gd`: Integración de un botón adicional para abrir el modal de créditos.
