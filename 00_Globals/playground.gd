class_name Playground extends Node2D

@export var current_level: Node2D
var current_dungeon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.playground = self
