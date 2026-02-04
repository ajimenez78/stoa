extends TileMapDual


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	
	LevelManager.change_tilemap_bounds(get_tile_map_bounds())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)


func get_tile_map_bounds() -> Array[Vector2]:
	var map_rectangle = get_used_rect()
	var bounds: Array[Vector2] = []
	bounds.append(
		Vector2(map_rectangle.position * rendering_quadrant_size)
	)
	bounds.append(
		Vector2(map_rectangle.end * rendering_quadrant_size)
	)
	
	return bounds
