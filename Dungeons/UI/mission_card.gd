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
var _last_scale_factor: float = 1.0

func _ready() -> void:
	resized.connect(_on_resized)

func _on_resized() -> void:
	if is_inside_tree():
		update_adaptive_minimum_size(_last_scale_factor)

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
	update_adaptive_minimum_size()

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
	update_adaptive_minimum_size()

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

func update_adaptive_minimum_size(scale_factor: float = 1.0) -> void:
	_last_scale_factor = scale_factor
	var base_min_h := int(round(60 * scale_factor))
	if is_inside_tree() and size.x > 50 and has_node("Margin"):
		var margin := $Margin as MarginContainer
		if margin:
			custom_minimum_size.y = 0
			var content_min_h := int(margin.get_combined_minimum_size().y)
			custom_minimum_size.y = max(base_min_h, content_min_h)
	else:
		custom_minimum_size.y = base_min_h
