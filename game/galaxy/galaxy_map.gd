extends Node2D
## Strategic galaxy overview: systems for the chosen map size, sector
## selection listing that sector's systems. Drag to pan, wheel to zoom,
## double-click a sector to focus it. Placeholder tags only.

const MAP_WIDTH := 900.0
const MAP_HEIGHT := 720.0
const MAP_CENTER := Vector2(450.0, 360.0)
const MARGIN := 40.0
const CLICK_RADIUS := 14.0
const SECTOR_RADIUS := 30.0
const MIN_ZOOM := 0.6
const MAX_ZOOM := 4.0
const ZOOM_STEP := 1.15
const DRAG_THRESHOLD := 6.0

## Pan/zoom are built and tested but parked until the map flow wants them.
const ENABLE_PAN_ZOOM := false

var _systems: Array = []
var _sectors: Array = []
var _selected_sector := -1
var _side := 0
var _scale := 1.0
var _offset := Vector2.ZERO
var _zoom := 1.0
var _pan := Vector2.ZERO
var _pressing := false
var _dragging := false
var _press_pos := Vector2.ZERO
var _theme: Dictionary = {}

const CARD_SCENE := preload("res://galaxy/system_card.tscn")
const PIP_ORIGIN := Vector2(16, 64)
const PIP_SIZE := Vector2(426, 312)
const PIP_GAP := 16.0
const PIP_SLOTS := 4

var _cards: Array = []
var _next_slot := 0
var _open_systems := {}

@onready var _sector_label: Label = %SectorLabel
@onready var _sector_button: OptionButton = %SectorButton
@onready var _system_list: ItemList = %SystemList
@onready var _settings_label: Label = %SettingsLabel
@onready var _pip_grid: Control = %PiPGrid


func _ready() -> void:
	var settings := GalaxyData.load_settings()
	_side = int(settings["side"])
	_theme = GalaxyData.colors()
	_sectors = GalaxyData.sectors_for_size(GalaxyData.load_sectors(), settings["size"])
	_systems = GalaxyData.systems_for_sectors(GalaxyData.load_systems(), _sectors)
	_settings_label.text = "%s  •  %s galaxy  •  %s" % [settings["side_name"], settings["size_name"], settings["difficulty_name"]]
	_compute_transform()
	_populate_sector_picker()
	_spawn_cards()
	if not _sectors.is_empty():
		select_sector(_sectors[0]["id"])


func map_pos(p: Vector2i) -> Vector2:
	var base := Vector2(p) * _scale + _offset
	return (base - MAP_CENTER) * _zoom + MAP_CENTER + _pan


func reset_view() -> void:
	_zoom = 1.0
	_pan = Vector2.ZERO
	queue_redraw()


func select_sector(sector_id: int) -> void:
	_selected_sector = sector_id
	for i in range(_sector_button.item_count):
		if _sector_button.get_item_metadata(i) == sector_id:
			_sector_button.select(i)
			break
	var names: PackedStringArray = []
	var explored := 0
	var total := 0
	var tag := ""
	for s in _sectors:
		if s["id"] == sector_id:
			tag = s["tag"]
	for sys in _systems:
		if sys["sector"] == sector_id:
			total += 1
			names.append(sys["tag"])
			if sys["explored"]:
				explored += 1
	names.sort()
	_sector_label.text = "%s — %d/%d charted" % [tag, explored, total]
	_system_list.clear()
	for n in names:
		_system_list.add_item(n)
	queue_redraw()


func _spawn_cards() -> void:
	for i in range(PIP_SLOTS):
		var card: SystemCard = CARD_SCENE.instantiate()
		card.position = PIP_ORIGIN + Vector2(i % 2, i / 2) * (PIP_SIZE + Vector2(PIP_GAP, PIP_GAP))
		card.size = PIP_SIZE
		card.visible = false
		card.closed.connect(_refresh_open_indicators)
		card.focus_changed.connect(_refresh_open_indicators)
		_pip_grid.add_child(card)
		_cards.append(card)


func _open_card(sys: Dictionary) -> void:
	var card: SystemCard = _first_hidden_card()
	if card == null:
		card = _cards[_next_slot]
		_next_slot = (_next_slot + 1) % PIP_SLOTS
	card.open_sector(int(sys["sector"]), _sector_tag(int(sys["sector"])), _systems_in_sector(int(sys["sector"])))
	card.focus_system(sys)
	_refresh_open_indicators()


func _card_for_sector(sector_id: int) -> SystemCard:
	for c in _cards:
		var card := c as SystemCard
		if card.visible and card.sector_id == sector_id:
			return card
	return null


func _first_hidden_card() -> SystemCard:
	for c in _cards:
		if not (c as SystemCard).visible:
			return c
	return null


func _refresh_open_indicators() -> void:
	_open_systems.clear()
	for c in _cards:
		var card := c as SystemCard
		if card.visible and card.focused_id >= 0:
			_open_systems[card.focused_id] = true
	queue_redraw()


func _hide_all_cards() -> void:
	for card in _cards:
		(card as PanelContainer).visible = false
	_refresh_open_indicators()


func _systems_in_sector(sector_id: int) -> Array:
	var out: Array = []
	for sys in _systems:
		if int(sys["sector"]) == sector_id:
			out.append(sys)
	out.sort_custom(func(a: Dictionary, b: Dictionary) -> bool: return str(a["tag"]) < str(b["tag"]))
	return out


func _selection_color() -> Color:
	return _theme.get("alliance", Color.RED) if _side == 0 else _theme.get("empire", Color.GREEN)


func _sector_tag(sector_id: int) -> String:
	for s in _sectors:
		if s["id"] == sector_id:
			return s["tag"]
	return "S??"


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mb := event as InputEventMouseButton
		match mb.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				if mb.pressed and ENABLE_PAN_ZOOM:
					_zoom_at(mb.position, ZOOM_STEP)
			MOUSE_BUTTON_WHEEL_DOWN:
				if mb.pressed and ENABLE_PAN_ZOOM:
					_zoom_at(mb.position, 1.0 / ZOOM_STEP)
			MOUSE_BUTTON_LEFT:
				if mb.pressed:
					if mb.double_click:
						_double_click_at(mb.position)
					else:
						_pressing = true
						_dragging = false
						_press_pos = mb.position
				elif _pressing:
					_pressing = false
					if not _dragging:
						_click_at(mb.position)
					_dragging = false
	elif event is InputEventMouseMotion and _pressing:
		if not ENABLE_PAN_ZOOM:
			return
		var mm := event as InputEventMouseMotion
		if not _dragging and mm.position.distance_to(_press_pos) > DRAG_THRESHOLD:
			_dragging = true
		if _dragging:
			_pan_by(mm.relative)


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")


func _on_sector_selected(index: int) -> void:
	select_sector(int(_sector_button.get_item_metadata(index)))


func _zoom_at(screen_point: Vector2, factor: float) -> void:
	var next := clampf(_zoom * factor, MIN_ZOOM, MAX_ZOOM)
	_pan = screen_point - MAP_CENTER - (screen_point - MAP_CENTER - _pan) * (next / _zoom)
	_zoom = next
	queue_redraw()


func _pan_by(delta: Vector2) -> void:
	_pan += delta
	queue_redraw()


func _click_at(point: Vector2) -> void:
	var best_sector := -1
	var best_dist := CLICK_RADIUS
	for sys in _systems:
		var d := map_pos(sys["pos"]).distance_to(point)
		if d < best_dist:
			best_dist = d
			best_sector = sys["sector"]
	if best_sector < 0:
		best_dist = SECTOR_RADIUS
		for s in _sectors:
			var d := map_pos(s["pos"]).distance_to(point)
			if d < best_dist:
				best_dist = d
				best_sector = s["id"]
	if best_sector >= 0:
		select_sector(best_sector)


func _double_click_at(point: Vector2) -> void:
	var best: Dictionary = {}
	var best_dist := SECTOR_RADIUS * 2.0
	for sys in _systems:
		var d := map_pos(sys["pos"]).distance_to(point)
		if d < best_dist:
			best_dist = d
			best = sys
	if best.is_empty():
		_hide_all_cards()
		return
	select_sector(best["sector"])
	var open_card := _card_for_sector(int(best["sector"]))
	if open_card == null:
		_open_card(best)
	else:
		open_card.focus_system(best)
		open_card.flash()


func _populate_sector_picker() -> void:
	_sector_button.clear()
	for s in _sectors:
		_sector_button.add_item(s["tag"])
		_sector_button.set_item_metadata(_sector_button.item_count - 1, s["id"])


func _compute_transform() -> void:
	var min_p := Vector2(INF, INF)
	var max_p := Vector2(-INF, -INF)
	for sys in _systems:
		var p := Vector2(sys["pos"])
		min_p = min_p.min(p)
		max_p = max_p.max(p)
	var span := (max_p - min_p) + Vector2(40, 40)
	_scale = minf((MAP_WIDTH - MARGIN * 2.0) / span.x, (MAP_HEIGHT - MARGIN * 2.0) / span.y)
	var used := span * _scale
	_offset = (Vector2(MAP_WIDTH, MAP_HEIGHT) - used) * 0.5 - (min_p - Vector2(20, 20)) * _scale


func _draw() -> void:
	for sys in _systems:
		var p := map_pos(sys["pos"])
		var color: Color = _theme.get("explored", Color.BLUE) if sys["explored"] else _theme.get("unexplored", Color.GRAY)
		var radius := 5.0 if sys["explored"] else 4.0
		if sys["sector"] == _selected_sector:
			draw_circle(p, (radius + 3.0) * _zoom, _selection_color())
		draw_circle(p, radius * _zoom, color)
		if _open_systems.has(int(sys["id"])):
			draw_arc(p, (radius + 6.0) * _zoom, 0.0, TAU, 32, _theme.get("open", Color.ORANGE), 2.0)
	var font := ThemeDB.fallback_font
	if font != null:
		for s in _sectors:
			draw_string(font, map_pos(s["pos"]) + Vector2(10, -10), s["tag"],
				HORIZONTAL_ALIGNMENT_LEFT, -1.0, 18, _theme.get("tag", Color.WHITE))
