class_name athens extends StoaLevelMap

@onready var tile_map_dual: TileMapDual = $TileMapDual

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	LevelManager.change_tilemap_bounds(get_tile_map_bounds())

func get_tile_map_bounds() -> Array[Vector2]:
	var map_rectangle = tile_map_dual.get_used_rect()
	var bounds: Array[Vector2] = []
	bounds.append(
		Vector2(map_rectangle.position * tile_map_dual.rendering_quadrant_size) + tile_map_dual.global_position
	)
	bounds.append(
		Vector2(map_rectangle.end * tile_map_dual.rendering_quadrant_size) + tile_map_dual.global_position
	)

	return bounds
