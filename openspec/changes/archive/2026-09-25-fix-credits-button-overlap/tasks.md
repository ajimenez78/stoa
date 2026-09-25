## 1. Ajuste de Layout y Márgenes de UI

- [x] 1.1 Modificar `Dungeons/home.tscn` y `Dungeons/gym.tscn` para incluir un margen a la derecha en `TopControlsPanel` de ~68px, evitando la superposición con el botón `⚙`.
- [x] 1.2 Modificar `UI/Settings/settings_menu.tscn` añadiendo una fila/botón "Créditos y Licencias" (`CreditsButton`).

## 2. Lógica e Integración

- [x] 2.1 Actualizar `UI/Settings/settings_menu.gd` para instanciar y abrir `credits_dialog.tscn` al pulsar el nuevo botón de Créditos en la ventana de Configuración.
- [x] 2.2 Verificar que el botón ` ℹ ` en `home.tscn` y `gym.tscn` se muestra completo a la izquierda de `⚙` y que ambos botones son accesibles independientemente.
