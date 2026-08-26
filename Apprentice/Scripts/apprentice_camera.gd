class_name ApprenticeCamera extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.TileMapBoundsChanged.connect(update_limits)
	update_limits(LevelManager.current_tilemap_bounds)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_limits(bounds: Array[Vector2]) -> void:
	if bounds == []:
		return
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
