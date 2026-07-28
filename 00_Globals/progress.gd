# Almacén del progreso del aprendiz: entradas del diario estoico, puntos de
# virtud, racha de visitas y el borrador de la entrada en curso.
# Se persiste como JSON en user:// para que funcione en Android, iOS y web.
class_name ProgressStore extends RefCounted

const SAVE_PATH := "user://progress.json"
const MAX_VIRTUE_POINTS := 100
const DEFAULT_VIRTUES := {
	"wisdom": 0,
	"justice": 0,
	"courage": 0,
	"temperance": 0,
}

# Devuelve el progreso guardado, completado con los valores por omisión.
static func load_progress() -> Dictionary:
	if not FileAccess.file_exists(SAVE_PATH):
		return _default_progress()

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		push_error("No se pudo leer el progreso: %s" % SAVE_PATH)
		return _default_progress()

	var content := file.get_as_text()
	file.close()

	var data: Variant = JSON.parse_string(content)
	if not (data is Dictionary):
		push_error("El progreso guardado está mal formado: %s" % SAVE_PATH)
		return _default_progress()

	return _merge_defaults(data)

# Escribe el progreso completo en disco.
static func save_progress(progress: Dictionary) -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("No se pudo guardar el progreso: %s" % SAVE_PATH)
		return

	file.store_string(JSON.stringify(progress, "\t"))
	file.close()

# Añade una entrada al diario (la más reciente primero) y suma los puntos de
# virtud correspondientes. Devuelve el progreso resultante.
static func add_journal_entry(prompt: String, content: String, virtue: String, points: int) -> Dictionary:
	var progress := load_progress()

	var entries: Array = progress["journal_entries"]
	entries.insert(0, {
		"date": Time.get_datetime_string_from_system(),
		"prompt": prompt,
		"content": content,
		"virtue": virtue,
	})

	var virtues: Dictionary = progress["virtues"]
	if virtues.has(virtue):
		virtues[virtue] = mini(int(virtues[virtue]) + points, MAX_VIRTUE_POINTS)

	save_progress(progress)
	return progress

# Actualiza la racha de días consecutivos con visita al hogar.
static func register_visit() -> Dictionary:
	var progress := load_progress()
	var today := Time.get_date_string_from_system()
	var last_visit: String = progress["last_visit"]

	if last_visit == today:
		return progress

	if last_visit.is_empty():
		progress["current_streak"] = 1
	else:
		var days := _days_between(last_visit, today)
		if days == 1:
			progress["current_streak"] = int(progress["current_streak"]) + 1
		elif days > 1:
			progress["current_streak"] = 1

	progress["last_visit"] = today
	save_progress(progress)
	return progress

# Guarda la reflexión a medio escribir para recuperarla en la próxima visita.
static func save_draft(prompt_id: String, content: String) -> void:
	var progress := load_progress()
	progress["draft"] = {"prompt_id": prompt_id, "content": content}
	save_progress(progress)

static func _default_progress() -> Dictionary:
	return {
		"journal_entries": [],
		"virtues": DEFAULT_VIRTUES.duplicate(),
		"completed_practices": [],
		"current_streak": 0,
		"last_visit": "",
		"draft": {"prompt_id": "", "content": ""},
	}

# Completa los datos leídos con las claves que falten, para que una partida
# antigua siga siendo válida al añadir campos nuevos.
static func _merge_defaults(data: Dictionary) -> Dictionary:
	var progress := _default_progress()
	progress.merge(data, true)

	var virtues: Dictionary = DEFAULT_VIRTUES.duplicate()
	if data.get("virtues") is Dictionary:
		virtues.merge(data["virtues"], true)
	progress["virtues"] = virtues

	if not (progress["journal_entries"] is Array):
		progress["journal_entries"] = []
	if not (progress["draft"] is Dictionary):
		progress["draft"] = {"prompt_id": "", "content": ""}

	return progress

# Días completos transcurridos entre dos fechas "AAAA-MM-DD".
static func _days_between(from_date: String, to_date: String) -> int:
	var from_seconds := Time.get_unix_time_from_datetime_string(from_date)
	var to_seconds := Time.get_unix_time_from_datetime_string(to_date)
	return int(floor((to_seconds - from_seconds) / 86400.0))
