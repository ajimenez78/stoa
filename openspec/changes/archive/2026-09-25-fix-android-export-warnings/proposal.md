## Why

Durante la exportación o firmado de APKs para Android utilizando `apksigner` (Android SDK build-tools 36.1.0) bajo versiones recientes de OpenJDK/Java (Java 21+), la Máquina Virtual de Java emite advertencias relativas al acceso a métodos nativos restringidos (`java.lang.System::loadLibrary` por parte de `org.conscrypt.NativeLibraryUtil`). Estas advertencias advierten de futuros bloqueos en versiones posteriores del JDK.

## What Changes

- Configurar las opciones globales de la JVM o variables de entorno del pipeline de exportación (mediante `JAVA_TOOL_OPTIONS="--enable-native-access=ALL-UNNAMED"`) para otorgar acceso nativo a módulos no nombrados durante la fase de empaquetado y firmado de Android.
- Documentar el procedimiento y solución técnica en la documentación de exportación o scripts del proyecto.

## Capabilities

### New Capabilities
- `android-export-tooling`: Define las reglas y configuraciones necesarias para realizar exportaciones y empaquetados Android limpios de advertencias JVM.

## Impact

- Entorno de compilación/exportación Android (Godot export / `apksigner`).
- Documentación técnica y scripts de compilación.
