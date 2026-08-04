class_name Dungeon extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		_handle_exit()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST || what == NOTIFICATION_WM_CLOSE_REQUEST:
		_handle_exit()

func _on_back_button_pressed() -> void:
	_handle_exit()

func _handle_exit() -> void:
	LevelManager.exit_dungeon()
