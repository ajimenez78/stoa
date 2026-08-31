## Why

En la pantalla del Gimnasio Estoico, al iniciar un juego activo (como el mini-juego de "Dicotomía del Control"), la tarjeta superior de progreso de virtudes (`Progress`) permanece visible en la columna vertical. En dispositivos móviles con pantallas compactas, esto reduce drásticamente el espacio vertical disponible para el área de juego, haciendo que las tarjetas de situaciones y las zonas de soltado se vean comprimidas y casi no haya espacio visible.

## What Changes

- Ocultar la barra y tarjeta de progreso de virtudes (`Progress`) cuando se entra en el modo de juego de un mini-juego (`minigame_play`).
- Restaurar la visibilidad de la tarjeta de progreso al salir del mini-juego (al pulsar volver o al completar la partida) o al cambiar a otras pestañas.
- Ganar espacio vertical significativo para mejorar la jugabilidad y visibilidad en dispositivos móviles durante la partida.

## Capabilities

### New Capabilities
- `gym-ui`: Reglas de visibilidad de los paneles de encabezado y adaptabilidad de espacio durante la ejecución de mini-juegos.

### Modified Capabilities
<!-- N/A -->

## Impact

- `Dungeons/gym.tscn`: Exposición/exportación del nodo `Progress` (o `progress_panel`).
- `Dungeons/Scripts/gym.gd`: Lógica para alternar `progress_panel.visible` al iniciar (`_open_minigame`) y finalizar/salir (`_show_minigame_list`, `_show_panel`) de un mini-juego.
- Mejora de la experiencia de usuario (UX) en el mini-juego de Dicotomía del Control y futuros mini-juegos en pantallas móviles.
