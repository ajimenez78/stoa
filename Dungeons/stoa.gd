extends Dungeon

const QUOTE_STRING_TEMPLATE =  "[font_size=16][i][color=black]%s[/color][/i][/font_size]"
const AUTHOR_STRING_TEMPLATE =  "[font_size=16][color=brown]- %s[/color][/font_size]"

@export var quote_rich_text_label: RichTextLabel
@export var author_rich_text_label: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quote_rich_text_label.text = QUOTE_STRING_TEMPLATE % "No podemos controlar lo que nos sucede, pero sí cómo respondemos a ello"
	author_rich_text_label.text = AUTHOR_STRING_TEMPLATE % "Epicteto"
