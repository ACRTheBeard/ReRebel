class_name SystemCard
extends PanelContainer
## One picture-in-picture sector card: a large interactive mini-map of the
## sector's systems plus a header. Self-contained; the map only calls
## open/focus. Detail space below the map is reserved for future system
## options and properties.

signal closed
signal focus_changed

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
