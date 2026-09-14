extends Node2D
## Strategic galaxy overview: systems for the chosen map size, sector
## selection listing that sector's systems. Drag to pan, wheel to zoom,
## double-click a sector to focus it. Placeholder tags only.

## Pan/zoom are built and tested but parked until the map flow wants them.
const ENABLE_PAN_ZOOM := false

var _map_w := 900.0
var _map_h := 720.0
var _map_center := Vector2(450.0, 360.0)
var _margin := 40.0
var _click_radius := 14.0
var _sector_radius := 30.0
var _min_zoom := 0.6
var _max_zoom := 4.0
var _zoom_step := 1.15
var _drag_threshold := 6.0
var _pip_origin := Vector2(16, 64)
var _pip_size := Vector2(426, 312)
var _pip_gap := 16.0
var _dot_e := 5.0
var _dot_u := 4.0

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
var _day := 0.0
var _shown_day := -1
var _speed := 2
var _speed_names := PackedStringArray()
var _day_lengths := PackedFloat32Array()

const CARD_SCENE := preload("res://galaxy/system_card.tscn")
const PIP_SLOTS := 4

var _cards: Array = []
var _next_slot := 0
var _open_systems := {}

@onready var _sector_label: Label = %SectorLabel
@onready var _sector_button: OptionButton = %SectorButton
@onready var _system_list: ItemList = %SystemList
@onready var _day_label: Label = %DayLabel
@onready var _speed_button: OptionButton = %SpeedButton
@onready var _pip_grid: Control = %PiPGrid
@onready var _side_panel: PanelContainer = %Panel


func _ready() -> void:
	var settings := GalaxyData.load_settings()
	_side = int(settings["side"])
	_theme = GalaxyData.colors()
	_apply_theme()
	_sectors = GalaxyData.sectors_for_size(GalaxyData.load_sectors(), settings["size"])
	_systems = GalaxyData.systems_for_sectors(GalaxyData.load_systems(), _sectors)
	_setup_clock(int(settings["speed"]))
	_compute_transform()
	_center_galaxy()
	_populate_sector_picker()
	_spawn_cards()
	if not _sectors.is_empty():
		select_sector(_sectors[0]["id"])


func _apply_theme() -> void:
	var layout := GalaxyData.layout()
	var fonts := GalaxyData.fonts()
	_map_w = float(layout["map_width"])
	_map_h = float(layout["map_height"])
	_map_center = Vector2(_map_w, _map_h) * 0.5
	_margin = float(layout["map_margin"])
	_click_radius = float(layout["click_radius"])
	_sector_radius = float(layout["sector_radius"])
	_min_zoom = float(layout["zoom_min"])
	_max_zoom = float(layout["zoom_max"])
	_zoom_step = float(layout["zoom_step"])
	_drag_threshold = float(layout["drag_threshold"])
	_pip_origin = layout["pip_origin"]
	_pip_size = layout["pip_size"]
	_pip_gap = float(layout["pip_gap"])
	_dot_e = float(layout["dot_explored"])
	_dot_u = float(layout["dot_unexplored"])
	_side_panel.offset_left = -float(layout["panel_width"])
	_sector_label.add_theme_font_size_override("font_size", int(fonts["panel_header"]))


func map_pos(p: Vector2i) -> Vector2:
	var base := Vector2(p) * _scale + _offset
	return (base - _map_center) * _zoom + _map_center + _pan


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
		card.position = _pip_origin + Vector2(i % 2, i / 2) * (_pip_size + Vector2(_pip_gap, _pip_gap))
		card.size = _pip_size
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
					_zoom_at(mb.position, _zoom_step)
			MOUSE_BUTTON_WHEEL_DOWN:
				if mb.pressed and ENABLE_PAN_ZOOM:
					_zoom_at(mb.position, 1.0 / _zoom_step)
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
		if not _dragging and mm.position.distance_to(_press_pos) > _drag_threshold:
			_dragging = true
		if _dragging:
			_pan_by(mm.relative)


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")


func _on_sector_selected(index: int) -> void:
	select_sector(int(_sector_button.get_item_metadata(index)))


func _setup_clock(saved_speed: int) -> void:
	var clock := GalaxyData.time()
	_speed_names = clock["speed_names"]
	_day_lengths = clock["day_lengths"]
	_speed_button.clear()
	for n in _speed_names:
		_speed_button.add_item(n)
	_speed = clampi(saved_speed, 0, _speed_names.size() - 1)
	_speed_button.select(_speed)
	_refresh_day()


func _process(delta: float) -> void:
	if delta > 0.0 and not _day_lengths.is_empty():
		_tick(delta)


## Advance the clock by real seconds; split out for exact testing.
func _tick(seconds: float) -> void:
	_day += seconds / _day_lengths[_speed]
	_refresh_day()


func _refresh_day() -> void:
	var whole := int(_day)
	if whole != _shown_day:
		_shown_day = whole
		_day_label.text = "Day %d" % whole


func _on_speed_selected(index: int) -> void:
	_speed = clampi(index, 0, _speed_names.size() - 1)
	GalaxyData.save_setting("time", "speed", _speed)


func _zoom_at(screen_point: Vector2, factor: float) -> void:
	var next := clampf(_zoom * factor, _min_zoom, _max_zoom)
	_pan = screen_point - _map_center - (screen_point - _map_center - _pan) * (next / _zoom)
	_zoom = next
	queue_redraw()


func _pan_by(delta: Vector2) -> void:
	_pan += delta
	queue_redraw()


func _click_at(point: Vector2) -> void:
	var best_sector := -1
	var best_dist := _click_radius
	for sys in _systems:
		var d := map_pos(sys["pos"]).distance_to(point)
		if d < best_dist:
			best_dist = d
			best_sector = sys["sector"]
	if best_sector < 0:
		best_dist = _sector_radius
		for s in _sectors:
			var d := map_pos(s["pos"]).distance_to(point)
			if d < best_dist:
				best_dist = d
				best_sector = s["id"]
	if best_sector >= 0:
		select_sector(best_sector)


func _double_click_at(point: Vector2) -> void:
	var best: Dictionary = {}
	var best_dist := _sector_radius * 2.0
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


## Center the backdrop spiral on the displayed sectors so the sectors
## read as part of the galaxy. Runs after the transform is known.
func _center_galaxy() -> void:
	if _sectors.is_empty():
		return
	var centroid := Vector2.ZERO
	for s in _sectors:
		centroid += map_pos(s["pos"])
	centroid /= float(_sectors.size())
	var radius := 200.0
	for s in _sectors:
		radius = maxf(radius, centroid.distance_to(map_pos(s["pos"])))
	var field: Node2D = $Backdrop/Starfield
	field.call("build_galaxy", centroid, radius * float(GalaxyData.backdrop()["galaxy_scale"]))


func _compute_transform() -> void:
	var min_p := Vector2(INF, INF)
	var max_p := Vector2(-INF, -INF)
	for sys in _systems:
		var p := Vector2(sys["pos"])
		min_p = min_p.min(p)
		max_p = max_p.max(p)
	var span := (max_p - min_p) + Vector2(40, 40)
	_scale = minf((_map_w - _margin * 2.0) / span.x, (_map_h - _margin * 2.0) / span.y)
	var used := span * _scale
	_offset = (Vector2(_map_w, _map_h) - used) * 0.5 - (min_p - Vector2(20, 20)) * _scale


func _draw() -> void:
	for sys in _systems:
		var p := map_pos(sys["pos"])
		var color: Color = _theme.get("explored", Color.BLUE) if sys["explored"] else _theme.get("unexplored", Color.GRAY)
		var radius := _dot_e if sys["explored"] else _dot_u
		if sys["sector"] == _selected_sector:
			draw_circle(p, (radius + 3.0) * _zoom, _selection_color())
		draw_circle(p, radius * _zoom, color)
		if _open_systems.has(int(sys["id"])):
			draw_arc(p, (radius + 6.0) * _zoom, 0.0, TAU, 32, _theme.get("open", Color.ORANGE), 2.0)
	var font := ThemeDB.fallback_font
	if font != null:
		for s in _sectors:
			draw_string(font, map_pos(s["pos"]) + Vector2(10, -10), s["tag"],
				HORIZONTAL_ALIGNMENT_LEFT, -1.0, int(GalaxyData.fonts()["sector_tag"]), _theme.get("tag", Color.WHITE))
