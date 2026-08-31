## Purpose

Define y garantiza los estándares de legibilidad, contraste visual y respuesta táctil para la interfaz de pestañas en el Gimnasio Estoico.

## ADDED Requirements

### Requirement: Contraste alto en pestañas inactivas del Gimnasio

El sistema debe presentar las pestañas inactivas o no seleccionadas del Gimnasio Estoico ("Prácticas Diarias", "Retos Semanales", "Mini-juegos") con un color de fuente y fondo de suficiente contraste (mínimo WCAG AA 4.5:1) para garantizar su clara legibilidad en pantallas de dispositivos móviles.

#### Scenario: Visualización de pestañas no seleccionadas
- **WHEN** el usuario visualiza la pantalla del Gimnasio Estoico en cualquier dispositivo
- **THEN** las etiquetas de las pestañas que no están seleccionadas se muestran con un color oscuro de alto contraste que facilita su lectura sobre el fondo.

### Requirement: Diferenciación clara entre pestaña activa e inactiva

El sistema debe mantener una diferenciación visual evidente e intuitiva entre la pestaña seleccionada (activa) y las pestañas no seleccionadas (inactivas).

#### Scenario: Selección y cambio de pestaña
- **WHEN** el usuario pulsa sobre una pestaña inactiva
- **THEN** la pestaña seleccionada resalta con el fondo activo y texto claro, mientras que las otras pestañas adoptan el estilo inactivo con texto oscuro legible de alto contraste.
