extends Dungeon

# Reflexiones guiadas del diario estoico. Cada una cultiva una virtud cardinal.
const PROMPTS := [
	{
		"id": "premeditatio",
		"question": "¿Qué podría salir mal hoy? ¿Cómo te prepararías?",
		"description": "Premeditatio Malorum · Anticipa obstáculos para estar preparado",
		"virtue": "temperance",
	},
	{
		"id": "control",
		"question": "¿Qué estuvo bajo tu control hoy? ¿Qué no lo estuvo?",
		"description": "Dicotomía del Control · Distingue lo que puedes y no puedes controlar",
		"virtue": "wisdom",
	},
	{
		"id": "gratitude",
		"question": "¿Por qué tres cosas estás agradecido hoy?",
		"description": "Práctica de Gratitud · Reconoce las bendiciones presentes",
		"virtue": "justice",
	},
	{
		"id": "virtue",
		"question": "¿En qué momento actuaste según tus valores hoy? ¿Cuándo no lo hiciste?",
		"description": "Examen de Virtud · Reflexiona sobre tu carácter",
		"virtue": "courage",
	},
]

const VIRTUE_POINTS_PER_ENTRY := 8
const SAVED_MESSAGE := "Entrada guardada. Has ganado puntos de virtud."
const MONTH_NAMES := [
	"enero", "febrero", "marzo", "abril", "mayo", "junio",
	"julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre",
]

const PROMPT_CARD_SCENE := preload("res://Dungeons/UI/prompt_card.tscn")
const ENTRY_CARD_SCENE := preload("res://Dungeons/UI/journal_entry_card.tscn")

@export_group("Estadísticas")
@export var entries_value_label: Label
@export var streak_value_label: Label
@export var practices_value_label: Label

@export_group("Pestañas")
@export var new_entry_tab: Button
@export var history_tab: Button

@export_group("Nueva entrada")
@export var new_entry_panel: Control
@export var prompt_grid: GridContainer
@export var question_label: Label
@export var entry_text_edit: TextEdit
@export var char_count_label: Label
@export var save_button: Button
@export var toast_label: Label

@export_group("Historial")
@export var history_panel: Control
@export var history_list: VBoxContainer
@export var empty_history: Control

var _progress: Dictionary
var _selected_prompt: Dictionary = PROMPTS[0]
var _prompt_group := ButtonGroup.new()
var _toast_tween: Tween

func _ready() -> void:
	_progress = ProgressStore.register_visit()

	new_entry_tab.pressed.connect(_show_new_entry)
	history_tab.pressed.connect(_show_history)
	entry_text_edit.text_changed.connect(_update_writing_state)
	save_button.pressed.connect(_on_save_pressed)

	toast_label.modulate.a = 0.0
	_build_prompt_cards()
	_restore_draft()
	_refresh_stats()
	_rebuild_history()
	_show_new_entry()

# Guarda la reflexión a medio escribir al salir del hogar.
func _exit_tree() -> void:
	ProgressStore.save_draft(_selected_prompt.get("id", ""), entry_text_edit.text)

# Crea una tarjeta por cada reflexión guiada; solo una puede estar elegida.
func _build_prompt_cards() -> void:
	for prompt: Dictionary in PROMPTS:
		var card: PromptCard = PROMPT_CARD_SCENE.instantiate()
		prompt_grid.add_child(card)
		card.setup(prompt)
		card.button_group = _prompt_group
		card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		card.pressed.connect(_on_prompt_pressed.bind(card))

# Recupera la reflexión y el texto que quedaron sin guardar.
func _restore_draft() -> void:
	var draft: Dictionary = _progress["draft"]
	_select_prompt(_prompt_index(str(draft.get("prompt_id", ""))))
	entry_text_edit.text = str(draft.get("content", ""))
	_update_writing_state()

func _on_prompt_pressed(card: PromptCard) -> void:
	_select_prompt(_prompt_index(str(card.prompt.get("id", ""))))

# Marca una reflexión como la elegida y la muestra sobre el área de escritura.
func _select_prompt(index: int) -> void:
	_selected_prompt = PROMPTS[index]
	question_label.text = _selected_prompt["question"]
	var card := prompt_grid.get_child(index) as Button
	card.button_pressed = true

func _prompt_index(prompt_id: String) -> int:
	for index: int in PROMPTS.size():
		if PROMPTS[index]["id"] == prompt_id:
			return index
	return 0

# Actualiza el contador de caracteres y habilita el guardado.
func _update_writing_state() -> void:
	var text := entry_text_edit.text
	char_count_label.text = "%d caracteres" % text.length()
	save_button.disabled = text.strip_edges().is_empty()

func _on_save_pressed() -> void:
	var content := entry_text_edit.text.strip_edges()
	if content.is_empty():
		return

	_progress = ProgressStore.add_journal_entry(
		_selected_prompt["question"],
		content,
		_selected_prompt["virtue"],
		VIRTUE_POINTS_PER_ENTRY,
	)
	entry_text_edit.text = ""
	ProgressStore.save_draft("", "")

	_update_writing_state()
	_refresh_stats()
	_rebuild_history()
	_show_toast(SAVED_MESSAGE)

func _refresh_stats() -> void:
	entries_value_label.text = str((_progress["journal_entries"] as Array).size())
	streak_value_label.text = str(int(_progress["current_streak"]))
	practices_value_label.text = str((_progress["completed_practices"] as Array).size())

# Rehace la lista del historial con las entradas guardadas, la más reciente
# primero.
func _rebuild_history() -> void:
	for child in history_list.get_children():
		history_list.remove_child(child)
		child.queue_free()

	var entries: Array = _progress["journal_entries"]
	empty_history.visible = entries.is_empty()

	for entry in entries:
		if not (entry is Dictionary):
			continue
		var card: JournalEntryCard = ENTRY_CARD_SCENE.instantiate()
		history_list.add_child(card)
		card.setup(
			str(entry.get("prompt", "")),
			_format_date(str(entry.get("date", ""))),
			str(entry.get("content", "")),
		)

func _show_new_entry() -> void:
	new_entry_tab.button_pressed = true
	new_entry_panel.visible = true
	history_panel.visible = false

func _show_history() -> void:
	history_tab.button_pressed = true
	new_entry_panel.visible = false
	history_panel.visible = true

# Muestra un aviso que se desvanece tras unos segundos.
func _show_toast(message: String) -> void:
	toast_label.text = message
	toast_label.modulate.a = 1.0

	if _toast_tween and _toast_tween.is_valid():
		_toast_tween.kill()
	_toast_tween = create_tween()
	_toast_tween.tween_interval(2.5)
	_toast_tween.tween_property(toast_label, "modulate:a", 0.0, 0.6)

# Convierte una fecha ISO en el formato "28 de julio de 2026, 18:04".
func _format_date(iso_date: String) -> String:
	var date := Time.get_datetime_dict_from_datetime_string(iso_date, false)
	if date.is_empty():
		return iso_date

	return "%d de %s de %d, %02d:%02d" % [
		date["day"], MONTH_NAMES[int(date["month"]) - 1], date["year"],
		date["hour"], date["minute"],
	]
