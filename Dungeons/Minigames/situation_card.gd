# Situación arrastrable del mini-juego de la dicotomía del control.
class_name SituationCard extends PanelContainer

@export var text_label: Label

var situation: Dictionary

func setup(new_situation: Dictionary) -> void:
	situation = new_situation
	text_label.text = str(new_situation.get("text", ""))

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
