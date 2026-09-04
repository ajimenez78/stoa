## Why

El juego utiliza la pista musical "Volviendo al Hogar" obtenida bajo la licencia gratuita de FiftySounds. La licencia de uso gratuito exige expresamente la atribución del autor y la fuente tanto en la documentación como en el propio juego. Cumplir con este requisito garantiza el cumplimiento legal y reconoce adecuadamente la autoría de los recursos de terceros.

## What Changes

- **Atribución en Documentación**:
  - Actualización de `README.md` con una sección dedicada a Créditos y Licencias de terceros.
  - Creación de un archivo `CREDITS.md` en la raíz del repositorio para centralizar la información de licencias y atribuciones.
- **Interfaz de Créditos In-Game**:
  - Creación de un componente reutilizable de diálogo/modal de créditos (`credits_dialog.tscn`).
  - Adición de un botón de Créditos `(i)` en las pantallas del juego (como el Hogar/Gimnasio) para abrir la ventana con la información de la canción ("Volviendo al Hogar") y el enlace/mención a FiftySounds.

## Capabilities

### New Capabilities
- `credits-and-attribution`: Define los requisitos para la presentación y disponibilidad de las atribuciones de licencias y créditos dentro de la UI del juego y en los archivos del repositorio.

### Modified Capabilities
(Ninguna)

## Impact

- Modificación de `README.md` y creación de `CREDITS.md`.
- Creación de nuevo componente UI `res://Dungeons/UI/credits_dialog.tscn` y script asociado `credits_dialog.gd`.
- Integración del botón de créditos en las vistas de interfaz existentes.
