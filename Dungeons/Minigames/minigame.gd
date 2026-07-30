# Base de los mini-juegos del gimnasio. Cada mini-juego concreto redefine
# `start()` para preparar una partida y emite `finished` al terminarla; el
# gimnasio lo carga, lo muestra en su pestaña y persiste su recompensa.
#
# La guía para añadir un mini-juego nuevo está en Dungeons/Minigames/README.md.
class_name Minigame extends Control

# Resultado de una partida. `rewards` lleva los puntos ganados por virtud
# ({"wisdom": 20, ...}) y `summary` una línea con el resultado para el aviso.
signal finished(result: Dictionary)

# Prepara una partida nueva.
func start() -> void:
	pass

# Construye el resultado que espera el gimnasio.
static func make_result(rewards: Dictionary, summary: String) -> Dictionary:
	return {"rewards": rewards, "summary": summary}
