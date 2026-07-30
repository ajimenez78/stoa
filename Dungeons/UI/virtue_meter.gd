# Barra de progreso de una virtud cardinal, con su rango de maestría.
class_name VirtueMeter extends VBoxContainer

@export var dot: Panel
@export var name_label: Label
@export var rank_label: Label
@export var bar: ProgressBar

# Muestra los puntos acumulados en una virtud y el rango que le corresponde.
func setup(virtue: String, points: int) -> void:
	var color := Virtues.color(virtue)

	name_label.text = Virtues.display_name(virtue)
	rank_label.text = "%s · %d/%d" % [Virtues.rank(points), points, Virtues.MAX_POINTS]
	dot.self_modulate = color

	bar.max_value = Virtues.MAX_POINTS
	bar.value = points

	var fill := bar.get_theme_stylebox("fill").duplicate() as StyleBoxFlat
	fill.bg_color = color
	bar.add_theme_stylebox_override("fill", fill)
