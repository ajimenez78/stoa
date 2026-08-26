# Tarjeta de una misión del gimnasio: una práctica diaria o un mini-juego. Al
# pulsarla se abre la misión correspondiente.
class_name MissionCard extends Button

const DONE_TEXT := "Completada hoy"
const DONE_COLOR := Color(0.15294, 0.68235, 0.37647)
const SUGGESTED_TEXT := "El mentor la sugiere"
const REWARDED_TEXT := "Ya has ganado hoy sus puntos"
const BROWN := Color(0.5451, 0.45098, 0.33333)

@export var title_label: Label
@export var description_label: Label
@export var meta_label: Label
@export var virtue_label: Label
@export var status_label: Label

var mission: Dictionary

# Práctica diaria: muestra su duración y la virtud que cultiva. `suggested`
# marca la práctica que cultiva la virtud más descuidada.
func setup_practice(practice: Dictionary, done_today: bool, suggested: bool) -> void:
	var virtue := str(practice.get("virtue", ""))
	_fill(practice, str(practice.get("duration", "")))
	virtue_label.text = "%s +%d" % [
		Virtues.display_name(virtue), int(practice.get("points", 0)),
	]
	virtue_label.add_theme_color_override("font_color", Virtues.color(virtue))

	if done_today:
		_set_status(DONE_TEXT, DONE_COLOR)
	elif suggested:
		_set_status(SUGGESTED_TEXT, BROWN)
	# Una práctica ya hecha se atenúa; el mini-juego, no, porque se puede seguir
	# jugando aunque ya haya puntuado.
	modulate.a = 0.75 if done_today else 1.0

# Mini-juego: muestra su formato y las virtudes que ejercita.
func setup_minigame(minigame: Dictionary, rewarded_today: bool) -> void:
	_fill(minigame, str(minigame.get("format", "")))

	var names: PackedStringArray = []
	for virtue: String in minigame.get("virtues", []):
		names.append(Virtues.display_name(virtue))
	virtue_label.text = " y ".join(names)
	virtue_label.add_theme_color_override("font_color", BROWN)

	if rewarded_today:
		_set_status(REWARDED_TEXT, BROWN)

func _fill(new_mission: Dictionary, meta: String) -> void:
	mission = new_mission
	title_label.text = str(new_mission.get("title", ""))
	description_label.text = str(new_mission.get("description", ""))
	meta_label.text = meta
	status_label.visible = false

func _set_status(status_text: String, color: Color) -> void:
	status_label.visible = true
	status_label.text = status_text
	status_label.add_theme_color_override("font_color", color)
