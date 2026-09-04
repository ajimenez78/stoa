# Diálogo modal de Créditos y Atribuciones de licencias de terceros.
class_name CreditsDialog extends Control

@onready var close_button: Button = %CloseButton
@onready var link_button: Button = %LinkButton
@onready var backdrop: ColorRect = %Backdrop

var _base_font_sizes: Dictionary = {}
var _current_scale_factor: float = 1.0

func _ready() -> void:
	if close_button:
		close_button.pressed.connect(_on_close_pressed)
	if link_button:
		link_button.pressed.connect(_on_link_pressed)
	if backdrop:
		backdrop.gui_input.connect(_on_backdrop_gui_input)

	_cache_base_font_sizes(self)
	if _current_scale_factor != 1.0:
		_apply_font_scale()

func set_font_scale(scale_factor: float) -> void:
	_current_scale_factor = scale_factor
	if is_node_ready():
		_apply_font_scale()

func _cache_base_font_sizes(node: Node) -> void:
	for child in node.get_children():
		if child is Control and child != close_button:
			if not _base_font_sizes.has(child):
				var base_size := (child as Control).get_theme_font_size("font_size")
				if base_size > 0:
					_base_font_sizes[child] = base_size
		_cache_base_font_sizes(child)

func _apply_font_scale() -> void:
	for control in _base_font_sizes.keys():
		if is_instance_valid(control):
			var base_size: int = _base_font_sizes[control]
			var scaled_size := int(round(base_size * _current_scale_factor))
			(control as Control).add_theme_font_size_override("font_size", scaled_size)

func _on_close_pressed() -> void:
	hide()

func _on_link_pressed() -> void:
	OS.shell_open("https://www.fiftysounds.com/es/")

func _on_backdrop_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		hide()

func open() -> void:
	show()
