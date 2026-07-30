# Mini-juegos del Gimnasio Estoico

Los mini-juegos son los ejercicios jugables del Gimnasio Estoico: ponen en
práctica un principio estoico concreto (la dicotomía del control, por ejemplo) y
entregan puntos de virtud al terminar.

El gimnasio no conoce ningún mini-juego en particular. Los lee de la base de
datos de misiones, los carga por su ruta y solo espera de ellos el contrato de
`Minigame`. Añadir uno nuevo son **dos pasos** y no obliga a tocar `gym.gd`.

## Paso 1: la escena del mini-juego

Crea en este directorio una escena cuya raíz tenga un script que herede de
`Minigame` (`minigame.gd`):

```gdscript
# Mini-juego de la premeditación: reconoce qué obstáculos puedes anticipar.
extends Minigame

const HITS_TO_WIN := 3

@export var answer_button: Button

var _hits := 0

func _ready() -> void:
	answer_button.pressed.connect(_on_answer_pressed)

# El gimnasio lo llama al abrir el mini-juego, y tú al rejugarlo.
func start() -> void:
	_hits = 0
	# Reinicia aquí el estado y la interfaz de la partida.

func _on_answer_pressed() -> void:
	_hits += 1
	if _hits < HITS_TO_WIN:
		return

	# Los puntos ganados, por virtud, y una línea que resuma la partida.
	finished.emit(Minigame.make_result(
		{"wisdom": 10, "temperance": 5},
		"%d de %d aciertos" % [_hits, HITS_TO_WIN],
	))
```

El contrato es corto:

| Miembro | Quién lo usa | Para qué |
| --- | --- | --- |
| `start()` | lo llama el gimnasio al abrir el mini-juego | prepara una partida nueva; redefínelo |
| `finished(result)` | lo emite el mini-juego | avisa de que la partida terminó y con qué resultado |
| `Minigame.make_result(rewards, summary)` | lo llama el mini-juego | construye el `result` que espera el gimnasio |

Sobre `result`:

- `rewards` son los puntos por virtud, con las claves de `Virtues.DATA`:
  `wisdom`, `justice`, `courage` y `temperance`. Un diccionario vacío significa
  «esta vez no ha ganado nada».
- `summary` es una línea corta que el gimnasio muestra en su aviso, por ejemplo
  `"4 de 5 aciertos"`.

Ten en cuenta que:

- La raíz **debe** heredar de `Minigame`, o el gimnasio fallará al instanciarla.
- El gimnasio aloja la escena en un contenedor y le pone las banderas de tamaño
  para que se estire, así que reparte el contenido con un contenedor hijo a todo
  el rectángulo (`anchors_preset = 15`), como hace `dichotomy_game.tscn`.
- Emite `finished` **una vez por partida**: el gimnasio anota cada emisión.
- Si ofreces un botón de rejugar, conéctalo a `start()` desde el propio
  mini-juego; el gimnasio no se mete en eso.
- El contenido (preguntas, situaciones, casos…) va en su propio JSON junto a la
  escena, como `dichotomy_situations.json`. Así se amplía sin tocar código.

## Paso 2: declararlo en la base de datos

Añade una entrada a la lista `minigames` de
[`../gym_missions.json`](../gym_missions.json):

```json
{
	"id": "premeditacion",
	"title": "La Premeditación",
	"description": "Anticipa los obstáculos del día para no perder la calma",
	"format": "3 situaciones",
	"virtues": ["wisdom", "temperance"],
	"scene": "res://Dungeons/Minigames/premeditation_game.tscn"
}
```

| Campo | Para qué sirve |
| --- | --- |
| `id` | identifica el mini-juego en el progreso guardado; no lo cambies una vez publicado |
| `title` | título de la tarjeta y de la cabecera al jugar |
| `description` | una línea en la tarjeta |
| `format` | pie izquierdo de la tarjeta: en qué consiste la partida («5 situaciones») |
| `virtues` | pie derecho de la tarjeta, **solo informativo**: los puntos reales son los de `rewards` |
| `scene` | ruta `res://` de la escena que se carga al pulsar la tarjeta |

Con eso, el mini-juego aparece en la pestaña «Mini-juegos» del gimnasio.

## Qué hace el gimnasio por ti

- Lista los mini-juegos como tarjetas (`MissionCard`) y abre el que se pulse.
- Instancia la escena, la estira, conecta `finished` y llama a `start()`.
- Al terminar, anota el resultado con
  `ProgressStore.register_minigame_result(id, rewards)` y refresca virtudes,
  nivel y tarjetas.
- Muestra un aviso según el caso: con los puntos ganados, «hoy ya habías ganado
  sus puntos» si repite, o una invitación a intentarlo de nuevo si `rewards`
  venía vacío.
- Descarta la partida al volver al catálogo. Cambiar de pestaña **no** la
  descarta: al volver sigue donde estaba.

Sobre los puntos: solo se entregan **la primera partida de cada día**; las demás
cuentan como práctica libre (`plays` sí sube). Cada virtud tiene un tope de
`ProgressStore.MAX_VIRTUE_POINTS` puntos.

## Piezas reutilizables

Si tu mini-juego es de arrastrar y soltar, ya está resuelto con la API nativa de
Godot, que funciona igual con ratón y con el dedo (importante en Android e iOS):

- **`drop_zone.tscn` / `DropZone`** — zona de destino. Ponle `title` y
  `highlight_color` en la instancia; se resalta mientras haya un arrastre en
  marcha y emite `item_dropped(item: Control)` con lo que recibe. Acepta
  cualquier `Control`, así que sirve para cualquier mini-juego.
- **`situation_card.tscn` / `SituationCard`** — tarjeta arrastrable de la
  dicotomía. Se entrega a sí misma como dato del arrastre y genera su vista
  previa centrada en el cursor. Úsala como modelo si necesitas otra arrastrable:
  lo único imprescindible es `_get_drag_data()` devolviendo el propio nodo y
  llamando a `set_drag_preview()`.

Para el estilo visual, copia los colores y tipografías de
`dichotomy_game.tscn`: es el mismo lenguaje que el resto del gimnasio y del
Hogar.
