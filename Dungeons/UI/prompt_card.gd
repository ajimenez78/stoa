# Tarjeta seleccionable con una de las reflexiones guiadas del diario estoico.
class_name PromptCard extends Button

@export var question_label: Label
@export var description_label: Label

var prompt: Dictionary

# Rellena la tarjeta con los datos de una reflexión guiada.
func setup(new_prompt: Dictionary) -> void:
	prompt = new_prompt
	question_label.text = new_prompt.get("question", "")
	description_label.text = new_prompt.get("description", "")
