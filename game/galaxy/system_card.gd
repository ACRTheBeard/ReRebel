class_name SystemCard
extends PanelContainer
## One picture-in-picture sector card: a large interactive mini-map of the
## sector's systems plus a header. Self-contained; the map only calls
## open/focus. Detail space below the map is reserved for future system
## options and properties.

signal closed
signal focus_changed
signal manufacturing_requested(system_id: int)
signal construction_target_selected(system_id: int)

var focused_id := -1
var sector_id := -1

var _systems: Array = []
var _flash_tween: Tween = null

@onready var _title: Label = %CardTitle
@onready var _mini: Control = %SectorMap


func _ready() -> void:
	_title.add_theme_font_size_override("font_size", int(GalaxyData.fonts()["card_title"]))


func flash() -> void:
	if _flash_tween != null and _flash_tween.is_valid():
		_flash_tween.kill()
	modulate = GalaxyData.colors().get("flash", Color.WHITE)
	_flash_tween = create_tween()
	_flash_tween.tween_property(self, "modulate", Color.WHITE, float(GalaxyData.layout()["flash_seconds"]))


func open_sector(sector_id_value: int, sector_tag: String, systems: Array) -> void:
	_systems = systems
	sector_id = sector_id_value
	focused_id = -1
	_title.text = sector_tag
	_mini.call("show_sector", systems, focused_id)
	visible = true


func focus_system(sys: Dictionary) -> void:
	focused_id = int(sys["id"])
	_mini.call("show_sector", _systems, focused_id)
	focus_changed.emit()


func refresh_sector() -> void:
	if visible:
		_mini.queue_redraw()


func begin_target_selection() -> void:
	_mini.call("begin_target_selection")


func end_target_selection() -> void:
	_mini.call("end_target_selection")


func target_system_at_global(global_point: Vector2) -> int:
	if not visible or not _mini.get_global_rect().has_point(global_point):
		return -1
	var local_point := _mini.get_global_transform_with_canvas().affine_inverse() * global_point
	return int(_mini.call("target_system_at", local_point))


func _on_mini_picked(system_id: int) -> void:
	for s in _systems:
		if int(s["id"]) == system_id:
			focus_system(s)
			return


func _on_mini_manufacturing_requested(system_id: int) -> void:
	manufacturing_requested.emit(system_id)


func _on_mini_construction_target_selected(system_id: int) -> void:
	construction_target_selected.emit(system_id)


func _on_close_pressed() -> void:
	visible = false
	focused_id = -1
	sector_id = -1
	if _flash_tween != null and _flash_tween.is_valid():
		_flash_tween.kill()
	modulate = Color.WHITE
	closed.emit()
