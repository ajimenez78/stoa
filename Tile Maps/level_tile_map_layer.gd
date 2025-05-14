class_name LevelTileMapLayer extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.change_tilemap_bounds(get_tile_map_bounds())

func get_tile_map_bounds() -> Array[Vector2]:
	var map_rectangle = get_used_rect()
	var QUADRANT_SIZE = rendering_quadrant_size
	var bounds: Array[Vector2] = []
	bounds.append(
		Vector2(map_rectangle.position * rendering_quadrant_size)
	)
	bounds.append(
		Vector2(map_rectangle.end * rendering_quadrant_size)
	)
	
	return bounds
