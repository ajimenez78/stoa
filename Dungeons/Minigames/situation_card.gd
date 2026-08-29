# Situación arrastrable del mini-juego de la dicotomía del control.
class_name SituationCard extends PanelContainer

@export var text_label: Label

var situation: Dictionary
var _last_scale_factor: float = 1.0

func _ready() -> void:
	resized.connect(_on_resized)

func _on_resized() -> void:
	if is_inside_tree():
		update_adaptive_minimum_size(_last_scale_factor)

func setup(new_situation: Dictionary) -> void:
	situation = new_situation
	text_label.text = str(new_situation.get("text", ""))
	update_adaptive_minimum_size()

func update_adaptive_minimum_size(scale_factor: float = 1.0) -> void:
	_last_scale_factor = scale_factor
	var base_min_h := int(round(40 * scale_factor))
	if is_inside_tree() and size.x > 50 and has_node("Margin"):
		var margin := $Margin as MarginContainer
		if margin:
			custom_minimum_size.y = 0
			var content_min_h := int(margin.get_combined_minimum_size().y)
			custom_minimum_size.y = max(base_min_h, content_min_h)
	else:
		custom_minimum_size.y = base_min_h

# Godot lo llama al empezar a arrastrar la tarjeta, con el ratón o con el dedo.
func _get_drag_data(_at_position: Vector2) -> Variant:
	set_drag_preview(_make_preview())
	return self

# Copia de la tarjeta que acompaña al cursor, centrada sobre él.
func _make_preview() -> Control:
	var copy: Control = duplicate()
	copy.custom_minimum_size = size
	copy.position = -0.5 * size
	copy.modulate.a = 0.9

	var preview := Control.new()
	preview.add_child(copy)
	return preview
