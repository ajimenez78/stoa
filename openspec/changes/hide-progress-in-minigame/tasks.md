## 1. Exportación y Referencia del Nodo de Progreso

- [x] 1.1 Declarar `@export var progress_panel: Control` en `Dungeons/Scripts/gym.gd` y vincular la ruta del nodo `UI/Layout/Column/Progress` en `Dungeons/gym.tscn`, verificando que el script reconozca la referencia al nodo.

## 2. Gestión de Visibilidad en el Gimnasio

- [x] 2.1 Actualizar `_open_minigame()` en `Dungeons/Scripts/gym.gd` para establecer `progress_panel.visible = false` al iniciar la vista de juego, y verificar que la tarjeta se oculta.
- [x] 2.2 Actualizar `_show_minigame_list()` y `_show_panel()` en `Dungeons/Scripts/gym.gd` para restaurar `progress_panel.visible = true`, y verificar que la tarjeta vuelve a ser visible al salir del juego o cambiar de pestaña.

## 3. Verificación de Integración

- [x] 3.1 Probar la entrada al mini-juego "Dicotomía del Control" para confirmar la ganancia de espacio vertical en pantalla y la correcta legibilidad de la lista de situaciones.
