## 1. Configuración de Herramientas de Exportación

- [x] 1.1 Establecer la variable `JAVA_TOOL_OPTIONS="--enable-native-access=ALL-UNNAMED"` en el entorno de desarrollo/exportación para que `apksigner` se ejecute sin advertencias de acceso nativo JVM.
- [x] 1.2 Verificar la exportación y firmado de la APK comprobando que la advertencia de `java.lang.System::loadLibrary` en `apksigner.jar` ya no aparece en la salida de consola.
