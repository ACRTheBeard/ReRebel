extends Control
## Mini sector map: every system of the sector as a dot, click one to
## focus it. Drawn from data, so zoom/pan independent.
##
## Each system reserves room around and below itself: four placeholder
## icons (manufacturing, fleet, ground base, mission) sit at the corners
## of an invisible square around the dot, and three placeholder bars
## (energy, resource, political) sit below it. All sizes come from the theme; fills are fixed placeholders until
## the simulation drives them. A system whose political share reaches the
## themed ownership threshold is owned: its dot takes the owner's faction
## color, otherwise it stays explored/unexplored. Icons and bars stay
## hidden until a system is charted, and uncharted systems sit at the
## themed neutral share so neither side gains them by luck.

signal system_picked(system_id: int)
signal manufacturing_requested(system_id: int)
signal construction_target_selected(system_id: int)

## Breathing room kept between neighboring systems for icons and bars.
const ICON_ROOM := 12.0
const ALLIANCE_EMBLEM := preload("res://art/alliance_emblem.png")
const EMPIRE_EMBLEM := preload("res://art/empire_emblem.png")
const DART_FLIGHT := preload("res://art/dart_flight.png")
const FACTORY_ICON := preload("res://art/factory.png")
const GROUND_BASE_ICON := preload("res://art/ground_base.svg")
var _systems: Array = []
var _focused := -1
var _dot := 7.0
var _dot_min := 7.0
var _dot_max := 10.0
var _pick := 16.0
var _pick_min := 16.0
var _pad := 28.0
var _icon_dist := 20.0
var _icon_size := 7.0
var _bar_w := 44.0
var _bar_h := 5.0
var _bar_gap := 3.0
var _slot_w := 10.0
var _slot_sep := 5.0
var _tag_size := 10
var _energy_min := 3.0
var _energy_max := 6.0
var _resource_min := 2.0
var _resource_max := 6.0
var _side := 0
var _ownership_threshold := 0.65
var _neutral_share := 0.5
var _theme: Dictionary = {}
var _target_selection_active := false


func show_sector(systems: Array, focused_id: int) -> void:
	_systems = systems
	_focused = focused_id
	var layout := GalaxyData.layout()
	_dot_min = float(layout["dot_mini"])
	_dot_max = float(layout["dot_max"])
	_pick_min = float(layout["pick_radius"])
	_pad = float(layout["mini_pad"])
	_icon_dist = float(layout["icon_dist"])
	_icon_size = float(layout["icon_size"])
	_bar_w = float(layout["bar_width"])
	_bar_h = float(layout["bar_height"])
	_bar_gap = float(layout["bar_gap"])
	_slot_w = maxf(1.0, float(layout["slot_width"]))
	_slot_sep = maxf(0.0, float(layout["slot_separator"]))
	_energy_max = maxf(1.0, float(layout["energy_max_slots"]))
	_resource_max = maxf(1.0, float(layout["resource_max_slots"]))
	_energy_min = clampf(float(layout["energy_min_available"]), 1.0, _energy_max)
	_resource_min = clampf(float(layout["resource_min_available"]), 1.0, _resource_max)
	_theme = GalaxyData.colors()
	_tag_size = int(GalaxyData.fonts()["mini_tag"])
	_side = int(GalaxyData.load_settings()["side"])
	_ownership_threshold = clampf(float(GalaxyData.politics()["ownership_threshold"]), 0.5, 1.0)
	_neutral_share = clampf(float(GalaxyData.politics()["neutral_share"]), 0.0, 1.0)
	queue_redraw()


## Per-bar slot configuration: placeholder counts, max for standard slot
## size, and the used/open colors. Energy is white on blue, resource is
## yellow on red.
func _slot_config(bar: int, system_id: int) -> Dictionary:
	if bar == 1:
		return {
			"slots": resource_slots(system_id),
			"max": _resource_max,
			"open": _theme.get("bar_resource", Color.RED),
			"used": _theme.get("resource_used", Color.YELLOW),
		}
	return {
		"slots": energy_slots(system_id),
		"max": _energy_max,
		"open": _theme.get("bar_energy", Color.BLUE),
		"used": _theme.get("slot_used", Color.WHITE),
	}


## Player faction color on the left, rival on the right.
func _faction_pair() -> Array:
	var alliance: Color = _theme.get("alliance", Color.RED)
	var empire: Color = _theme.get("empire", Color.GREEN)
	if _side == 0:
		return [alliance, empire]
	return [empire, alliance]


## Ownership from a political share: at/above threshold the system is
## owned by the given side, at/below (1 - threshold) by its rival,
## otherwise neutral (-1). Static in share so the rule holds for any
## threshold without a live map.
static func owner_for(frac: float, threshold: float, side: int) -> int:
	if frac >= threshold:
		return side
	if frac <= 1.0 - threshold:
		return 1 - side
	return -1


## Political share for a system: charted systems use their deterministic
## placeholder fill, uncharted ones sit at the themed neutral share.
func political_frac(system_id: int) -> float:
	if not _system_for(system_id).get("explored", false):
		return _neutral_share
	return bar_frac(system_id, 2)


## Icons and bars stay hidden until a system is charted (explored).
func decorations_shown(system_id: int) -> bool:
	return bool(_system_for(system_id).get("explored", false))


## Owning faction index into faction names, or -1 while neutral.
func owner_of(system_id: int) -> int:
	return owner_for(political_frac(system_id), _ownership_threshold, _side)


## Theme color for a faction index; white when a renamed faction has no
## matching color key.
func _faction_color(idx: int) -> Color:
	var names := GalaxyData.factions()
	if idx < 0 or idx >= names.size():
		return Color.WHITE
	return _theme.get(str(names[idx]).to_lower(), Color.WHITE)


## Dot color: owner's faction color once owned, else explored/unexplored.
## Pure given map state so headless checks can pin it without a renderer.
func dot_color(system_id: int, explored: bool) -> Color:
	var owner := owner_of(system_id)
	if owner >= 0:
		return _faction_color(owner)
	return _theme.get("explored", Color.BLUE) if explored else _theme.get("unexplored", Color.GRAY)


func set_focused(system_id: int) -> void:
	_focused = system_id
	queue_redraw()


func begin_target_selection() -> void:
	_target_selection_active = true


func end_target_selection() -> void:
	_target_selection_active = false


func target_system_at(point: Vector2) -> int:
	return system_at(point)


## Clearance the decorations need: icons on the sides and top, dot plus
## stacked bars below. Uses the max dot so layout never clips.
func _clearance() -> Dictionary:
	var side := maxf(_pad, _icon_dist + _icon_size)
	var bottom := maxf(_pad, _dot_max + 15.0 + 3.0 * _bar_h + 2.0 * _bar_gap + 17.0)
	return {"side": side, "top": side, "bottom": bottom}


func layout() -> Dictionary:
	var out := {}
	if _systems.is_empty() or size.x <= 0.0 or size.y <= 0.0:
		return out
	var min_p := Vector2(INF, INF)
	var max_p := Vector2(-INF, -INF)
	for s in _systems:
		var p := Vector2(s["pos"])
		min_p = min_p.min(p)
		max_p = max_p.max(p)
	var size_range := max_p - min_p
	var mgn := Vector2(maxf(4.0, size_range.x * 0.1), maxf(4.0, size_range.y * 0.1))
	var span := size_range + mgn * 2.0
	var clear := _clearance()
	# Non-uniform fit: systems spread across the whole card in both axes
	# instead of huddling in the middle of the shorter one.
	var avail := Vector2(size.x - float(clear["side"]) * 2.0, size.y - float(clear["top"]) - float(clear["bottom"]))
	var sc := Vector2(avail.x / span.x, avail.y / span.y)
	var used := Vector2(span.x * sc.x, span.y * sc.y)
	var origin := Vector2(float(clear["side"]), float(clear["top"])) + (avail - used) * 0.5
	var base := min_p - mgn
	for s in _systems:
		out[int(s["id"])] = origin + (Vector2(s["pos"]) - base) * sc
	_fit_dots(out.values())
	return out


## Deterministic placeholder fill per system and bar until the simulation
## drives them. Pure function so tests can pin it.
func bar_frac(system_id: int, bar: int) -> float:
	var economy: Dictionary = _system_for(system_id).get("economy", {})
	if bar == 2 and economy.has("political_share"):
		return float(economy["political_share"])
	return 0.2 + 0.6 * float((system_id * 37 + bar * 101) % 100) / 100.0



## totals spread from minimum initial available to max.
func energy_slots(system_id: int) -> Dictionary:
	var system := _system_for(system_id)
	if system.has("energy_slots"):
		return system["energy_slots"]
	var span := maxi(1, int(_energy_max) - int(_energy_min) + 1)
	var total := int(_energy_min) + (system_id % span)
	return {"total": total, "used": 0}

## some used.
func resource_slots(system_id: int) -> Dictionary:
	var system := _system_for(system_id)
	if system.has("resource_slots"):
		return system["resource_slots"]
	var span := maxi(1, int(_resource_max) - int(_resource_min) + 1)
	var total := int(_resource_min) + (system_id % span)
	return {"total": total, "used": 0}


## Largest dots that still fit: half the closest pair gap, minus room for
## the icon ring, clamped to the themed min/max. Pick radius always clears
## the dot and its icons.
func _fit_dots(points: Array) -> void:
	var gap := INF
	for i in range(points.size()):
		for j in range(i + 1, points.size()):
			gap = minf(gap, (points[i] as Vector2).distance_to(points[j]))
	_dot = clampf(gap * 0.5 - ICON_ROOM, _dot_min, _dot_max)
	_pick = maxf(_pick_min, _dot + _icon_dist * sqrt(2.0))


## Icon slots and bar rects for a system. Pure layout math so tests can
## verify it without a renderer. The political bar splits: player faction
## on the left, rival on the right. The entry also carries the owning
## faction index ("owner", -1 while neutral).
func decor(center: Vector2, system_id: int) -> Dictionary:
	var icons: Array = []
	var corners := [{"offset": Vector2(-1.0, -1.0), "kind": 2}, {"offset": Vector2(1.0, -1.0), "kind": 0}, {"offset": Vector2(-1.0, 1.0), "kind": 3}, {"offset": Vector2(1.0, 1.0), "kind": 1}]
	for corner in corners:
		icons.append({"pos": center + corner["offset"] * _icon_dist, "kind": corner["kind"]})
	var pair := _faction_pair()
	var bars: Array = []
	var fills := ["bar_energy", "bar_resource", "bar_political"]
	var y := center.y + _dot + 15.0
	for b in range(fills.size()):
		var political := b == 2
		var rect := Rect2(center.x - _bar_w * 0.5, y + float(b) * (_bar_h + _bar_gap), _bar_w, _bar_h)
		var slots := {}
		var entry := {
			"rect": rect,
			"fill": fills[b],
			"frac": political_frac(system_id) if political else bar_frac(system_id, b),
			"split": political,
			"left": pair[0] if political else _theme.get(fills[b], Color.WHITE),
			"right": pair[1] if political else Color(0, 0, 0, 0),
			"slots": slots,
		}
		if b < 2:
			# Slotted bars always span the full width (max slots, same
			# length as the political bar); only `total` segments from
			# the left are visible, the rest stays transparent.
			var cfg := _slot_config(b, system_id)
			entry["slots"] = cfg["slots"]
			entry["max_slots"] = cfg["max"]
			entry["open"] = cfg["open"]
			entry["used"] = cfg["used"]
			entry["divider"] = _theme.get("bar_divider", Color.BLACK)
		bars.append(entry)
	return {"icons": icons, "bars": bars, "owner": owner_of(system_id)}


func system_at(point: Vector2) -> int:
	var dots := layout()
	var best := -1
	var best_dist := _pick
	for id in dots:
		var d: float = (dots[id] as Vector2).distance_to(point)
		if d < best_dist:
			best_dist = d
			best = int(id)
	return best


func manufacturing_at(point: Vector2) -> int:
	var dots := layout()
	for id in dots:
		var deco := decor(dots[id], int(id))
		for icon in deco["icons"]:
			if int(icon["kind"]) == 2 and (icon["pos"] as Vector2).distance_to(point) <= _icon_size * 1.8:
				return int(id)
	return -1


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mb := event as InputEventMouseButton
		if _target_selection_active and mb.button_index == MOUSE_BUTTON_LEFT and not mb.pressed:
			var target_id := system_at(mb.position)
			if target_id >= 0:
				construction_target_selected.emit(target_id)
				accept_event()
			return
		if mb.button_index == MOUSE_BUTTON_LEFT and mb.pressed and mb.double_click:
			var manufacturing_id := manufacturing_at(mb.position)
			if manufacturing_id >= 0:
				manufacturing_requested.emit(manufacturing_id)
				return
		if mb.button_index == MOUSE_BUTTON_LEFT and not mb.pressed:
			var id := system_at(mb.position)
			if id >= 0:
				system_picked.emit(id)


func _draw() -> void:
	var dots := layout()
	var icon_cols: Array = [
		_theme.get("icon_fleet", Color.RED),
		_theme.get("icon_unit", Color.CYAN),
		_theme.get("icon_mfg", Color.YELLOW),
		_theme.get("icon_ground", Color.CYAN),
	]
	for id in dots:
		var center: Vector2 = dots[id]
		var sys := _system_for(id)
		draw_circle(center, _dot, dot_color(int(id), sys.get("explored", false)))
		if decorations_shown(int(id)):
			var deco := decor(center, int(id))
			for icon in deco["icons"]:
				_draw_icon(icon["pos"], int(icon["kind"]), icon_cols[int(icon["kind"])])
			for bar in deco["bars"]:
				_draw_bar(bar)
			_draw_system_tag(deco["bars"][2]["rect"], str(sys.get("tag", "")))

## kind 0 flight of darts (fleet), 1 emblem (mission), 2 factory
## (manufacturing), 3 ground base.
func _draw_icon(pos: Vector2, kind: int, color: Color) -> void:
	var s := _icon_size * 2.4
	match kind:
		0:
			var tex := DART_FLIGHT
			var rect := Rect2(pos - Vector2(s, s) * 0.55, Vector2(s, s) * 1.1)
			draw_texture_rect(tex, rect, false, color)
		1:
			var emblem := ALLIANCE_EMBLEM if _side == 0 else EMPIRE_EMBLEM
			var rect2 := Rect2(pos - Vector2(s, s) * 0.55, Vector2(s, s) * 1.1)
			draw_texture_rect(emblem, rect2, false, color)
		2:
			var rect3 := Rect2(pos - Vector2(s, s) * 0.55, Vector2(s, s) * 1.1)
			draw_texture_rect(FACTORY_ICON, rect3, false, color)
		_:
			var rect4 := Rect2(pos - Vector2(s, s) * 0.55, Vector2(s, s) * 1.1)
			draw_texture_rect(GROUND_BASE_ICON, rect4, false, color)


## Cell and divider geometry for a slotted bar at a fixed pitch: every
## slot is exactly slot_width wide with slot_separator between visible
## segments (13 slots -> 12 dividers), so no dynamic sizing can skew the
## render. Cells are relative to the bar origin with unit height; the
## caller offsets them. Pure math so headless checks can pin it.
func slot_rects(total: int, max_slots: int) -> Dictionary:
	var n := maxi(1, max_slots)
	var vis := clampi(total, 0, n)
	var pitch := _slot_w + _slot_sep
	var cells: Array = []
	for i in range(vis):
		cells.append(Rect2(Vector2(pitch * float(i), 0.0), Vector2(_slot_w, 1.0)))
	var divs: Array = []
	for i in range(1, vis):
		divs.append(pitch * float(i) - _slot_sep)
	return {
		"seg": pitch, "slot": _slot_w, "divider": _slot_sep,
		"cells": cells, "dividers": divs, "visible": vis,
	}


func _draw_bar(bar: Dictionary) -> void:
	var rect: Rect2 = bar["rect"]
	if not (bar["slots"] as Dictionary).is_empty():
		# Slotted bars sit on a transparent full-width track: only the
		# visible slots and their dividers draw.
		_draw_slots(bar)
		return
	draw_rect(rect, _theme.get("bar_track", Color.DARK_GRAY))
	var frac := clampf(float(bar["frac"]), 0.0, 1.0)
	if bool(bar["split"]):
		var left := rect
		left.size.x *= frac
		draw_rect(left, bar["left"])
		var right := rect
		right.position.x += left.size.x
		right.size.x -= left.size.x
		draw_rect(right, bar["right"])
	else:
		var fill := rect
		fill.size.x *= frac
		draw_rect(fill, bar["left"])


func _draw_system_tag(political_rect: Rect2, tag: String) -> void:
	if tag.is_empty():
		return
	var font := ThemeDB.fallback_font
	if font == null:
		return
	draw_string(
		font,
		Vector2(political_rect.position.x, political_rect.end.y + _tag_size + 2.0),
		tag,
		HORIZONTAL_ALIGNMENT_LEFT,
		political_rect.size.x,
		_tag_size,
		_theme.get("tag", Color.WHITE),
	)


## Segmented slots at the standard full-width size: available slots in
## the themed open color, used slots in the used color, dark dividers
## only between visible segments. Simple per-cell pass, no search.
func _draw_slots(bar: Dictionary) -> void:
	var rect: Rect2 = bar["rect"]
	var slots: Dictionary = bar["slots"]
	var layout := slot_rects(int(slots["total"]), int(bar.get("max_slots", 1)))
	var used := clampi(int(slots["used"]), 0, int(layout["visible"]))
	var cells: Array = layout["cells"]
	for i in range(cells.size()):
		var cell: Rect2 = cells[i]
		cell.position += rect.position
		cell.size.y = rect.size.y
		draw_rect(cell, bar["used"] if i < used else bar["open"])
	for dx in (layout["dividers"] as Array):
		var x := rect.position.x + float(dx)
		draw_rect(Rect2(x, rect.position.y, float(layout["divider"]), rect.size.y), bar["divider"])


func _system_for(system_id: int) -> Dictionary:
	for s in _systems:
		if int(s["id"]) == system_id:
			return s
	return {}
