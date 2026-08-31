## Context

Ver `proposal.md` para la motivación general respecto a la falta de espacio vertical en pantallas móviles durante los mini-juegos.

En `Dungeons/gym.tscn`, el contenedor `UI/Layout/Column` organiza verticalmente los elementos del Gimnasio:
1. `TopControlsPanel`
2. `Hero` (Título y subtítulo)
3. `Progress` (Tarjeta de progreso de nivel, barra y cuadrícula 2x2 de virtudes)
4. `Tabs` (Pestañas de navegación)
5. `Content` (Paneles de Prácticas, Retos o Mini-juegos)

La tarjeta `Progress` ocupa una altura fija considerable. Durante la interacción en mini-juegos (como "Dicotomía del Control"), las zonas de soltado y la lista de situaciones compiten por el espacio restante de la pantalla.

## Goals / Non-Goals

**Goals:**
- Exportar la referencia al nodo `Progress` en `gym.gd` (`@export var progress_panel: Control`).
- Ocultar `progress_panel` al ingresar a un mini-juego (`_open_minigame`).
- Restaurar `progress_panel.visible = true` al volver al catálogo (`_show_minigame_list`) o al cambiar de pestaña (`_show_panel`).

**Non-Goals:**
- Ocultar la barra de progreso en otras secciones que no sean la vista de juego activo.
- Alterar la disposición o lógica interna del mini-juego `Dicotomía del Control`.

## Decisions

### Decisión 1: Alternar `progress_panel.visible` desde la lógica central del Gimnasio (`gym.gd`)

**Alternativas consideradas:**
- *Alternativa A (Modificar cada mini-juego individualmente):* Cada script de mini-juego tendría que buscar el nodo padre `Progress` y modificar su visibilidad. Esto acoplaría los mini-juegos a la estructura del Gimnasio.
- *Alternativa B (Gestión centralizada en `gym.gd` - ELEGIDA):* `gym.gd` ya gestiona las transiciones entre la lista de mini-juegos (`minigame_list`) y la vista de juego (`minigame_play`). Ocultar `progress_panel` dentro de `_open_minigame` y restaurarlo en `_show_minigame_list` y `_show_panel` centraliza el control de forma limpia.

## Risks / Trade-offs

- [Riesgo] El usuario no puede ver su barra de nivel mientras juega el mini-juego → *Mitigación*: Durante la partida el foco es la mecánica del juego; los puntos de nivel y recompensas se muestran al terminar en el aviso (toast) y al regresar a la lista de mini-juegos.
