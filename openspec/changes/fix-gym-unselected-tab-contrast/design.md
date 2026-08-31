## Context

Ver `proposal.md` para la motivación general del problema de legibilidad.

Actualmente en `Dungeons/gym.tscn`, los botones de pestaña (`PracticesTab`, `ChallengesTab`, `MinigamesTab`) utilizan como color de fuente inactivo (`font_color`) el color `Color(0.5451, 0.45098, 0.33333, 1)` (#8B7355), que es un tono café medio-claro. Al superponerse sobre el fondo `TabInactive` que tiene `bg_color = Color(0.96078, 0.96078, 0.94118, 0.55)` (un beige translúcido sobre la imagen del gimnasio), la relación de contraste resultante es de ~2.9:1, lo cual incumple las pautas de accesibilidad WCAG AA y perjudica la visibilidad en dispositivos móviles.

## Goals / Non-Goals

**Goals:**
- Ajustar las propiedades de color de fuente inactiva (`font_color` y `font_hover_color`) en `Dungeons/gym.tscn` para los nodos de pestañas (`PracticesTab`, `ChallengesTab`, `MinigamesTab`).
- Alcanzar una relación de contraste mínima de 7:1 (ampliamente superior a WCAG AA 4.5:1) mediante un tono marrón oscuro/tinta estoica (p. ej. `Color(0.24, 0.18, 0.12, 1)` / `#3D2E1E`).
- Mantener la armonía estética con la paleta de colores del juego y asegurar que la pestaña activa (relleno marrón oscuro con texto blanco) siga resaltando con claridad.

**Non-Goals:**
- Modificar la lógica de cambio de pestaña en `Dungeons/Scripts/gym.gd`.
- Rediseñar por completo el sistema de temas globales.

## Decisions

### Decisión 1: Oscurecer `font_color` y `font_hover_color` en las pestañas inactivas

**Alternativas consideradas:**
- *Alternativa A (Oscurecer el fondo `TabInactive`):* Haría que las pestañas inactivas parezcan botones activos oscuros, perdiendo el estado visual de "inactivo".
- *Alternativa B (Oscurecer el texto del botón inactivo - ELEGIDA):* Cambiar `font_color` de `Color(0.5451, 0.45098, 0.33333, 1)` a `Color(0.24, 0.18, 0.12, 1)` (#3D2E1E) y `font_hover_color` a `Color(0.15, 0.10, 0.05, 1)`. Esto mantiene la solapa/pestaña clara con un texto oscuro perfectamente legible, conservando el contraste respecto a la pestaña activa (que es un bloque relleno de marrón oscuro con texto blanco cálido).

### Decisión 2: Consistencia en los 3 botones de pestaña del Gimnasio

Aplicar la modificación a los 3 nodos de pestaña en `Dungeons/gym.tscn`:
1. `PracticesTab`
2. `ChallengesTab`
3. `MinigamesTab`

## Risks / Trade-offs

- [Riesgo] La pestaña inactiva podría competir visualmente si el texto es demasiado oscuro → *Mitigación*: El contraste de la pestaña activa se sostiene al tener el fondo completamente opaco marrón oscuro (`TabActive`) con texto off-white, manteniendo la jerarquía clara.
