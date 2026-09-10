extends Control
## Mini sector map: every system of the sector as a dot, click one to
## focus it. Drawn from data, so zoom/pan independent.

signal system_picked(system_id: int)

const PAD := 18.0
const DOT_RADIUS := 7.0
const PICK_RADIUS := 16.0

var _systems: Array = []
var _focused := -1


func show_sector(systems: Array, focused_id: int) -> void:
	_systems = systems
	_focused = focused_id
	queue_redraw()


func set_focused(system_id: int) -> void:
	_focused = system_id
	queue_redraw()


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
	var span := (max_p - min_p) + Vector2(40, 40)
	var sc := minf((size.x - PAD * 2.0) / span.x, (size.y - PAD * 2.0) / span.y)
	var used := span * sc
	var off := (size - used) * 0.5 - (min_p - Vector2(20, 20)) * sc
	for s in _systems:
		out[int(s["id"])] = Vector2(s["pos"]) * sc + off
	return out


func system_at(point: Vector2) -> int:
	var dots := layout()
	var best := -1
	var best_dist := PICK_RADIUS
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
	for id in dots:
		var sys := _system_for(id)
		var theme := GalaxyData.colors()
		var color: Color = theme.get("explored", Color.BLUE) if sys.get("explored", false) else theme.get("unexplored", Color.GRAY)
		draw_circle(dots[id], DOT_RADIUS, color)
		if int(id) == _focused:
			draw_arc(dots[id], DOT_RADIUS + 4.0, 0.0, TAU, 32, Color.WHITE, 2.0)
			if font != null:
				draw_string(font, (dots[id] as Vector2) + Vector2(12, -8), str(sys.get("tag", "")),
					HORIZONTAL_ALIGNMENT_LEFT, -1.0, 16, Color.WHITE)


func _system_for(system_id: int) -> Dictionary:
	for s in _systems:
		if int(s["id"]) == system_id:
			return s
	return {}
