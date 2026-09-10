class_name SystemCard
extends PanelContainer
## One picture-in-picture system card: sector mini-map plus a focused
## system readout. Self-contained; the map only calls open/focus.

signal closed
signal focus_changed

var focused_id := -1
var sector_id := -1

var _systems: Array = []
var _flash_tween: Tween = null

@onready var _title: Label = %CardTitle
@onready var _mini: Control = %SectorMap
@onready var _details: Label = %CardDetails


func flash() -> void:
	if _flash_tween != null and _flash_tween.is_valid():
		_flash_tween.kill()
	modulate = GalaxyData.colors().get("flash", Color.WHITE)
	_flash_tween = create_tween()
	_flash_tween.tween_property(self, "modulate", Color.WHITE, 1.0)


func open_sector(sector_id_value: int, sector_tag: String, systems: Array) -> void:
	_systems = systems
	sector_id = sector_id_value
	focused_id = -1
	var explored := 0
	for s in systems:
		if s["explored"]:
			explored += 1
	_title.text = "%s — %d/%d charted" % [sector_tag, explored, systems.size()]
	_mini.call("show_sector", systems, focused_id)
	_details.text = "Pick a system"
	visible = true


func focus_system(sys: Dictionary) -> void:
	focused_id = int(sys["id"])
	_mini.call("show_sector", _systems, focused_id)
	var status := "Charted" if sys["explored"] else "Uncharted"
	_details.text = "%s\nStatus: %s\nPosition %d, %d" % [sys["tag"], status, sys["pos"].x, sys["pos"].y]
	focus_changed.emit()


func _on_mini_picked(system_id: int) -> void:
	for s in _systems:
		if int(s["id"]) == system_id:
			focus_system(s)
			return


func _on_close_pressed() -> void:
	visible = false
	focused_id = -1
	sector_id = -1
	if _flash_tween != null and _flash_tween.is_valid():
		_flash_tween.kill()
	modulate = Color.WHITE
	closed.emit()
