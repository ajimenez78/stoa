# Zona a la que se arrastran elementos en un mini-juego. Se resalta mientras hay
# un arrastre en marcha y avisa de lo que recibe.
class_name DropZone extends PanelContainer

signal item_dropped(item: Control)

@export var title_label: Label
@export var title := ""
# Color con el que se resalta la zona mientras se arrastra algo.
@export var highlight_color := Color(0.5451, 0.45098, 0.33333)

var _idle_style: StyleBox
var _active_style: StyleBox
var _last_scale_factor: float = 1.0

func _ready() -> void:
	title_label.text = title

	_idle_style = get_theme_stylebox("panel")
	var active := _idle_style.duplicate() as StyleBoxFlat
	active.border_color = highlight_color
	active.bg_color = Color(highlight_color, 0.12)
	_active_style = active
	resized.connect(_on_resized)
	update_adaptive_minimum_size()

func _on_resized() -> void:
	if is_inside_tree():
		update_adaptive_minimum_size(_last_scale_factor)

func update_adaptive_minimum_size(scale_factor: float = 1.0) -> void:
	_last_scale_factor = scale_factor
	var base_min_h := int(round(48 * scale_factor))
	if is_inside_tree() and size.x > 50 and has_node("Margin"):
		var margin := $Margin as MarginContainer
		if margin:
			custom_minimum_size.y = 0
			var content_min_h := int(margin.get_combined_minimum_size().y)
			custom_minimum_size.y = max(base_min_h, content_min_h)
	else:
		custom_minimum_size.y = base_min_h

# Godot avisa a todos los controles cuando empieza y termina un arrastre.
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_DRAG_BEGIN:
			add_theme_stylebox_override("panel", _active_style)
		NOTIFICATION_DRAG_END:
			add_theme_stylebox_override("panel", _idle_style)

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Control

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	item_dropped.emit(data)
