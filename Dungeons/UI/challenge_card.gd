# Tarjeta de un reto semanal del gimnasio: muestra los días ya apuntados y
# permite registrar el de hoy.
class_name ChallengeCard extends PanelContainer

signal day_registered(challenge: Dictionary)

const REGISTER_TEXT := "Apuntar el día de hoy"
const REGISTERED_TEXT := "Apuntado hoy · vuelve mañana"
const COMPLETED_TEXT := "Reto conseguido esta semana"
const LOCKED_TEXT := "Se desbloquea en el nivel %d"

@export var title_label: Label
@export var reward_label: Label
@export var description_label: Label
@export var action_label: Label
@export var progress_bar: ProgressBar
@export var progress_label: Label
@export var register_button: Button

var challenge: Dictionary
var _last_scale_factor: float = 1.0

func _ready() -> void:
	register_button.pressed.connect(_on_register_pressed)
	resized.connect(_on_resized)

func _on_resized() -> void:
	if is_inside_tree():
		update_adaptive_minimum_size(_last_scale_factor)

# Rellena la tarjeta con un reto y su estado en la semana en curso. `unlocked`
# indica si el nivel del aprendiz alcanza el exigido por el reto.
func setup(new_challenge: Dictionary, state: Dictionary, unlocked: bool) -> void:
	challenge = new_challenge

	var virtue := str(new_challenge.get("virtue", ""))
	var target_days := int(new_challenge.get("target_days", 1))
	var days: int = (state["days"] as Array).size()
	var completed: bool = days >= target_days

	title_label.text = str(new_challenge.get("title", ""))
	description_label.text = str(new_challenge.get("description", ""))
	action_label.text = "Cada día: %s" % new_challenge.get("daily_action", "")

	reward_label.text = "+%d %s" % [
		int(new_challenge.get("points", 0)), Virtues.display_name(virtue),
	]
	reward_label.add_theme_color_override("font_color", Virtues.color(virtue))

	progress_bar.max_value = target_days
	progress_bar.value = days
	progress_label.text = "%d de %d días" % [mini(days, target_days), target_days]

	var fill := progress_bar.get_theme_stylebox("fill").duplicate() as StyleBoxFlat
	fill.bg_color = Virtues.color(virtue)
	progress_bar.add_theme_stylebox_override("fill", fill)

	register_button.disabled = not unlocked or completed or state["done_today"]
	if not unlocked:
		register_button.text = LOCKED_TEXT % int(new_challenge.get("required_level", 1))
	elif completed:
		register_button.text = COMPLETED_TEXT
	elif state["done_today"]:
		register_button.text = REGISTERED_TEXT
	else:
		register_button.text = REGISTER_TEXT

	modulate.a = 0.7 if not unlocked else 1.0
	update_adaptive_minimum_size()

func update_adaptive_minimum_size(scale_factor: float = 1.0) -> void:
	_last_scale_factor = scale_factor
	var base_min_h := int(round(72 * scale_factor))
	if is_inside_tree() and size.x > 50 and has_node("Margin"):
		var margin := $Margin as MarginContainer
		if margin:
			custom_minimum_size.y = 0
			var content_min_h := int(margin.get_combined_minimum_size().y)
			custom_minimum_size.y = max(base_min_h, content_min_h)
	else:
		custom_minimum_size.y = base_min_h

func _on_register_pressed() -> void:
	day_registered.emit(challenge)
