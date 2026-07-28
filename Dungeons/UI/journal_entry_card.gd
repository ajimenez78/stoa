# Tarjeta de una entrada ya escrita, usada en el historial de reflexiones.
class_name JournalEntryCard extends PanelContainer

@export var prompt_label: Label
@export var date_label: Label
@export var content_label: Label

# Rellena la tarjeta con una entrada del diario y su fecha ya formateada.
func setup(prompt: String, date: String, content: String) -> void:
	prompt_label.text = prompt
	date_label.text = date
	content_label.text = content
