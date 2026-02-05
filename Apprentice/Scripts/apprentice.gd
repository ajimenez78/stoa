class_name Apprentice extends CharacterBody2D

const SPEED = 100.0

var cardinal_direction := Vector2.DOWN
var direction := Vector2.ZERO
var state := "idle"
var dungeon_entered = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var apprentice_camera: ApprenticeCamera = $Camera2D

func _process(delta: float) -> void:
	if !LevelManager.in_dungeon():
		if dungeon_entered: dungeon_entered = false

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		
		velocity = direction * SPEED
	else:
		if !dungeon_entered:
			direction = -direction
			velocity = Vector2.ZERO
			dungeon_entered = true
		
	if setState() || setDirection():
		updateAnimation()

func _physics_process(delta: float) -> void:
	move_and_slide()

func setDirection() -> bool:
	var new_dir := cardinal_direction
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	else:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
		
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	return true

func setState() -> bool:
	var new_state := "idle" if direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
	
	state = new_state
	return true

func updateAnimation() -> void:
	animated_sprite_2d.play(state + "_" + animDirection())

func animDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "south"
	elif cardinal_direction == Vector2.UP:
		return "north"
	elif cardinal_direction == Vector2.RIGHT:
		return "east"
	else:
		return "west"
