class_name Dungeon extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale_sprite_to_viewport()

func scale_sprite_to_viewport() -> void:
	if !sprite or !sprite.texture:
		return

	# Get viewport size
	var viewport_size = get_viewport().get_visible_rect().size

	# Get texture size
	var texture_size = sprite.texture.get_size()

	# Calculate scale to fill viewport
	var scale_x = viewport_size.x / texture_size.x
	var scale_y = viewport_size.y / texture_size.y

	# Use the larger scale to fill the viewport completely
	var scale_factor = max(scale_x, scale_y)

	# Apply scale to sprite
	sprite.scale = Vector2(scale_factor, scale_factor)

	# Center sprite at (0, 0)
	sprite.position = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		LevelManager.exit_dungeon()
