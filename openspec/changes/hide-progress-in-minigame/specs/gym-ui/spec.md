## Purpose

Define y garantiza las reglas de visibilidad y aprovechamiento de espacio vertical en la interfaz del Gimnasio Estoico durante las partidas.

## ADDED Requirements

### Requirement: Ocultación de tarjeta de progreso durante la partida de un mini-juego

El sistema debe ocultar la tarjeta superior de progreso de virtudes (`Progress`) mientras el usuario se encuentra dentro de la vista activa de un mini-juego (como la "Dicotomía del Control"), maximizando el espacio vertical utilizable en pantallas móviles.

#### Scenario: Inicio de partida de un mini-juego
- **WHEN** el usuario inicia un mini-juego desde el catálogo
- **THEN** la tarjeta de progreso se oculta (`visible = false`), dejando todo el espacio vertical para la vista del juego.

### Requirement: Restauración de visibilidad de tarjeta de progreso al salir del mini-juego

El sistema debe restaurar la visibilidad de la tarjeta de progreso de virtudes cuando el usuario sale de la vista de juego para regresar al catálogo o al cambiar de pestaña en el Gimnasio.

#### Scenario: Salida o cambio de pestaña
- **WHEN** el usuario pulsa en volver o cambia de pestaña desde el juego activo
- **THEN** la tarjeta de progreso de virtudes vuelve a estar visible (`visible = true`).
