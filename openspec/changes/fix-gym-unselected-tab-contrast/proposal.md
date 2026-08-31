## Why

En la pantalla del Gimnasio Estoico, los textos de las pestañas inactivas o no seleccionadas ("Prácticas diarias", "Retos Semanales", "Mini-juegos") tienen un contraste insuficiente con el fondo beige translúcido y la imagen de fondo. Esto dificulta significativamente la legibilidad, especialmente en dispositivos móviles con pantallas pequeñas o con reflejos ambientales.

## What Changes

- Incrementar el contraste visual de las pestañas no seleccionadas en el gimnasio (`Dungeons/gym.tscn`).
- Ajustar el color del texto inactivo (`font_color`) y en estado hover (`font_hover_color`) para que tenga una relación de contraste adecuada (mínimo WCAG AA).
- Asegurar que la distinción entre la pestaña activa y las inactivas siga siendo clara y visualmente coherente con el estilo estético estoico del juego.

## Capabilities

### New Capabilities
- `gym-ui`: Requisitos de accesibilidad, legibilidad y contraste visual para la interfaz del Gimnasio Estoico.

### Modified Capabilities
<!-- N/A -->

## Impact

- `Dungeons/gym.tscn`: Modificación de las propiedades de color de fuente y estilo de los nodos de pestaña (`PracticesTab`, `ChallengesTab`, `MinigamesTab`) y subrecursos asociados.
- Accesibilidad visual y UX en dispositivos móviles mejoradas.
