extends Node

var current_tilemap_bounds: Array[Vector2]
var playground: Playground

signal TileMapBoundsChanged(bounds: Array[Vector2])

func change_tilemap_bounds(bounds: Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	TileMapBoundsChanged.emit(bounds)
	
func enter_dungeon(new_dungeon: Node2D) -> void:
	if !playground.current_dungeon:
		playground.add_child(new_dungeon)
		playground.current_dungeon = new_dungeon

func exit_dungeon() -> void:
	if playground.current_dungeon:
		playground.remove_child(playground.current_dungeon)
		playground.current_dungeon = null

func in_dungeon() -> bool:
	return playground.current_dungeon != null
