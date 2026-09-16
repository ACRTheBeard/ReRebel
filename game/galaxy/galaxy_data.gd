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
	"icon_fleet": Color(1.0, 0.45, 0.30),
	"icon_mfg": Color(1.0, 0.85, 0.30),
	"icon_unit": Color(0.40, 0.90, 1.0),
	"bar_energy": Color(0.30, 0.60, 1.0),
	"slot_used": Color(1.0, 1.0, 1.0),
	"bar_divider": Color(0.02, 0.02, 0.04),
	"bar_resource": Color(0.90, 0.25, 0.20),
	"resource_used": Color(1.0, 0.85, 0.20),
	"bar_political": Color(0.75, 0.50, 1.0),
	"bar_track": Color(0.16, 0.18, 0.24),
}

const DEFAULT_LAYOUT := {
	"map_width": 900.0,
	"map_height": 720.0,
	"map_margin": 40.0,
	"click_radius": 14.0,
	"sector_radius": 30.0,
	"drag_threshold": 6.0,
	"dot_explored": 5.0,
	"dot_unexplored": 4.0,
	"dot_mini": 9.0,
	"dot_max": 14.0,
	"pick_radius": 16.0,
	"mini_pad": 20.0,
	"icon_dist": 20.0,
	"icon_size": 4.0,
	"bar_width": 220.0,
	"bar_height": 5.0,
	"bar_gap": 3.0,
	"slot_width": 10.0,
	"slot_separator": 5.0,
	"energy_min_available": 3.0,
	"energy_max_slots": 15.0,
	"resource_min_available": 2.0,
	"resource_max_slots": 15.0,
	"panel_width": 364.0,
	"pip_origin": Vector2(16, 64),
	"pip_size": Vector2(442, 640),
	"pip_gap": 16.0,
	"zoom_min": 0.6,
	"zoom_max": 4.0,
	"zoom_step": 1.15,
	"flash_seconds": 1.0,
}

const DEFAULT_FONTS := {
	"menu_title": 84,
	"sector_tag": 18,
	"card_title": 20,
	"mini_tag": 16,
	"panel_header": 22,
}

const DEFAULT_TIME := {
	"speed_names": ["Very Slow", "Slow", "Normal", "Fast"],
	"day_lengths": [8.0, 4.0, 2.0, 0.5],
}

const DEFAULT_POLITICS := {
	"ownership_threshold": 0.65,
	"neutral_share": 0.5,
}

const DEFAULT_ECONOMY := [
	{
		"major_min_mines": 3, "major_max_mines": 6,
		"major_min_refineries": 2, "major_max_refineries": 4,
		"uncharted_seed_chance": 0.35,
		"uncharted_max_mines": 1, "uncharted_max_refineries": 1,
	},
	{
		"major_min_mines": 2, "major_max_mines": 5,
		"major_min_refineries": 1, "major_max_refineries": 3,
		"uncharted_seed_chance": 0.20,
		"uncharted_max_mines": 1, "uncharted_max_refineries": 1,
	},
	{
		"major_min_mines": 1, "major_max_mines": 4,
		"major_min_refineries": 1, "major_max_refineries": 2,
		"uncharted_seed_chance": 0.10,
		"uncharted_max_mines": 1, "uncharted_max_refineries": 1,
	},
]

const DEFAULT_FACTIONS: PackedStringArray = ["Alliance", "Empire"]
const SIZES: PackedStringArray = ["Standard", "Large", "Huge"]
const DIFFICULTIES: PackedStringArray = ["Novice", "Intermediate", "Expert"]

static var _factions := PackedStringArray()


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


static var _sections := {}


## Any theme section, loaded once. Missing file or keys fall back to
## built-in defaults so the game always runs.
static func _section(name: String, defaults: Dictionary) -> Dictionary:
	if not _sections.has(name):
		var out := defaults.duplicate()
		var file := ConfigFile.new()
		if file.load(THEME_PATH) == OK:
			for key in defaults:
				out[key] = file.get_value(name, key, defaults[key])
		_sections[name] = out
	return _sections[name]


static func colors() -> Dictionary:
	return _section("colors", DEFAULT_COLORS)


static func layout() -> Dictionary:
	return _section("layout", DEFAULT_LAYOUT)


static func fonts() -> Dictionary:
	return _section("fonts", DEFAULT_FONTS)


static func politics() -> Dictionary:
	return _section("politics", DEFAULT_POLITICS)

static func economy(difficulty: int) -> Dictionary:
	var index := clampi(difficulty, 0, DEFAULT_ECONOMY.size() - 1)
	var names := ["novice", "intermediate", "expert"]
	return _section("economy_%s" % names[index], DEFAULT_ECONOMY[index])


const DEFAULT_BACKDROP := {
	"star_count": 240,
	"seed": 7,
	"galaxy_image": "res://art/galaxy.png",
	"galaxy_scale": 1.35,
	"star_tint_a": Color(0.75, 0.85, 1.0),
	"star_tint_b": Color(1.0, 0.90, 0.78),
	"nebula_a": Color(0.22, 0.08, 0.38),
	"nebula_b": Color(0.04, 0.22, 0.32),
}


static func backdrop() -> Dictionary:
	return _section("backdrop", DEFAULT_BACKDROP)


static func time() -> Dictionary:
	var raw := _section("time", DEFAULT_TIME)
	return {
		"speed_names": PackedStringArray(Array(raw.get("speed_names", []))),
		"day_lengths": PackedFloat32Array(Array(raw.get("day_lengths", []))),
	}


## Theme faction names, loaded once like colors. Falls back to
## built-in defaults so the game always runs.
static func factions() -> PackedStringArray:
	if _factions.is_empty():
		_factions = DEFAULT_FACTIONS
		var file := ConfigFile.new()
		if file.load(THEME_PATH) == OK:
			var names: Variant = file.get_value("factions", "names", DEFAULT_FACTIONS)
			if names is PackedStringArray and not (names as PackedStringArray).is_empty():
				_factions = names
	return _factions


static func load_settings() -> Dictionary:
	var file := ConfigFile.new()
	file.load(SETTINGS_PATH)
	var sides := factions()
	var side := clampi(int(file.get_value("side", "side", 0)), 0, sides.size() - 1)
	var size := clampi(int(file.get_value("galaxy", "galaxy_size", 0)), 0, SIZES.size() - 1)
	var diff := clampi(int(file.get_value("difficulty", "difficulty", 0)), 0, DIFFICULTIES.size() - 1)
	var speed_count := maxi(1, int(time()["speed_names"].size()))
	var speed := clampi(int(file.get_value("time", "speed", 2)), 0, speed_count - 1)
	return {
		"side": side, "size": size, "difficulty": diff, "speed": speed,
		"side_name": sides[side], "size_name": SIZES[size], "difficulty_name": DIFFICULTIES[diff],
	}


static func save_setting(section: String, key: String, value: Variant) -> void:
	var file := ConfigFile.new()
	file.load(SETTINGS_PATH)
	file.set_value(section, key, value)
	var err := file.save(SETTINGS_PATH)
	if err != OK:
		push_warning("Could not save settings: %s" % error_string(err))


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
