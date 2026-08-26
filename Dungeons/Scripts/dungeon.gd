class_name Dungeon extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		_handle_exit()

func _notification(what: int) -> void:
	if what == NOTIFICATION_READY:
		_init_dungeon_bg()
	elif what == NOTIFICATION_WM_GO_BACK_REQUEST || what == NOTIFICATION_WM_CLOSE_REQUEST:
		_handle_exit()

func _on_back_button_pressed() -> void:
	_handle_exit()

func _handle_exit() -> void:
	LevelManager.exit_dungeon()

func _init_dungeon_bg() -> void:
	var bg = get_node_or_null("UI/Background")
	if bg == null:
		bg = get_node_or_null("UI/Sprite2D")
	
	if bg and bg is Sprite2D:
		_scale_bg_to_viewport(bg)
		get_viewport().size_changed.connect(func(): _scale_bg_to_viewport(bg))

func _scale_bg_to_viewport(bg: Sprite2D) -> void:
	if not bg or not bg.texture:
		return
	var vp_size = bg.get_viewport().get_visible_rect().size
	var tex_size = bg.texture.get_size()
	bg.global_position = vp_size / 2.0
	
	var scale_factor_x = vp_size.x / tex_size.x
	var scale_factor_y = vp_size.y / tex_size.y
	var scale_factor = max(scale_factor_x, scale_factor_y)
	bg.scale = Vector2(scale_factor, scale_factor)
