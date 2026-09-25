## Purpose

Establece los requisitos y configuraciones del entorno de herramientas para la exportación y empaquetado seguro y limpio de ejecutables Android.

## ADDED Requirements

### Requirement: Supresión de advertencias JVM de acceso nativo restringido

El entorno de compilación y empaquetado Android SHALL ejecutar las herramientas de firmado de APK (`apksigner`) habilitando el acceso nativo a módulos no nombrados para evitar advertencias y bloqueos de la JVM.

#### Scenario: Ejecución de apksigner durante el firmado de la APK
- **WHEN** el proceso de exportación o firmado de Android invoca `apksigner` en entornos con OpenJDK/Java 21+
- **THEN** las banderas JVM `--enable-native-access=ALL-UNNAMED` se pasan a la JVM suprimiendo las advertencias relativas a `java.lang.System::loadLibrary`
