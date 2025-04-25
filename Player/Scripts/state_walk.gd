class_name State_Walk extends State

@export var move_speed: float = 5500.0

@onready var idle: State = $"../Idle"

## What happens when the player enters this state?
func enter() -> void:
	player.update_animation("walk")

## What happens when the player exits this state?
func exit() -> void:
	pass

func process(delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	print(delta)
	player.velocity = player.direction * move_speed * delta
	
	if player.set_direction():
		player.update_animation("walk")
	
	return null

func physics(delta: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	return null
