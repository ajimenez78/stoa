class_name Apprentice extends CharacterBody2D

const SPEED = 100.0
# Ventaja del eje que ya manda al comparar magnitudes, para que las diagonales
# del joystick no hagan parpadear la animación entre lateral y vertical.
const DIRECTION_BIAS = 1.2

var cardinal_direction := Vector2.DOWN
var direction := Vector2.ZERO
var state := "idle"
var dungeon_entered = false

# Navegación inteligente por toque con AStarGrid2D (Estilo Stardew Valley)
var astar: AStarGrid2D = null
var path_points: Array[Vector2] = []
var current_path_index := 0
var is_moving_to_target := false

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

func initialize_pathfinder() -> void:
	print("--- INICIALIZANDO PATHFINDER ---")
	if LevelManager.in_dungeon():
		print("  Cancelado: Jugador en un dungeon")
		return
		
	var playground = LevelManager.playground
	if not playground:
		print("  Error: No se pudo obtener la referencia de LevelManager.playground")
		return
	if not playground.current_level:
		print("  Error: El playground actual no tiene un current_level cargado")
		return
		
	var map = playground.current_level
	print("  Mapa activo: ", map.name)
	var tile_map_dual: TileMapLayer = map.get_node_or_null("TileMapDual")
	if not tile_map_dual:
		print("  Error: No se encontró la capa TileMapDual en el mapa activo")
		return
		
	astar = AStarGrid2D.new()
	astar.region = tile_map_dual.get_used_rect()
	astar.cell_size = Vector2(32, 32)
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE
	astar.update()
	print("  Región del mapa en celdas (used_rect): ", astar.region)
	
	# 1. Marcar colisiones del TileMapLayer
	var rect = tile_map_dual.get_used_rect()
	var solid_terrain_count := 0
	for x in range(rect.position.x, rect.end.x):
		for y in range(rect.position.y, rect.end.y):
			var coords = Vector2i(x, y)
			var tile_data = tile_map_dual.get_cell_tile_data(coords)
			if tile_data and tile_data.get_collision_polygons_count(0) > 0:
				astar.set_point_solid(coords, true)
				solid_terrain_count += 1
				if coords == Vector2i(8, 0):
					print("  >> AVISO: Celda (8, 0) marcada sólida por colisión del TileMap (terreno)!")
	print("  Celdas de colisión del TileMap marcadas como sólidas: ", solid_terrain_count)
				
	# 2. Marcar obstáculos del mapa (árboles, piedras, etc. que son Sprite2D)
	var obstacle_count := 0
	for child in map.get_children():
		if child == self:
			continue
		
		if child is Sprite2D:
			var cname = child.name.to_lower()
			if "tree" in cname or "stone" in cname or "bush" in cname:
				var local_pos = tile_map_dual.to_local(child.global_position)
				var cell = tile_map_dual.local_to_map(local_pos)
				astar.set_point_solid(cell, true)
				obstacle_count += 1
				
				# Los árboles grandes en Stoa tienen un tronco/copa alta,
				# podemos marcar también la celda inmediatamente encima para prevenir solapamientos.
				if "tree" in cname:
					var above = cell + Vector2i(0, -1)
					astar.set_point_solid(above, true)
					obstacle_count += 1
	print("  Obstáculos de escena (árboles, piedras, etc.) marcados como sólidos: ", obstacle_count)

	# 3. RED DE SEGURIDAD: La celda actual en la que se encuentra el jugador NUNCA debe ser sólida
	var current_cell = tile_map_dual.local_to_map(tile_map_dual.to_local(global_position))
	if astar.is_in_bounds(current_cell.x, current_cell.y):
		astar.set_point_solid(current_cell, false)
		print("  Red de seguridad: Celda de inicio del aprendiz ", current_cell, " forzada como transitable.")

func _calculate_path_to(target_pos: Vector2) -> void:
	print("--- NUEVA PETICIÓN DE RUTA ---")
	print("  Posición inicial (global): ", global_position)
	print("  Posición clic/toque (global): ", target_pos)
	
	if not astar:
		initialize_pathfinder()
		
	if not astar:
		print("  Error: El pathfinder no se pudo instanciar o inicializar.")
		return
		
	var playground = LevelManager.playground
	if not playground or not playground.current_level:
		print("  Error: Referencia del nivel no encontrada en LevelManager.")
		return
		
	var map = playground.current_level
	var tile_map_dual: TileMapLayer = map.get_node_or_null("TileMapDual")
	if not tile_map_dual:
		print("  Error: El mapa activo no tiene un nodo TileMapDual.")
		return
		
	var start_cell = tile_map_dual.local_to_map(tile_map_dual.to_local(global_position))
	var end_cell = tile_map_dual.local_to_map(tile_map_dual.to_local(target_pos))
	print("  Celda de inicio en cuadrícula: ", start_cell)
	print("  Celda de fin en cuadrícula: ", end_cell)
	
	# Validar límites
	var start_in_bounds = astar.is_in_bounds(start_cell.x, start_cell.y)
	var end_in_bounds = astar.is_in_bounds(end_cell.x, end_cell.y)
	print("  ¿Celda inicial dentro de límites?: ", start_in_bounds)
	print("  ¿Celda destino dentro de límites?: ", end_in_bounds)
	
	if start_in_bounds and end_in_bounds:
		print("  ¿Celda inicial es sólida?: ", astar.is_point_solid(start_cell))
		print("  ¿Celda destino es sólida?: ", astar.is_point_solid(end_cell))
		
		# Si el usuario hace clic exactamente en un obstáculo (como un muro o piedra),
		# buscamos la celda libre no sólida más cercana para guiarlo hasta allí.
		if astar.is_point_solid(end_cell):
			print("  La celda destino es sólida/colisionable. Buscando vecino transitable...")
			var neighbors = [
				Vector2i(0, 1), Vector2i(0, -1), Vector2i(1, 0), Vector2i(-1, 0),
				Vector2i(1, 1), Vector2i(-1, 1), Vector2i(1, -1), Vector2i(-1, -1)
			]
			var best_cell = end_cell
			var min_dist = INF
			for offset in neighbors:
				var candidate = end_cell + offset
				if astar.is_in_bounds(candidate.x, candidate.y) and not astar.is_point_solid(candidate):
					var dist = global_position.distance_to(tile_map_dual.to_global(tile_map_dual.map_to_local(candidate)))
					if dist < min_dist:
						min_dist = dist
						best_cell = candidate
			end_cell = best_cell
			print("  Celda de destino ajustada al vecino transitable: ", end_cell)
			print("  ¿Nueva celda destino es sólida?: ", astar.is_point_solid(end_cell))
			
		var point_path = astar.get_point_path(start_cell, end_cell)
		print("  Puntos en el camino calculado por AStar: ", point_path.size())
		
		if point_path.size() > 1:
			path_points.clear()
			for pt in point_path:
				path_points.append(tile_map_dual.to_global(pt))
			current_path_index = 1 # Omitimos el primer punto ya que es donde estamos parados
			is_moving_to_target = true
			print("  ¡Ruta establecida con éxito!")
		else:
			print("  Error: No se encontró ningún camino libre viable hacia el destino.")
			path_points.clear()
			is_moving_to_target = false
	else:
		print("  Error: Celda inicial o celda destino fuera de los límites utilizables de la cuadrícula.")
		path_points.clear()
		is_moving_to_target = false

func _unhandled_input(event: InputEvent) -> void:
	if LevelManager.in_dungeon():
		return
		
	# Capturar click o toque en la pantalla que no haya sido consumido por la UI
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var click_pos = get_global_mouse_position()
			_calculate_path_to(click_pos)

func _process(delta: float) -> void:
	_update_touch_controls()

	if !LevelManager.in_dungeon():
		if dungeon_entered: dungeon_entered = false

		# Leer controles físicos o Joystick virtual
		var input_dir := Vector2.ZERO
		input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		input_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		
		if input_dir.length_squared() > 0.05:
			# Si se detecta entrada manual del joystick o teclado, se cancela el Tap-to-Move de inmediato
			is_moving_to_target = false
			path_points.clear()
			direction = input_dir.normalized()
			velocity = direction * SPEED
		elif is_moving_to_target and current_path_index < path_points.size():
			# Mover hacia el siguiente punto del camino inteligente
			var target_pos: Vector2 = path_points[current_path_index]
			var to_target: Vector2 = target_pos - global_position
			
			# Si estamos muy cerca del punto actual, avanzar al siguiente
			if to_target.length() < 4.0:
				current_path_index += 1
				if current_path_index >= path_points.size():
					# Llegamos al destino final del camino
					is_moving_to_target = false
					path_points.clear()
					direction = Vector2.ZERO
					velocity = Vector2.ZERO
				else:
					# Avanzar hacia el nuevo nodo del recorrido
					target_pos = path_points[current_path_index]
					to_target = target_pos - global_position
					direction = to_target.normalized()
					velocity = direction * SPEED
			else:
				direction = to_target.normalized()
				velocity = direction * SPEED
		else:
			is_moving_to_target = false
			path_points.clear()
			direction = Vector2.ZERO
			velocity = Vector2.ZERO
	else:
		is_moving_to_target = false
		path_points.clear()
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
