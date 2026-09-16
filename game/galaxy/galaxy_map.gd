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
var _overlay_dragging := false
var _overlay_drag_offset := Vector2.ZERO
var _speed := 2
var _speed_names := PackedStringArray()
var _day_lengths := PackedFloat32Array()
var _map_filter := 0

const CARD_SCENE := preload("res://galaxy/system_card.tscn")
const ALLIANCE_EMBLEM := preload("res://art/alliance_emblem.png")
const EMPIRE_EMBLEM := preload("res://art/empire_emblem.png")
const FACTORY_ICON := preload("res://art/factory.png")
const FLEET_ICON := preload("res://art/dart_flight.png")
const GROUND_BASE_ICON := preload("res://art/ground_base.svg")
const PIP_SLOTS := 2

var _cards: Array = []
var _next_slot := 0
var _open_systems := {}

var _game_data: GameData


@onready var _sector_label: Label = %SectorLabel
@onready var _sector_button: OptionButton = %SectorButton
@onready var _system_list: ItemList = %SystemList
@onready var _day_label: Label = %DayLabel
@onready var _raw_label: Label = %Raw
@onready var _refined_label: Label = %Refined
@onready var _maintenance_label: Label = %Maintenance
@onready var _speed_button: OptionButton = %SpeedButton
@onready var _pip_grid: Control = %PiPGrid
@onready var _manufacturing_card: PanelContainer = %ManufacturingCard
@onready var _manufacturing_title: Label = %Title
@onready var _manufacturing_header: Control = $UI/ManufacturingCard/Margin/Column/HeaderRow
@onready var _manufacturing_close: Button = $UI/ManufacturingCard/Margin/Column/HeaderRow/CloseButton
@onready var _manufacturing_tabs: TabContainer = %ManufacturingTabs
@onready var _fleet_box: PanelContainer = %FleetBox
@onready var _troop_box: PanelContainer = %TroopBox
@onready var _construction_box: PanelContainer = %ConstructionBox
@onready var _assignment_status: Label = %AssignmentStatus
@onready var _fleet_available: Label = %FleetAvailable
@onready var _fleet_preview: TextureRect = %FleetPreview
@onready var _fleet_progress: ProgressBar = %FleetProgress
@onready var _troop_available: Label = %TroopAvailable
@onready var _troop_preview: TextureRect = %TroopPreview
@onready var _troop_progress: ProgressBar = %TroopProgress
@onready var _construction_available: Label = %ConstructionAvailable
@onready var _construction_preview: TextureRect = %ConstructionPreview
@onready var _construction_progress: ProgressBar = %ConstructionProgress
@onready var _construction_existing: HBoxContainer = %ConstructionExisting
@onready var _construction_building: Label = %ConstructionBuilding
@onready var _construction_transit: Label = %ConstructionTransit
@onready var _shipyard_existing: HBoxContainer = %ShipyardExisting
@onready var _shipyard_building: Label = %ShipyardBuilding
@onready var _shipyard_transit: Label = %ShipyardTransit
@onready var _training_existing: HBoxContainer = %TrainingExisting
@onready var _training_building: Label = %TrainingBuilding
@onready var _training_transit: Label = %TrainingTransit
@onready var _side_panel: PanelContainer = %Panel
@onready var _top_bar: PanelContainer = $UI/TopBar
@onready var _filter_button: OptionButton = %MapFilterButton


func _ready() -> void:
	var settings := GalaxyData.load_settings()
	_side = int(settings["side"])
	_theme = GalaxyData.colors()
	_apply_faction_top_bar_theme()
	_apply_theme()
	_setup_manufacturing_tabs()
	_theme_manufacturing_overlay()
	_sectors = GalaxyData.sectors_for_size(GalaxyData.load_sectors(), settings["size"])
	_systems = GalaxyData.systems_for_sectors(GalaxyData.load_systems(), _sectors)
	_game_data = GameData.new(_side, [], _systems, int(settings["difficulty"]))
	_setup_map_filter()
	_setup_clock(int(settings["speed"]))
	_compute_transform()
	_center_galaxy()
	_populate_sector_picker()
	_spawn_cards()
	if not _sectors.is_empty():
		select_sector(_sectors[0]["id"])
	_refresh_resource_labels()


func _setup_manufacturing_tabs() -> void:
	var landing_icon := ALLIANCE_EMBLEM if _side == GameData.ALLIANCE_SIDE else EMPIRE_EMBLEM
	var icons := [
		_compact_tab_icon(landing_icon),
		_compact_tab_icon(FACTORY_ICON),
		_compact_tab_icon(FLEET_ICON),
		_compact_tab_icon(GROUND_BASE_ICON),
	]
	var tooltips := ["Landing: production assignments", "Construction yards", "Shipyards", "Troop training"]
	for index in range(icons.size()):
		_manufacturing_tabs.set_tab_title(index, "")
		_manufacturing_tabs.set_tab_icon(index, icons[index])
		_manufacturing_tabs.set_tab_tooltip(index, tooltips[index])


func _compact_tab_icon(source: Texture2D) -> Texture2D:
	var image := source.get_image()
	image.resize(16, 16, Image.INTERPOLATE_LANCZOS)
	return ImageTexture.create_from_image(image)


func _theme_manufacturing_overlay() -> void:
	var accent := _faction_accent()
	var bright := accent.lerp(Color.WHITE, 0.3)
	var overlay := _top_bar_style(Color(0.025, 0.045, 0.09, 0.98), accent, 8)
	overlay.shadow_color = Color(0, 0, 0, 0.65)
	overlay.shadow_size = 12
	overlay.shadow_offset = Vector2(0, 4)
	_manufacturing_card.add_theme_stylebox_override("panel", overlay)
	_manufacturing_tabs.add_theme_stylebox_override("tab_selected", _top_bar_style(accent.darkened(0.58), bright, 4))
	_manufacturing_tabs.add_theme_stylebox_override("tab_unselected", _top_bar_style(Color(0.04, 0.075, 0.12, 0.95), accent.darkened(0.4), 4))
	_manufacturing_tabs.add_theme_stylebox_override("tab_hovered", _top_bar_style(accent.darkened(0.72), bright, 4))
	for box in [_fleet_box, _troop_box, _construction_box]:
		var order_style := _top_bar_style(Color(0.02, 0.035, 0.065, 0.98), accent.darkened(0.42), 5)
		order_style.content_margin_left = 6.0
		order_style.content_margin_top = 6.0
		order_style.content_margin_right = 6.0
		order_style.content_margin_bottom = 4.0
		box.add_theme_stylebox_override("panel", order_style)
	for progress in [_fleet_progress, _troop_progress, _construction_progress]:
		var track := _top_bar_style(Color(0.08, 0.11, 0.16, 1.0), Color(0.12, 0.18, 0.25, 1.0), 3)
		var fill := _top_bar_style(accent.darkened(0.12), bright, 3)
		progress.add_theme_stylebox_override("background", track)
		progress.add_theme_stylebox_override("fill", fill)
	for label in [_assignment_status, _fleet_available, _troop_available, _construction_available]:
		label.add_theme_color_override("font_color", bright)
	

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


func _faction_accent() -> Color:
	return _theme.get("alliance", Color.RED) if _side == 0 else _theme.get("empire", Color.GREEN)


func _top_bar_style(background: Color, border: Color, radius := 4) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = background
	style.border_width_left = 1
	style.border_width_top = 1
	style.border_width_right = 1
	style.border_width_bottom = 1
	style.border_color = border
	style.corner_radius_top_left = radius
	style.corner_radius_top_right = radius
	style.corner_radius_bottom_right = radius
	style.corner_radius_bottom_left = radius
	style.content_margin_left = 10.0
	style.content_margin_right = 10.0
	return style


func _apply_faction_top_bar_theme() -> void:
	var accent := _faction_accent()
	var bright := accent.lerp(Color.WHITE, 0.25)
	var dark_accent := accent.darkened(0.65)
	var content := _top_bar.get_node("Content") as HBoxContainer
	var menu := content.get_node("MenuButton") as Button
	var filter := content.get_node("MapFilterButton") as OptionButton
	var speed := content.get_node("SpeedButton") as OptionButton
	var panel := _top_bar_style(Color(0.025, 0.055, 0.11, 0.96), accent, 6)
	panel.shadow_color = Color(0, 0, 0, 0.5)
	panel.shadow_size = 5
	panel.shadow_offset = Vector2(0, 2)
	_top_bar.add_theme_stylebox_override("panel", panel)
	var normal := _top_bar_style(Color(0.04, 0.08, 0.13, 0.95), dark_accent)
	var hover := _top_bar_style(accent.darkened(0.55), bright)
	var pressed := _top_bar_style(accent.darkened(0.4), Color.WHITE)
	for control in [menu, filter, speed]:
		control.add_theme_stylebox_override("normal", normal)
		control.add_theme_stylebox_override("hover", hover)
		control.add_theme_stylebox_override("pressed", pressed)
		control.add_theme_color_override("font_color", bright)
		control.add_theme_color_override("font_hover_color", Color.WHITE)
		control.add_theme_color_override("font_pressed_color", Color.WHITE)
	for label in [_day_label, _raw_label, _refined_label, _maintenance_label]:
		label.add_theme_color_override("font_color", Color.WHITE)


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
		card.manufacturing_requested.connect(_show_manufacturing_card)
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


func _show_manufacturing_card(system_id: int) -> void:
	var system := _system_by_id(system_id)
	if system.is_empty():
		return
	var buildings: Array = system.get("buildings", [])
	_manufacturing_title.text = "%s Manufacturing" % str(system.get("tag", "System"))
	var construction_count := _building_count(GameData.CONSTRUCTION_YARD_ID, buildings)
	var shipyard_count := _building_count(GameData.SHIPYARD_ID, buildings)
	var training_count := _building_count(GameData.BASIC_TRAINING_ID, buildings)
	_assignment_status.text = "Select a production tab to assign construction, ship, or troop training orders."
	_update_order_row(_fleet_available, _fleet_preview, _fleet_progress, shipyard_count, FLEET_ICON)
	_update_order_row(_troop_available, _troop_preview, _troop_progress, training_count, GROUND_BASE_ICON)
	_update_order_row(_construction_available, _construction_preview, _construction_progress, construction_count, FACTORY_ICON)
	_set_facility_icons(_construction_existing, construction_count, FACTORY_ICON)
	_construction_building.text = "Being built: %s" % _queue_status(system, "construction")
	_construction_transit.text = "In transit: %s" % _queue_status(system, "construction_transit")
	_set_facility_icons(_shipyard_existing, shipyard_count, FLEET_ICON)
	_shipyard_building.text = "Being built: %s" % _queue_status(system, "ship")
	_shipyard_transit.text = "In transit: %s" % _queue_status(system, "ship_transit")
	_set_facility_icons(_training_existing, training_count, GROUND_BASE_ICON)
	_training_building.text = "Being built: %s" % _queue_status(system, "training")
	_training_transit.text = "In transit: %s" % _queue_status(system, "training_transit")
	_manufacturing_tabs.current_tab = 0
	_manufacturing_card.size = Vector2(360, 260)
	_manufacturing_card.visible = true


func _set_facility_icons(container: HBoxContainer, count: int, icon: Texture2D) -> void:
	for child in container.get_children():
		child.queue_free()
	for index in range(count):
		var icon_node := TextureRect.new()
		icon_node.custom_minimum_size = Vector2(28, 28)
		icon_node.texture = icon
		icon_node.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon_node.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon_node.tooltip_text = "Available facility %d" % (index + 1)
		container.add_child(icon_node)


func _update_order_row(
	count_label: Label,
	preview: TextureRect,
	progress: ProgressBar,
	available: int,
	item_icon: Texture2D
) -> void:
	count_label.text = str(available)
	preview.texture = item_icon
	progress.value = 0.0


func _building_count(building_id: int, buildings: Array) -> int:
	var count := 0
	for value in buildings:
		if int(value) == building_id:
			count += 1
	return count


func _queue_status(system: Dictionary, key: String) -> String:
	var value: Variant = system.get(key, [])
	if value is Array and not (value as Array).is_empty():
		return str(value)
	if value is String and not str(value).is_empty():
		return str(value)
	return "None"


func _system_by_id(system_id: int) -> Dictionary:
	for system in _systems:
		if int(system.get("id", -1)) == system_id:
			return system
	return {}


func _on_manufacturing_close_pressed() -> void:
	_manufacturing_card.visible = false


func _input(event: InputEvent) -> void:
	if not _manufacturing_card.visible:
		return
	if event is InputEventMouseButton:
		var mouse_button := event as InputEventMouseButton
		if mouse_button.button_index != MOUSE_BUTTON_LEFT:
			return
		if mouse_button.pressed:
			if _manufacturing_close.get_global_rect().has_point(mouse_button.position):
				return
			if _manufacturing_header.get_global_rect().has_point(mouse_button.position):
				_overlay_dragging = true
				_overlay_drag_offset = mouse_button.position - _manufacturing_card.global_position
				get_viewport().set_input_as_handled()
		elif _overlay_dragging:
			_overlay_dragging = false
			get_viewport().set_input_as_handled()
	elif event is InputEventMouseMotion and _overlay_dragging:
		var motion := event as InputEventMouseMotion
		_manufacturing_card.global_position = motion.position - _overlay_drag_offset
		get_viewport().set_input_as_handled()


func _systems_in_sector(sector_id: int) -> Array:
	var out: Array = []
	for sys in _systems:
		if int(sys["sector"]) == sector_id:
			out.append(sys)
	out.sort_custom(func(a: Dictionary, b: Dictionary) -> bool: return str(a["tag"]) < str(b["tag"]))
	return out


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

func _setup_map_filter() -> void:
	_filter_button.clear()
	_filter_button.add_item("Ownership")
	_filter_button.add_item("Popular Support")
	_filter_button.select(_map_filter)


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
		if whole > 0:
			_process_day()

func _process_day() -> void:
	if _game_data != null:
		_game_data.process_day()
		_refresh_resource_labels()
	_process_units()
	_process_fleets()
	_process_logistics()

func _refresh_resource_labels() -> void:
	if _game_data == null:
		return
	var factions: Array = _game_data.getData('faction_data')
	if _side >= 0 and _side < factions.size():
		_raw_label.text = "Raw %d" % int(factions[_side].get('raw', 0))
		_refined_label.text = "Refined %d" % int(factions[_side].get('refined', 0))
		_maintenance_label.text = "Maintenance %d" % int(factions[_side].get('maintenance', 0))

func _on_map_filter_selected(index: int) -> void:
	_map_filter = clampi(index, 0, 1)
	queue_redraw()

func _popular_support_color(system: Dictionary) -> Color:
	var share := float(system.get("economy", {}).get("political_share", 0.5))
	var player: Color = _theme.get("alliance", Color.RED) if _side == 0 else _theme.get("empire", Color.GREEN)
	var rival: Color = _theme.get("empire", Color.GREEN) if _side == 0 else _theme.get("alliance", Color.RED)
	var neutral := Color(0.62, 0.66, 0.72)
	if share < 0.5:
		return rival.lerp(neutral, share * 2.0)
	return neutral.lerp(player, (share - 0.5) * 2.0)

func _ownership_color(system: Dictionary) -> Color:
	if not bool(system.get("explored", false)):
		return _theme.get("unexplored", Color.GRAY)
	var owner := int(system.get("owner", -1))
	if owner == 0:
		return _theme.get("alliance", Color.RED)
	if owner == 1:
		return _theme.get("empire", Color.GREEN)
	return _theme.get("explored", Color.BLUE)


#stub to handle unit processing
func _process_units() -> void:
	return
	
func _process_fleets() -> void:
	return
	
func _process_logistics() -> void:
	return


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
		var color: Color
		if _map_filter == 1 and sys["explored"]:
			color = _popular_support_color(sys)
		else:
			color = _ownership_color(sys)
		var radius := _dot_e if sys["explored"] else _dot_u
		_draw_star(p, radius * _zoom, color, not bool(sys["explored"]))
		if _open_systems.has(int(sys["id"])):
			draw_arc(p, (radius + 6.0) * _zoom, 0.0, TAU, 32, _theme.get("open", Color.ORANGE), 2.0)
		_draw_headquarters_marker(sys, p, radius)
	var font := ThemeDB.fallback_font
	if font != null:
		for s in _sectors:
			draw_string(font, map_pos(s["pos"]) + Vector2(10, -10), s["tag"],
				HORIZONTAL_ALIGNMENT_LEFT, -1.0, int(GalaxyData.fonts()["sector_tag"]), _theme.get("tag", Color.WHITE))

func _draw_star(position: Vector2, radius: float, color: Color, uncharted: bool) -> void:
	if uncharted:
		var arm := maxf(1.0, radius * 1.4)
		var width := maxf(0.8, radius * 0.45)
		draw_line(position + Vector2(-arm, -arm), position + Vector2(arm, arm), color, width, true)
		draw_line(position + Vector2(-arm, arm), position + Vector2(arm, -arm), color, width, true)
		return
	var glow := Color(color, 0.22)
	var spike := Color(color, 0.7)
	var length := radius * 2.8
	var width := maxf(0.7, radius * 0.35)
	draw_line(position - Vector2(length, 0), position + Vector2(length, 0), spike, width, true)
	draw_line(position - Vector2(0, length), position + Vector2(0, length), spike, width, true)
	draw_circle(position, maxf(1.0, radius * 0.65), color)

func _draw_headquarters_marker(system: Dictionary, position: Vector2, radius: float) -> void:
	if _game_data == null:
		return
	var known_headquarters := _game_data.headquarters_known_to(_side)
	for faction_id in known_headquarters:
		if int(known_headquarters[faction_id]) != int(system.get("id", -1)):
			continue
		var accent: Color = _theme.get("alliance", Color.RED) if int(faction_id) == 0 else _theme.get("empire", Color.GREEN)
		var r := (radius + 9.0) * _zoom
		var points := PackedVector2Array([
			position + Vector2(0, -r),
			position + Vector2(r, 0),
			position + Vector2(0, r),
			position + Vector2(-r, 0),
		])
		draw_polyline(points, accent, maxf(2.0, 2.0 * _zoom), true)
		draw_string(ThemeDB.fallback_font, position + Vector2(r + 4.0, 4.0),
			"HQ", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 11, accent)
