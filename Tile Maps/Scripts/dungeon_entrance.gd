class_name DungeonEntrance extends Area2D

@export var dungeon_resource: PackedScene

func _on_body_entered(body: Node2D) -> void:
	if body is Apprentice and dungeon_resource:
		var dungeon = dungeon_resource.instantiate()
		LevelManager.enter_dungeon(dungeon)
