class_name GalaxyData
extends RefCounted
## Canonical galaxy dataset + settings IO shared by menu-adjacent scenes.
## Gameplay data only: placeholder tags, no original names or prose.

const GALAXY_PATH := "res://theme/galaxy.json"
const THEME_PATH := "res://theme/theme.cfg"
const SETTINGS_PATH := "user://rerebel_settings.cfg"

const DEFAULT_COLORS := {
	"explored": Color(0.45, 0.65, 1.0),
	"unexplored": Color(0.28, 0.30, 0.38),
	"alliance": Color(1.0, 0.25, 0.2),
	"empire": Color(0.25, 0.95, 0.35),
	"open": Color(1.0, 0.62, 0.15),
	"tag": Color(0.75, 0.80, 0.90),
	"flash": Color(1.22, 1.22, 1.28),
}

static var _colors := {}

const SIDES: PackedStringArray = ["Alliance", "Empire"]
const SIZES: PackedStringArray = ["Standard", "Large", "Huge"]
const DIFFICULTIES: PackedStringArray = ["Novice", "Intermediate", "Expert"]


static func load_sectors() -> Array:
	var out: Array = []
	for row: Dictionary in _read_galaxy().get("sectors", []):
		out.append({
			"id": int(row["id"]),
			"group": str(row["group"]),
			"size": str(row["size"]),
			"pos": Vector2i(int(row["x"]), int(row["y"])),
			"tag": str(row["tag"]),
		})
	return out


static func load_systems() -> Array:
	var out: Array = []
	for row: Dictionary in _read_galaxy().get("systems", []):
		out.append({
			"id": int(row["id"]),
			"sector": int(row["sector"]),
			"pos": Vector2i(int(row["x"]), int(row["y"])),
			"explored": bool(row["explored"]),
			"tag": str(row["tag"]),
		})
	return out


## Map sizes are cumulative: Standard adds nothing, Large adds Large
## sectors, Huge adds Huge sectors on top.
static func sectors_for_size(sectors: Array, size: int) -> Array:
	var allowed: PackedStringArray = SIZES.slice(0, clampi(size, 0, 2) + 1)
	return sectors.filter(func(s: Dictionary) -> bool: return s["size"] in allowed)


static func systems_for_sectors(systems: Array, sectors: Array) -> Array:
	var ids := {}
	for s in sectors:
		ids[s["id"]] = true
	return systems.filter(func(sys: Dictionary) -> bool: return sys["sector"] in ids)


## Theme colors, loaded once from the theme folder. Missing file or
## keys fall back to built-in defaults so the game always runs.
static func colors() -> Dictionary:
	if _colors.is_empty():
		_colors = DEFAULT_COLORS.duplicate()
		var file := ConfigFile.new()
		if file.load(THEME_PATH) == OK:
			for key in DEFAULT_COLORS:
				_colors[key] = file.get_value("colors", key, DEFAULT_COLORS[key])
	return _colors


static func load_settings() -> Dictionary:
	var file := ConfigFile.new()
	file.load(SETTINGS_PATH)
	var side := clampi(int(file.get_value("side", "side", 0)), 0, SIDES.size() - 1)
	var size := clampi(int(file.get_value("galaxy", "galaxy_size", 0)), 0, SIZES.size() - 1)
	var diff := clampi(int(file.get_value("difficulty", "difficulty", 0)), 0, DIFFICULTIES.size() - 1)
	return {
		"side": side, "size": size, "difficulty": diff,
		"side_name": SIDES[side], "size_name": SIZES[size], "difficulty_name": DIFFICULTIES[diff],
	}


static func _read_galaxy() -> Dictionary:
	if not FileAccess.file_exists(GALAXY_PATH):
		push_error("Missing data file: %s" % GALAXY_PATH)
		return {}
	var text := FileAccess.get_file_as_string(GALAXY_PATH)
	var parsed: Variant = JSON.parse_string(text)
	if parsed == null or not (parsed is Dictionary):
		push_error("Bad galaxy data: %s" % GALAXY_PATH)
		return {}
	return parsed
