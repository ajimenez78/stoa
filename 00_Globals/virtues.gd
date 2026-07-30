# Datos compartidos de las cuatro virtudes cardinales: nombre visible, color
# identificativo y niveles de maestría.
class_name Virtues extends RefCounted

const MAX_POINTS := ProgressStore.MAX_VIRTUE_POINTS

# El orden de las claves fija el orden en que se muestran las virtudes.
const DATA := {
	"wisdom": {"name": "Sabiduría", "color": Color(0.2902, 0.56471, 0.88627)},
	"justice": {"name": "Justicia", "color": Color(0.95294, 0.61176, 0.07059)},
	"courage": {"name": "Coraje", "color": Color(0.90588, 0.29804, 0.23529)},
	"temperance": {"name": "Templanza", "color": Color(0.15294, 0.68235, 0.37647)},
}

# Rangos de maestría, cada uno con el porcentaje mínimo que hay que alcanzar.
const RANKS := [
	{"name": "Aprendiz", "min_ratio": 0.0},
	{"name": "Discípulo", "min_ratio": 0.33},
	{"name": "Sabio", "min_ratio": 0.66},
]

static func display_name(virtue: String) -> String:
	return DATA[virtue]["name"] if DATA.has(virtue) else virtue

static func color(virtue: String) -> Color:
	return DATA[virtue]["color"] if DATA.has(virtue) else Color.WHITE

# Rango de maestría alcanzado con los puntos dados.
static func rank(points: int) -> String:
	var ratio := float(points) / float(MAX_POINTS)
	var result: String = RANKS[0]["name"]
	for level: Dictionary in RANKS:
		if ratio >= float(level["min_ratio"]):
			result = level["name"]
	return result
