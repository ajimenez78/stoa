extends Dungeon

const QUOTE_STRING_TEMPLATE =  "[font_size=16][i][color=black]%s[/color][/i][/font_size]"
const AUTHOR_STRING_TEMPLATE =  "[font_size=16][color=brown]- %s[/color][/font_size]"
const QUOTES_DATABASE_PATH = "res://Dungeons/quotes.json"

@export var quote_rich_text_label: RichTextLabel
@export var author_rich_text_label: RichTextLabel

@onready var previous_button: TextureButton = $UI/SabiduríaEstoica/PreviousButton
@onready var next_button: TextureButton = $UI/SabiduríaEstoica/NextButton

# History of quotes shown, with a pointer to the currently displayed one.
var _history: Array[Dictionary] = []
var _current_index: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_button.pressed.connect(_on_next_pressed)
	previous_button.pressed.connect(_on_previous_pressed)
	_on_next_pressed()

# Shows the next quote: moves forward in history, or picks a new random one
# when already at the most recent entry.
func _on_next_pressed() -> void:
	if _current_index < _history.size() - 1:
		_current_index += 1
	else:
		_history.append(_pick_random_quote())
		_current_index = _history.size() - 1
	_display_current_quote()

# Shows the previous quote in history.
func _on_previous_pressed() -> void:
	if _current_index > 0:
		_current_index -= 1
		_display_current_quote()

# Renders the quote at the current history index and updates button state.
func _display_current_quote() -> void:
	var quote := _history[_current_index]
	quote_rich_text_label.text = QUOTE_STRING_TEMPLATE % quote.get("quote", "")
	author_rich_text_label.text = AUTHOR_STRING_TEMPLATE % quote.get("author", "")
	previous_button.disabled = _current_index <= 0

# Loads the quotes database and returns a random entry as a Dictionary.
func _pick_random_quote() -> Dictionary:
	var file := FileAccess.open(QUOTES_DATABASE_PATH, FileAccess.READ)
	if file == null:
		push_error("No se pudo abrir la base de datos de frases: %s" % QUOTES_DATABASE_PATH)
		return {}

	var content := file.get_as_text()
	file.close()

	var quotes: Variant = JSON.parse_string(content)
	if not (quotes is Array) or quotes.is_empty():
		push_error("La base de datos de frases está vacía o mal formada: %s" % QUOTES_DATABASE_PATH)
		return {}

	return quotes.pick_random()
