## Context

Ver `proposal.md` y `specs/android-export-tooling/spec.md`. Al ejecutar `apksigner` con Android SDK build-tools 36.1.0 bajo OpenJDK 21+, la JVM imprime advertencias debido a que `org.conscrypt.NativeLibraryUtil` invoca `java.lang.System::loadLibrary` en un módulo no nombrado sin permiso explícito de acceso nativo.

## Goals / Non-Goals

**Goals:**
- Proporcionar la solución para pasar `--enable-native-access=ALL-UNNAMED` a la JVM durante la exportación / firmado de APKs en Godot.
- Configurar la variable de entorno `JAVA_TOOL_OPTIONS` o el script wrapper de `apksigner` para silenciar la advertencia.

**Non-Goals:**
- Modificar el código fuente interno del motor Godot o del APK firmado.

## Decisions

### Decisión 1: Configuración vía `JAVA_TOOL_OPTIONS`

- **Enfoque:** Configurar la variable de entorno `JAVA_TOOL_OPTIONS="--enable-native-access=ALL-UNNAMED"` en el entorno de ejecución o script de exportación. La JVM detecta automáticamente esta variable al invocar `apksigner` o cualquier herramienta Java secundaria durante el build.

## Risks / Trade-offs

- **[Riesgo]** `JAVA_TOOL_OPTIONS` afecta a todas las ejecuciones Java de la sesión si se exporta globalmente en la shell.
  - **Mitigación:** Aplicarla de forma local al proceso de compilación/exportación de Android.
