# Mini-juego de la dicotomía del control: arrastra cada situación a la zona que
# le corresponde, según dependa o no de ti. Cada partida plantea unas cuantas
# situaciones tomadas al azar de la base de datos.
extends Minigame

const SITUATIONS_DATABASE_PATH := "res://Dungeons/Minigames/dichotomy_situations.json"
const SITUATION_CARD_SCENE := preload("res://Dungeons/Minigames/situation_card.tscn")

const SITUATIONS_PER_GAME := 5
const WISDOM_PER_HIT := 5
const TEMPERANCE_PER_HIT := 3

const CORRECT_TEMPLATE := "Correcto. %s"
const WRONG_TEMPLATE := "No es así. %s"
const CORRECT_COLOR := Color(0.15294, 0.68235, 0.37647)
const WRONG_COLOR := Color(0.90588, 0.29804, 0.23529)
const REMAINING_TEMPLATE := "Te quedan %d de %d situaciones"
const SUMMARY_TEMPLATE := "%d de %d aciertos"
const RESULT_TEMPLATE := "Distinguir lo que depende de ti de lo que no es la base de la serenidad estoica. Vuelve a practicarlo cuando quieras."

@export_group("Juego")
@export var board: Control
@export var controllable_zone: DropZone
@export var uncontrollable_zone: DropZone
@export var feedback_label: Label
@export var remaining_label: Label
@export var situation_list: VBoxContainer

@export_group("Resultado")
@export var result_panel: Control
@export var result_score_label: Label
@export var result_text_label: Label
@export var replay_button: Button

var _total := 0
var _hits := 0

func _ready() -> void:
	controllable_zone.item_dropped.connect(_on_item_dropped.bind(true))
	uncontrollable_zone.item_dropped.connect(_on_item_dropped.bind(false))
	replay_button.pressed.connect(start)

# Prepara una partida nueva.
func start() -> void:
	_hits = 0

	for child in situation_list.get_children():
		situation_list.remove_child(child)
		child.queue_free()

	var situations := _pick_situations()
	_total = situations.size()
	for situation: Dictionary in situations:
		var card: SituationCard = SITUATION_CARD_SCENE.instantiate()
		situation_list.add_child(card)
		card.setup(situation)

	feedback_label.text = ""
	_update_remaining()
	board.visible = true
	result_panel.visible = false

# Elige al azar las situaciones de una partida.
func _pick_situations() -> Array[Dictionary]:
	var situations := _load_situations()
	situations.shuffle()

	var picked: Array[Dictionary] = []
	for situation: Variant in situations.slice(0, SITUATIONS_PER_GAME):
		if situation is Dictionary:
			picked.append(situation)
	return picked

# Lee la base de datos de situaciones del mini-juego.
func _load_situations() -> Array:
	var file := FileAccess.open(SITUATIONS_DATABASE_PATH, FileAccess.READ)
	if file == null:
		push_error("No se pudo abrir la base de datos de situaciones: %s" % SITUATIONS_DATABASE_PATH)
		return []

	var content := file.get_as_text()
	file.close()

	var situations: Variant = JSON.parse_string(content)
	if not (situations is Array):
		push_error("La base de datos de situaciones está mal formada: %s" % SITUATIONS_DATABASE_PATH)
		return []

	return situations

# Comprueba la situación soltada, explica el porqué y sigue con la siguiente.
func _on_item_dropped(item: Control, zone_is_controllable: bool) -> void:
	var card := item as SituationCard
	if card == null or card.get_parent() != situation_list:
		return

	var correct: bool = bool(card.situation["controllable"]) == zone_is_controllable
	if correct:
		_hits += 1

	feedback_label.text = (CORRECT_TEMPLATE if correct else WRONG_TEMPLATE) % card.situation["explanation"]
	feedback_label.add_theme_color_override("font_color", CORRECT_COLOR if correct else WRONG_COLOR)

	situation_list.remove_child(card)
	card.queue_free()
	_update_remaining()

	if situation_list.get_child_count() == 0:
		_finish()

func _update_remaining() -> void:
	remaining_label.text = REMAINING_TEMPLATE % [situation_list.get_child_count(), _total]

# Muestra el resultado y entrega los puntos ganados al gimnasio.
func _finish() -> void:
	var summary := SUMMARY_TEMPLATE % [_hits, _total]
	var rewards := {}
	if _hits > 0:
		rewards["wisdom"] = _hits * WISDOM_PER_HIT
		rewards["temperance"] = _hits * TEMPERANCE_PER_HIT

	result_score_label.text = summary
	result_text_label.text = RESULT_TEMPLATE
	board.visible = false
	result_panel.visible = true

	finished.emit(Minigame.make_result(rewards, summary))
