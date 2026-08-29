# Tarjeta seleccionable con una de las reflexiones guiadas del diario estoico.
class_name PromptCard extends Button

@export var question_label: Label
@export var description_label: Label

var prompt: Dictionary
var _last_scale_factor: float = 1.0

func _ready() -> void:
	resized.connect(_on_resized)

func _on_resized() -> void:
	if is_inside_tree():
		update_adaptive_minimum_size(_last_scale_factor)

# Rellena la tarjeta con los datos de una reflexión guiada.
func setup(new_prompt: Dictionary) -> void:
	prompt = new_prompt
	question_label.text = new_prompt.get("question", "")
	description_label.text = new_prompt.get("description", "")
	update_adaptive_minimum_size()

func update_adaptive_minimum_size(scale_factor: float = 1.0) -> void:
	_last_scale_factor = scale_factor
	var base_min_h := int(round(90 * scale_factor))
	if is_inside_tree() and size.x > 50 and has_node("Margin"):
		var margin := $Margin as MarginContainer
		if margin:
			custom_minimum_size.y = 0
			var content_min_h := int(margin.get_combined_minimum_size().y)
			custom_minimum_size.y = max(base_min_h, content_min_h)
	else:
		custom_minimum_size.y = base_min_h
