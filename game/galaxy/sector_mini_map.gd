extends Control
## Mini sector map: every system of the sector as a dot, click one to
## focus it. Drawn from data, so zoom/pan independent.
##
## Each system reserves room around and below itself: three placeholder
## icons (fleet triangle, manufacturing square, unit diamond) arc over the
## dot, and three placeholder bars (energy, resource, political) sit below
## it. All sizes come from the theme; fills are fixed placeholders until
## the simulation drives them.

signal system_picked(system_id: int)

## Breathing room kept between neighboring systems for icons and bars.
const ICON_ROOM := 12.0
var _systems: Array = []
var _focused := -1
var _dot := 7.0
var _dot_min := 7.0
var _dot_max := 10.0
var _pick := 16.0
var _pick_min := 16.0
var _pad := 28.0
var _tag_size := 16
var _icon_dist := 20.0
var _icon_size := 7.0
var _bar_w := 44.0
var _bar_h := 5.0
var _bar_gap := 3.0
var _side := 0
var _theme: Dictionary = {}


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
	_tag_size = int(GalaxyData.fonts()["mini_tag"])
	_theme = GalaxyData.colors()
	_side = int(GalaxyData.load_settings()["side"])
	queue_redraw()


## Player faction color on the left, rival on the right.
func _faction_pair() -> Array:
	var alliance: Color = _theme.get("alliance", Color.RED)
	var empire: Color = _theme.get("empire", Color.GREEN)
	if _side == 0:
		return [alliance, empire]
	return [empire, alliance]


func set_focused(system_id: int) -> void:
	_focused = system_id
	queue_redraw()


## Clearance the decorations need: icons on the sides and top, dot plus
## stacked bars below. Uses the max dot so layout never clips.
func _clearance() -> Dictionary:
	var side := maxf(_pad, _icon_dist + _icon_size)
	var bottom := maxf(_pad, _dot_max + 6.0 + 3.0 * _bar_h + 2.0 * _bar_gap + 4.0)
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
	return 0.2 + 0.6 * float((system_id * 37 + bar * 101) % 100) / 100.0


## Deterministic placeholder energy slots until the simulation drives
## them: 3-5 total, some used. Pure function so tests can pin it.
func energy_slots(system_id: int) -> Dictionary:
	var total := 3 + system_id % 3
	return {"total": total, "used": 1 + (system_id * 7) % total}


## Largest dots that still fit: half the closest pair gap, minus room for
## the icon ring, clamped to the themed min/max. Pick radius always clears
## the dot and its icons.
func _fit_dots(points: Array) -> void:
	var gap := INF
	for i in range(points.size()):
		for j in range(i + 1, points.size()):
			gap = minf(gap, (points[i] as Vector2).distance_to(points[j]))
	_dot = clampf(gap * 0.5 - ICON_ROOM, _dot_min, _dot_max)
	_pick = maxf(_pick_min, _dot + _icon_dist)


## Icon slots and bar rects for a system. Pure layout math so tests can
## verify it without a renderer. The political bar splits: player faction
## on the left, rival on the right.
func decor(center: Vector2, system_id: int) -> Dictionary:
	var icons: Array = []
	var angles := [-90.0, -30.0, -150.0]
	for k in range(angles.size()):
		var a := deg_to_rad(angles[k])
		icons.append({"pos": center + Vector2(cos(a), sin(a)) * _icon_dist, "kind": k})
	var pair := _faction_pair()
	var bars: Array = []
	var fills := ["bar_energy", "bar_resource", "bar_political"]
	var y := center.y + _dot + 6.0
	for b in range(fills.size()):
		var political := b == 2
		bars.append({
			"rect": Rect2(center.x - _bar_w * 0.5, y + float(b) * (_bar_h + _bar_gap), _bar_w, _bar_h),
			"fill": fills[b],
			"frac": bar_frac(system_id, b),
			"split": political,
			"left": pair[0] if political else _theme.get(fills[b], Color.WHITE),
			"right": pair[1] if political else Color(0, 0, 0, 0),
			"slots": energy_slots(system_id) if b == 0 else {},
		})
	return {"icons": icons, "bars": bars}


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


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mb := event as InputEventMouseButton
		if mb.button_index == MOUSE_BUTTON_LEFT and not mb.pressed:
			var id := system_at(mb.position)
			if id >= 0:
				system_picked.emit(id)


func _draw() -> void:
	var dots := layout()
	var font := ThemeDB.fallback_font
	var icon_cols: Array = [
		_theme.get("icon_fleet", Color.RED),
		_theme.get("icon_mfg", Color.YELLOW),
		_theme.get("icon_unit", Color.CYAN),
	]
	for id in dots:
		var center: Vector2 = dots[id]
		var sys := _system_for(id)
		var color: Color = _theme.get("explored", Color.BLUE) if sys.get("explored", false) else _theme.get("unexplored", Color.GRAY)
		draw_circle(center, _dot, color)
		var deco := decor(center, int(id))
		for icon in deco["icons"]:
			_draw_icon(icon["pos"], int(icon["kind"]), icon_cols[int(icon["kind"])])
		for bar in deco["bars"]:
			_draw_bar(bar)
		if int(id) == _focused:
			draw_arc(center, _dot + 4.0, 0.0, TAU, 32, Color.WHITE, 2.0)
			if font != null:
				draw_string(font, center + Vector2(12, -8), str(sys.get("tag", "")),
					HORIZONTAL_ALIGNMENT_LEFT, -1.0, _tag_size, Color.WHITE)


## kind 0 fleet triangle, 1 manufacturing square, 2 unit diamond.
func _draw_icon(pos: Vector2, kind: int, color: Color) -> void:
	var s := _icon_size
	match kind:
		0:
			draw_colored_polygon([pos + Vector2(0, -s), pos + Vector2(s * 0.9, s * 0.7), pos + Vector2(-s * 0.9, s * 0.7)], color)
		1:
			draw_rect(Rect2(pos - Vector2(s, s) * 0.8, Vector2(s, s) * 1.6), color)
		_:
			draw_colored_polygon([pos + Vector2(0, -s), pos + Vector2(s * 0.7, 0), pos + Vector2(0, s), pos + Vector2(-s * 0.7, 0)], color)


func _draw_bar(bar: Dictionary) -> void:
	var rect: Rect2 = bar["rect"]
	draw_rect(rect, _theme.get("bar_track", Color.DARK_GRAY))
	if not (bar["slots"] as Dictionary).is_empty():
		_draw_slots(rect, bar["slots"], bar["left"])
		return
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


## Segmented slots: used segments solid, available ones left as track with
## divider gaps so the slot count reads.
func _draw_slots(rect: Rect2, slots: Dictionary, color: Color) -> void:
	var total := maxi(1, int(slots["total"]))
	var used := clampi(int(slots["used"]), 0, total)
	var seg := rect.size.x / float(total)
	for i in range(total):
		if i >= used:
			break
		var cell := Rect2(rect.position + Vector2(seg * float(i) + 1.0, 0), Vector2(seg - 2.0, rect.size.y))
		draw_rect(cell, color)


func _system_for(system_id: int) -> Dictionary:
	for s in _systems:
		if int(s["id"]) == system_id:
			return s
	return {}
