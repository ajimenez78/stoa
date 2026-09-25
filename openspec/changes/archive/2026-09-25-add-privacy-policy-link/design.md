## Context

Ver `proposal.md` y `specs/credits-and-attribution/spec.md`. El juego está desarrollado en Godot 4 y utiliza componentes Control en `Dungeons/UI/credits_dialog.tscn` con soporte para escalado adaptativo de fuentes mediante recolección recursiva de nodos (`_cache_base_font_sizes`).

Actualmente, el modal de créditos solo contiene atribución musical. Se requiere integrar la sección de Política de Privacidad con el enlace `https://arturo-jimenez.es/stoa-privacy-policy/`.

## Goals / Non-Goals

**Goals:**
- Añadir la sección de Política de Privacidad dentro de `credits_dialog.tscn` manteniendo el estilo estético del modal.
- Conectar el evento de clic del botón a `OS.shell_open("https://arturo-jimenez.es/stoa-privacy-policy/")`.
- Garantizar que los nuevos elementos se integren automáticamente con la caché de tamaños de fuente y responsive font scaling.
- Actualizar la documentación en `README.md` y `CREDITS.md`.

**Non-Goals:**
- Crear modales o escenas secundarias separadas exclusivamente para privacidad.
- Modificar el sistema global de navegación o menús fuera de `CreditsDialog` y archivos de documentación.

## Decisions

### Decisión 1: Integración de la sección en `CreditsList` dentro de `credits_dialog.tscn`

- **Enfoque:** Añadir dentro del contenedor vertical `CreditsList` una separación visual (`HSeparator` o espacio), una etiqueta de categoría `PrivacyCategoryLabel`, una etiqueta descriptiva `PrivacyDescriptionLabel` y un botón `PrivacyLinkButton`.
- **Alternativas consideradas:** 
  - *Nuevo botón independiente en `home.tscn` y `gym.tscn`:* Descartado para mantener la barra superior limpia y concentrar la información legal y de licencias en un único modal reutilizable.

### Decisión 2: Cacheo y Escalado de Fuentes

- **Enfoque:** Dado que `credits_dialog.gd` utiliza la función `_cache_base_font_sizes(self)` que recorre recursivamente todos los nodos `Control` del árbol, los nuevos elementos de texto y botón obtendrán automáticamente su tamaño base y se escalarán con `set_font_scale(scale_factor)` sin necesidad de código de escalado manual adicional.

### Decisión 3: Enlace en Documentación

- **Enfoque:** Añadir una sección o viñeta explícita en `CREDITS.md` y `README.md` apuntando a `https://arturo-jimenez.es/stoa-privacy-policy/`.

## Risks / Trade-offs

- **[Riesgo]** Aumento de la altura del contenido dentro del `ScrollContainer` en pantallas móviles de menor resolución.
  - **Mitigación:** `ScrollContainer` en `credits_dialog.tscn` ya gestiona el desplazamiento vertical para prevenir desbordamientos de pantalla.
