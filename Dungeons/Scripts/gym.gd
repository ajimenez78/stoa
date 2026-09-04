extends Dungeon

const MISSIONS_DATABASE_PATH := "res://Dungeons/gym_missions.json"

const MISSION_CARD_SCENE := preload("res://Dungeons/UI/mission_card.tscn")
const CHALLENGE_CARD_SCENE := preload("res://Dungeons/UI/challenge_card.tscn")
const VIRTUE_METER_SCENE := preload("res://Dungeons/UI/virtue_meter.tscn")
const CREDITS_DIALOG_SCENE := preload("res://Dungeons/UI/credits_dialog.tscn")

const PRACTICE_META_TEMPLATE := "Duración: %s · Cultiva %s (+%d puntos)"
const PRACTICE_DONE_MESSAGE := "Práctica completada. Has ganado %d puntos de %s."
const PRACTICE_REPEATED_MESSAGE := "Ya la completaste hoy. Vuelve mañana."
const CHALLENGE_DAY_MESSAGE := "Día apuntado. Mantén el reto hasta el final."
const CHALLENGE_DONE_MESSAGE := "Reto conseguido. Has ganado %d puntos de %s."
const MINIGAME_REWARD_MESSAGE := "%s. Has ganado %s."
const MINIGAME_REPLAYED_MESSAGE := "%s. Hoy ya habías ganado sus puntos."
const MINIGAME_NO_REWARD_MESSAGE := "%s. Vuelve a intentarlo cuando quieras."
const LEVEL_TEMPLATE := "Nivel %d"
const LEVEL_HINT_TEMPLATE := "%d puntos para el nivel %d"
const LEVEL_SUGGESTION_TEMPLATE := "%d puntos para el nivel %d · el mentor te sugiere cultivar %s"
const LEVEL_MAXED_HINT := "Has llevado las cuatro virtudes a su plenitud. Ahora toca sostenerlas."

const FONT_SCALES: Array[float] = [0.85, 1.0, 1.2, 1.4, 1.6, 1.8, 2.0]

@export_group("Tamaño de Fuente")
@export var font_decrease_button: Button
@export var font_increase_button: Button
@export var credits_button: Button
@export var font_scale_label: Label

@export_group("Progreso")
@export var progress_panel: Control
@export var level_label: Label
@export var level_bar: ProgressBar
@export var level_hint_label: Label
@export var virtue_grid: GridContainer
@export var toggle_progress_button: Button

@export_group("Pestañas")
@export var practices_tab: Button
@export var challenges_tab: Button
@export var minigames_tab: Button

@export_group("Prácticas diarias")
@export var practices_panel: Control
@export var practice_list: Control
@export var practice_scroll: ScrollContainer
@export var practice_grid: GridContainer
@export var practice_detail: Control
@export var practice_detail_scroll: ScrollContainer
@export var back_button: Button
@export var detail_title_label: Label
@export var detail_description_label: Label
@export var detail_meta_label: Label
@export var detail_steps_label: RichTextLabel
@export var complete_button: Button

@export_group("Retos semanales")
@export var challenges_panel: Control
@export var challenge_list: VBoxContainer

@export_group("Mini-juegos")
@export var minigames_panel: Control
@export var minigame_list: Control
@export var minigame_grid: GridContainer
@export var minigame_play: Control
@export var minigame_back_button: Button
@export var minigame_title_label: Label
@export var minigame_host: Container

@export_group("Avisos")
@export var toast_label: Label

var _progress: Dictionary
var _missions: Dictionary
var _selected_practice: Dictionary
var _suggested_virtue: String
var _toast_tween: Tween
var _current_scale_index := 1
var _base_font_sizes: Dictionary = {}
var _progress_expanded := true
var _credits_dialog: CreditsDialog

func _ready() -> void:
	_init_font_scale_index()
	_progress = ProgressStore.load_progress()
	_missions = _load_missions()

	if font_decrease_button == null and has_node("%FontDecreaseButton"):
		font_decrease_button = %FontDecreaseButton as Button
	if font_increase_button == null and has_node("%FontIncreaseButton"):
		font_increase_button = %FontIncreaseButton as Button
	if credits_button == null and has_node("%CreditsButton"):
		credits_button = %CreditsButton as Button
	if font_scale_label == null and has_node("%FontSizeLabel"):
		font_scale_label = %FontSizeLabel as Label
	if toggle_progress_button == null and has_node("%ToggleProgressButton"):
		toggle_progress_button = %ToggleProgressButton as Button

	if font_decrease_button:
		font_decrease_button.pressed.connect(_on_font_decrease_pressed)
	if font_increase_button:
		font_increase_button.pressed.connect(_on_font_increase_pressed)
	if credits_button:
		credits_button.pressed.connect(_on_credits_pressed)
	if toggle_progress_button:
		toggle_progress_button.pressed.connect(_on_toggle_progress_pressed)


	practices_tab.pressed.connect(_show_practices)
	challenges_tab.pressed.connect(_show_challenges)
	minigames_tab.pressed.connect(_show_minigames)
	back_button.pressed.connect(_show_practice_list)
	minigame_back_button.pressed.connect(_show_minigame_list)
	complete_button.pressed.connect(_on_complete_pressed)

	toast_label.modulate.a = 0.0
	_build_virtue_meters()
	_refresh()
	_show_practices()
	_show_practice_list()
	_show_minigame_list()

	_cache_base_font_sizes(self)
	_configure_scroll_pass_through(self)
	_update_responsive_layout()
	call_deferred("_apply_font_scale")

	get_viewport().size_changed.connect(_update_responsive_layout)

func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED and is_node_ready() and is_visible_in_tree():
		_progress = ProgressStore.load_progress()
		_refresh()

func _on_toggle_progress_pressed() -> void:
	_progress_expanded = not _progress_expanded
	if virtue_grid:
		virtue_grid.visible = _progress_expanded
	if level_hint_label:
		level_hint_label.visible = _progress_expanded
	if toggle_progress_button:
		toggle_progress_button.text = " ▲ " if _progress_expanded else " ▼ "

func _init_font_scale_index() -> void:
	var is_mobile := OS.has_feature("mobile") or DisplayServer.is_touchscreen_available()
	var is_small_screen := get_viewport_rect().size.x < 600
	if is_mobile or is_small_screen:
		_current_scale_index = 3
	else:
		_current_scale_index = 1

func _update_responsive_layout() -> void:
	if virtue_grid:
		virtue_grid.columns = 2
	if practice_grid:
		practice_grid.columns = 1
	if minigame_grid:
		minigame_grid.columns = 1

func _collapse_progress_panel() -> void:
	if not _progress_expanded:
		return
	_progress_expanded = false
	if virtue_grid:
		virtue_grid.visible = false
	if level_hint_label:
		level_hint_label.visible = false
	if toggle_progress_button:
		toggle_progress_button.text = " ▼ "

func _on_font_decrease_pressed() -> void:
	_collapse_progress_panel()
	if _current_scale_index > 0:
		_current_scale_index -= 1
		_apply_font_scale()

func _on_font_increase_pressed() -> void:
	_collapse_progress_panel()
	if _current_scale_index < FONT_SCALES.size() - 1:
		_current_scale_index += 1
		_apply_font_scale()

func _apply_font_scale() -> void:
	var scale_factor := FONT_SCALES[_current_scale_index]
	if font_decrease_button:
		font_decrease_button.disabled = _current_scale_index <= 0
	if font_increase_button:
		font_increase_button.disabled = _current_scale_index >= FONT_SCALES.size() - 1

	for control in _base_font_sizes.keys():
		if is_instance_valid(control):
			var val = _base_font_sizes[control]
			if val is Dictionary and control is RichTextLabel:
				var rtl := control as RichTextLabel
				var normal_scaled := int(round(float(val.get("normal", 13)) * scale_factor))
				var bold_scaled := int(round(float(val.get("bold", 13)) * scale_factor))
				rtl.add_theme_font_size_override("normal_font_size", normal_scaled)
				rtl.add_theme_font_size_override("bold_font_size", bold_scaled)
			elif val is int or val is float:
				var scaled_size := int(round(float(val) * scale_factor))
				(control as Control).add_theme_font_size_override("font_size", scaled_size)

	_update_card_heights(scale_factor)

	if _credits_dialog and is_instance_valid(_credits_dialog):
		_credits_dialog.set_font_scale(scale_factor)

func _update_card_heights(scale_factor: float) -> void:
	if practice_grid:
		_update_adaptive_heights_recursive(practice_grid, scale_factor)
	if challenge_list:
		_update_adaptive_heights_recursive(challenge_list, scale_factor)
	if minigame_grid:
		_update_adaptive_heights_recursive(minigame_grid, scale_factor)
	if minigame_host:
		_update_adaptive_heights_recursive(minigame_host, scale_factor)

func _update_adaptive_heights_recursive(node: Node, scale_factor: float) -> void:
	if node.has_method("update_adaptive_minimum_size"):
		node.call("update_adaptive_minimum_size", scale_factor)
	for child in node.get_children():
		_update_adaptive_heights_recursive(child, scale_factor)

func _clean_stale_font_size_cache() -> void:
	for control in _base_font_sizes.keys():
		if not is_instance_valid(control):
			_base_font_sizes.erase(control)

func _cache_base_font_sizes(node: Node) -> void:
	_clean_stale_font_size_cache()
	for child in node.get_children():
		if child is Control and child != font_decrease_button and child != font_increase_button and child != credits_button:
			if not _base_font_sizes.has(child):
				if child is RichTextLabel:
					var rtl := child as RichTextLabel
					var normal_s := rtl.get_theme_font_size("normal_font_size")
					var bold_s := rtl.get_theme_font_size("bold_font_size")
					if normal_s <= 0:
						normal_s = 13
					if bold_s <= 0:
						bold_s = 13
					_base_font_sizes[child] = {"normal": normal_s, "bold": bold_s}
				else:
					var base_size := (child as Control).get_theme_font_size("font_size")
					if base_size > 0:
						_base_font_sizes[child] = base_size
		_cache_base_font_sizes(child)

func _on_credits_pressed() -> void:
	if not _credits_dialog or not is_instance_valid(_credits_dialog):
		_credits_dialog = CREDITS_DIALOG_SCENE.instantiate() as CreditsDialog
		var canvas_layer := get_node_or_null("UI") as CanvasLayer
		if canvas_layer:
			canvas_layer.add_child(_credits_dialog)
		else:
			add_child(_credits_dialog)
	_credits_dialog.set_font_scale(FONT_SCALES[_current_scale_index])
	_credits_dialog.open()


func _configure_scroll_pass_through(node: Node) -> void:
	if node is Control and not (node is TextEdit) and not (node is ScrollContainer):
		if node is BaseButton:
			(node as Control).mouse_filter = Control.MOUSE_FILTER_PASS
		else:
			(node as Control).mouse_filter = Control.MOUSE_FILTER_IGNORE
	for child in node.get_children():
		_configure_scroll_pass_through(child)

# Lee la base de datos de misiones del gimnasio: prácticas diarias, retos
# semanales y mini-juegos.
func _load_missions() -> Dictionary:
	var empty := {"daily_practices": [], "weekly_challenges": [], "minigames": []}

	var file := FileAccess.open(MISSIONS_DATABASE_PATH, FileAccess.READ)
	if file == null:
		push_error("No se pudo abrir la base de datos de misiones: %s" % MISSIONS_DATABASE_PATH)
		return empty

	var content := file.get_as_text()
	file.close()

	var missions: Variant = JSON.parse_string(content)
	if not (missions is Dictionary):
		push_error("La base de datos de misiones está mal formada: %s" % MISSIONS_DATABASE_PATH)
		return empty

	for key: String in empty:
		if not (missions.get(key) is Array):
			push_error("Falta la lista «%s» en %s" % [key, MISSIONS_DATABASE_PATH])
			missions[key] = []

	return missions

# Crea una barra por virtud, en el orden en que están declaradas; sus valores se
# actualizan en cada refresco.
func _build_virtue_meters() -> void:
	if virtue_grid == null:
		return
	for child in virtue_grid.get_children():
		virtue_grid.remove_child(child)
		child.queue_free()
	for virtue: String in Virtues.DATA:
		var meter: VirtueMeter = VIRTUE_METER_SCENE.instantiate()
		virtue_grid.add_child(meter)
		meter.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		_cache_base_font_sizes(meter)
		_configure_scroll_pass_through(meter)

# Vuelve a pintar todo lo que depende del progreso guardado.
func _refresh() -> void:
	_suggested_virtue = _find_suggested_virtue()
	_refresh_level()
	_refresh_virtue_meters()
	_rebuild_practice_cards()
	_rebuild_challenge_cards()
	_rebuild_minigame_cards()
	call_deferred("_apply_font_scale")

func _refresh_level() -> void:
	var level := ProgressStore.level(_progress)
	var missing := ProgressStore.points_to_next_level(_progress)

	level_label.text = LEVEL_TEMPLATE % level
	level_bar.max_value = ProgressStore.POINTS_PER_LEVEL
	level_bar.value = ProgressStore.POINTS_PER_LEVEL - missing

	if _is_fully_cultivated():
		level_hint_label.text = LEVEL_MAXED_HINT
	elif _suggested_virtue.is_empty():
		level_hint_label.text = LEVEL_HINT_TEMPLATE % [missing, level + 1]
	else:
		level_hint_label.text = LEVEL_SUGGESTION_TEMPLATE % [
			missing, level + 1, Virtues.display_name(_suggested_virtue),
		]

# Virtud que el mentor sugiere cultivar: la más descuidada, y solo cuando hay
# desequilibrio real entre las cuatro.
func _find_suggested_virtue() -> String:
	var virtues: Dictionary = _progress["virtues"]
	var weakest := ProgressStore.weakest_virtue(_progress)
	for virtue: String in virtues:
		if int(virtues[virtue]) > int(virtues[weakest]):
			return weakest
	return ""

func _refresh_virtue_meters() -> void:
	if virtue_grid == null:
		return
	if virtue_grid.get_child_count() < Virtues.DATA.size():
		_build_virtue_meters()
	var virtues: Dictionary = _progress["virtues"]
	var index := 0
	for virtue: String in Virtues.DATA:
		if index < virtue_grid.get_child_count():
			var meter := virtue_grid.get_child(index) as VirtueMeter
			if meter:
				meter.setup(virtue, int(virtues[virtue]))
		index += 1

# Rehace las tarjetas de prácticas, señalando las ya hechas hoy y la que cultiva
# la virtud más descuidada.
func _rebuild_practice_cards() -> void:
	for child in practice_grid.get_children():
		practice_grid.remove_child(child)
		child.queue_free()

	for practice: Dictionary in _missions["daily_practices"]:
		var card: MissionCard = MISSION_CARD_SCENE.instantiate()
		practice_grid.add_child(card)
		card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		card.setup_practice(
			practice,
			ProgressStore.is_practice_done_today(_progress, str(practice["id"])),
			str(practice["virtue"]) == _suggested_virtue,
		)
		card.pressed.connect(_show_practice_detail.bind(practice))
		_cache_base_font_sizes(card)
		_configure_scroll_pass_through(card)

# Rehace las tarjetas de retos con el progreso de la semana en curso. Los retos
# por encima del nivel del aprendiz se muestran bloqueados.
func _rebuild_challenge_cards() -> void:
	for child in challenge_list.get_children():
		challenge_list.remove_child(child)
		child.queue_free()

	var level := ProgressStore.level(_progress)
	for challenge: Dictionary in _missions["weekly_challenges"]:
		var card: ChallengeCard = CHALLENGE_CARD_SCENE.instantiate()
		challenge_list.add_child(card)
		card.setup(
			challenge,
			ProgressStore.challenge_state(_progress, str(challenge["id"])),
			level >= int(challenge.get("required_level", 1)),
		)
		card.day_registered.connect(_on_challenge_day_registered)
		_cache_base_font_sizes(card)
		_configure_scroll_pass_through(card)

# Rehace las tarjetas de los mini-juegos declarados en la base de datos.
func _rebuild_minigame_cards() -> void:
	for child in minigame_grid.get_children():
		minigame_grid.remove_child(child)
		child.queue_free()

	for minigame: Dictionary in _missions["minigames"]:
		var card: MissionCard = MISSION_CARD_SCENE.instantiate()
		minigame_grid.add_child(card)
		card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		card.setup_minigame(
			minigame,
			ProgressStore.is_minigame_rewarded_today(_progress, str(minigame["id"])),
		)
		card.pressed.connect(_open_minigame.bind(minigame))
		_cache_base_font_sizes(card)
		_configure_scroll_pass_through(card)

	call_deferred("_apply_font_scale")

# Carga la escena de un mini-juego, la muestra en la pestaña y arranca una
# partida.
func _open_minigame(minigame: Dictionary) -> void:
	_clear_minigame()

	var scene: PackedScene = load(str(minigame["scene"]))
	if scene == null:
		push_error("No se pudo cargar el mini-juego: %s" % minigame.get("scene", ""))
		return

	var game: Minigame = scene.instantiate()
	minigame_host.add_child(game)
	game.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	game.size_flags_vertical = Control.SIZE_EXPAND_FILL
	game.finished.connect(_on_minigame_finished.bind(minigame))
	game.start()

	_cache_base_font_sizes(game)
	call_deferred("_apply_font_scale")

	minigame_title_label.text = str(minigame["title"])
	minigame_list.visible = false
	minigame_play.visible = true
	if progress_panel:
		progress_panel.visible = false

# Anota el resultado de la partida. El mini-juego que lo emite llega como último
# argumento, atado al conectar la señal.
func _on_minigame_finished(result: Dictionary, minigame: Dictionary) -> void:
	var minigame_id := str(minigame["id"])
	var rewards: Dictionary = result["rewards"]
	var summary := str(result["summary"])
	var already_rewarded := ProgressStore.is_minigame_rewarded_today(_progress, minigame_id)

	_progress = ProgressStore.register_minigame_result(minigame_id, rewards)
	_refresh()

	if rewards.is_empty():
		_show_toast(MINIGAME_NO_REWARD_MESSAGE % summary)
	elif already_rewarded:
		_show_toast(MINIGAME_REPLAYED_MESSAGE % summary)
	else:
		_show_toast(MINIGAME_REWARD_MESSAGE % [summary, _format_rewards(rewards)])

# Los puntos ganados, como "Sabiduría +20 · Templanza +12".
func _format_rewards(rewards: Dictionary) -> String:
	var parts: PackedStringArray = []
	for virtue: String in rewards:
		parts.append("%s +%d" % [Virtues.display_name(virtue), int(rewards[virtue])])
	return " · ".join(parts)

# Descarta la partida en curso, si hay alguna.
func _clear_minigame() -> void:
	for child in minigame_host.get_children():
		minigame_host.remove_child(child)
		child.queue_free()

# Muestra las instrucciones de una práctica y el botón para darla por hecha.
func _show_practice_detail(practice: Dictionary) -> void:
	_collapse_progress_panel()
	_selected_practice = practice

	detail_title_label.text = str(practice["title"])
	detail_description_label.text = str(practice["description"])
	detail_meta_label.text = PRACTICE_META_TEMPLATE % [
		practice["duration"],
		Virtues.display_name(str(practice["virtue"])),
		int(practice["points"]),
	]
	detail_steps_label.text = _format_instructions(practice["instructions"])

	var done_today := ProgressStore.is_practice_done_today(_progress, str(practice["id"]))
	complete_button.disabled = done_today
	complete_button.text = "Ya completada hoy" if done_today else "Marcar como completada"

	if practice_detail_scroll:
		practice_detail_scroll.scroll_vertical = 0

	practice_list.visible = false
	practice_detail.visible = true

# Numera los pasos de una práctica como una lista ordenada en BBCode.
func _format_instructions(instructions: Array) -> String:
	var steps: PackedStringArray = []
	for index: int in instructions.size():
		steps.append("[b]%d.[/b]  %s" % [index + 1, instructions[index]])
	return "\n".join(steps)

func _on_complete_pressed() -> void:
	var practice_id := str(_selected_practice["id"])
	var virtue := str(_selected_practice["virtue"])
	var points := int(_selected_practice["points"])

	if ProgressStore.is_practice_done_today(_progress, practice_id):
		_show_toast(PRACTICE_REPEATED_MESSAGE)
		return

	_progress = ProgressStore.complete_practice(practice_id, virtue, points)
	_refresh()
	_show_practice_list()
	_show_toast(PRACTICE_DONE_MESSAGE % [points, Virtues.display_name(virtue)])

# Apunta el día de hoy en un reto y avisa si con ello queda conseguido.
func _on_challenge_day_registered(challenge: Dictionary) -> void:
	var challenge_id := str(challenge["id"])
	var target_days := int(challenge["target_days"])
	var days_before: int = (ProgressStore.challenge_state(_progress, challenge_id)["days"] as Array).size()

	_progress = ProgressStore.register_challenge_day(challenge)
	var days_now: int = (ProgressStore.challenge_state(_progress, challenge_id)["days"] as Array).size()
	_refresh()

	if days_before < target_days and days_now >= target_days:
		_show_toast(CHALLENGE_DONE_MESSAGE % [
			int(challenge["points"]), Virtues.display_name(str(challenge["virtue"])),
		])
	else:
		_show_toast(CHALLENGE_DAY_MESSAGE)

func _show_practices() -> void:
	practices_tab.button_pressed = true
	_show_panel(practices_panel)

func _show_challenges() -> void:
	challenges_tab.button_pressed = true
	_show_panel(challenges_panel)

func _show_minigames() -> void:
	minigames_tab.button_pressed = true
	_show_panel(minigames_panel)

# Deja visible solo el contenido de la pestaña elegida.
func _show_panel(panel: Control) -> void:
	if progress_panel:
		progress_panel.visible = true
	practices_panel.visible = panel == practices_panel
	challenges_panel.visible = panel == challenges_panel
	minigames_panel.visible = panel == minigames_panel
	call_deferred("_apply_font_scale")

func _show_practice_list() -> void:
	_collapse_progress_panel()
	if practice_scroll:
		practice_scroll.scroll_vertical = 0
	practice_detail.visible = false
	practice_list.visible = true
	call_deferred("_apply_font_scale")

# Vuelve al catálogo de mini-juegos y abandona la partida en curso.
func _show_minigame_list() -> void:
	_clear_minigame()
	if progress_panel:
		progress_panel.visible = true
	minigame_play.visible = false
	minigame_list.visible = true

# ¿Están las cuatro virtudes en su tope? Entonces ya no hay ninguna que sugerir.
func _is_fully_cultivated() -> bool:
	return ProgressStore.total_virtue_points(_progress) >= Virtues.DATA.size() * Virtues.MAX_POINTS

# Muestra un aviso que se desvanece tras unos segundos.
func _show_toast(message: String) -> void:
	toast_label.text = message
	toast_label.modulate.a = 1.0

	if _toast_tween and _toast_tween.is_valid():
		_toast_tween.kill()
	_toast_tween = create_tween()
	_toast_tween.tween_interval(2.5)
	_toast_tween.tween_property(toast_label, "modulate:a", 0.0, 0.6)
