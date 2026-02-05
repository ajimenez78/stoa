extends Node

var current_tilemap_bounds: Array[Vector2]
var current_level_map: String

signal TileMapBoundsChanged(bounds: Array[Vector2])

func change_tilemap_bounds(bounds: Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	TileMapBoundsChanged.emit(bounds)
	
func change_level_map(newLevel: String) -> void:
	current_level_map = newLevel
