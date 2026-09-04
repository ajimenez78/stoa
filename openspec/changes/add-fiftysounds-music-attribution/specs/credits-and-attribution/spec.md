## Purpose

Proporciona un mecanismo accesible e interactivo para visualizar las atribuciones de derechos de autor y licencias de recursos de terceros utilizados en Stoa.

## ADDED Requirements

### Requirement: Repository Credits Documentation
El repositorio del proyecto DEBE (MUST) incluir la atribución explícita de la pista musical "Volviendo al Hogar" de FiftySounds en la documentación principal.

#### Scenario: Visualización de atribución en README
- **WHEN** un desarrollador o usuario consulta el archivo `README.md`
- **THEN** encuentra una sección de Créditos con el título de la obra "Volviendo al Hogar" y el enlace a FiftySounds.

#### Scenario: Registro de licencias en CREDITS.md
- **WHEN** un desarrollador o auditor revisa el archivo `CREDITS.md`
- **THEN** se muestra la lista detallada de recursos de terceros y sus términos de licencia correspondientes.

### Requirement: In-Game Credits Dialog
El juego DEBE (MUST) incluir una ventana o diálogo accesible desde la interfaz que muestre la atribución de la música de fondo.

#### Scenario: Apertura del diálogo de créditos
- **WHEN** el jugador pulsa el botón de Créditos `(i)` en la interfaz del juego
- **THEN** se muestra una ventana modal emergente con el nombre de la obra "Volviendo al Hogar", la autoría de FiftySounds y la indicación de su licencia gratuita.

#### Scenario: Cierre del diálogo de créditos
- **WHEN** el jugador pulsa el botón "Cerrar" o la `X` del diálogo de créditos
- **THEN** la ventana modal se cierra y el jugador regresa a la pantalla anterior del juego sin interrumpir su progreso.
