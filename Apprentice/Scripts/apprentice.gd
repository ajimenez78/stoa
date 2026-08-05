class_name Apprentice extends CharacterBody2D

const SPEED = 100.0
# Ventaja del eje que ya manda al comparar magnitudes, para que las diagonales
# del joystick no hagan parpadear la animación entre lateral y vertical.
const DIRECTION_BIAS = 1.2

var cardinal_direction := Vector2.DOWN
var direction := Vector2.ZERO
var state := "idle"
var dungeon_entered = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var apprentice_camera: ApprenticeCamera = $Camera2D
# @onready var back_button: TextureButton = $TouchControls/TextureButton
@onready var back_button: Button = $TouchControls/BackButton
@onready var touch_controls: CanvasLayer = $TouchControls
@onready var virtual_joystick: Control = $TouchControls/VirtualJoystick

func _ready() -> void:
	if touch_controls:
		touch_controls.layer = 100
	if back_button:
		back_button.pressed.connect(_on_back_button_pressed)
	_update_touch_controls()

func _on_back_button_pressed() -> void:
	if LevelManager.in_dungeon() and LevelManager.playground.current_dungeon:
		var dungeon = LevelManager.playground.current_dungeon
		if dungeon.has_method("_on_back_button_pressed"):
			dungeon._on_back_button_pressed()

func _update_touch_controls() -> void:
	var in_dungeon = LevelManager.in_dungeon()
	if back_button:
		back_button.visible = in_dungeon
		back_button.disabled = !in_dungeon
	if virtual_joystick:
		virtual_joystick.visible = !in_dungeon

func _process(delta: float) -> void:
	_update_touch_controls()

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
		
	# Sin cortocircuito: al empezar a andar cambian estado y dirección a la vez,
	# y saltarse setDirection() dejaba un frame con la animación del cardinal viejo.
	var state_changed := setState()
	var direction_changed := setDirection()
	if state_changed || direction_changed:
		updateAnimation()

func _physics_process(delta: float) -> void:
	move_and_slide()

func setDirection() -> bool:
	var new_dir := cardinal_direction
	if direction == Vector2.ZERO:
		return false

	# Con el joystick virtual casi nunca hay un eje exactamente a cero, así que
	# la animación la decide el eje de mayor magnitud, no la simple presencia
	# de componente vertical.
	var horizontal: bool
	if cardinal_direction == Vector2.LEFT || cardinal_direction == Vector2.RIGHT:
		horizontal = absf(direction.x) * DIRECTION_BIAS >= absf(direction.y)
	else:
		horizontal = absf(direction.x) >= absf(direction.y) * DIRECTION_BIAS

	if horizontal:
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
