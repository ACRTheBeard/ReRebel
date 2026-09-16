class_name GameData

const BUILDING_CATALOG_PATH := "res://theme/building_catalog.json"
const MINE_ID := 1
const REFINERY_ID := 2

var game_data := {}
var _difficulty := 1
var _building_catalog: Dictionary = {}

func setData(property, value):
	game_data[property] = value
	
func getData(property):
	return game_data[property]

func _init(side,faction_data,system_data, difficulty := 1) -> void:
	_difficulty = clampi(int(difficulty), 0, 2)
	_building_catalog = _load_building_catalog()
	setData('side',side)
	setData('faction_data',faction_data)
	setData('system_data', system_data)
	_initSlots()
	_initEconomy()
	return
	
func _slot_count(system_id: int, minimum: int, maximum: int) -> int:
	var span := maxi(1, maximum - minimum + 1)
	return minimum + (system_id % span)

func _slot_dict(system: Dictionary, kind: String) -> Dictionary:
	var system_id := int(system.get('id', 0))
	var minimum := 3 if kind == 'energy' else 2
	var maximum := 15
	var total := _slot_count(system_id, minimum, maximum)
	return {"total": total, "used": 0}

func _initSlots():
	for system in getData('system_data'):
		system['energy_slots'] = _slot_dict(system, 'energy')
		system['resource_slots'] = _slot_dict(system, 'resource')

func _economy_value(system_id: int, channel: int, minimum: int, maximum: int) -> int:
	var span := maxi(1, maximum - minimum + 1)
	return minimum + ((system_id * 37 + channel * 101) % span)

func _initEconomy():
	for system in getData('system_data'):
		var system_id := int(system.get('id', 0))
		var buildings := _seed_buildings(system)
		var mine_count := _count_buildings(buildings, MINE_ID)
		var refinery_count := _count_buildings(buildings, REFINERY_ID)
		system['economy'] = {
			'raw': mine_count,
			'refined': mini(mine_count, refinery_count),
			'construction': _economy_value(system_id, 2, 0, 6),
			'maintenance': _economy_value(system_id, 3, 0, 4),
			'political_share': 0.2 + 0.6 * float((system_id * 37 + 2 * 101) % 100) / 100.0,
		}

func _load_building_catalog() -> Dictionary:
	if not FileAccess.file_exists(BUILDING_CATALOG_PATH):
		push_error("Missing building catalog: %s" % BUILDING_CATALOG_PATH)
		return {}
	var parsed: Variant = JSON.parse_string(FileAccess.get_file_as_string(BUILDING_CATALOG_PATH))
	if parsed == null or not (parsed is Dictionary):
		push_error("Bad building catalog: %s" % BUILDING_CATALOG_PATH)
		return {}
	return parsed

func _catalog_entry(building_id: int) -> Dictionary:
	var entry: Variant = _building_catalog.get(str(building_id), {})
	return entry if entry is Dictionary else {}

func _count_buildings(buildings: Array, building_id: int) -> int:
	var count := 0
	for value in buildings:
		if int(value) == building_id:
			count += 1
	return count

func _seed_buildings(system: Dictionary) -> Array:
	var system_id := int(system.get('id', 0))
	var config := GalaxyData.economy(_difficulty)
	var rng := RandomNumberGenerator.new()
	rng.seed = abs(system_id * 1009 + _difficulty * 7919)
	var mine_target := 0
	var refinery_target := 0
	if bool(system.get('explored', false)):
		mine_target = rng.randi_range(int(config['major_min_mines']), int(config['major_max_mines']))
		refinery_target = rng.randi_range(int(config['major_min_refineries']), int(config['major_max_refineries']))
	elif rng.randf() <= float(config['uncharted_seed_chance']):
		mine_target = rng.randi_range(0, int(config['uncharted_max_mines']))
		refinery_target = rng.randi_range(0, int(config['uncharted_max_refineries']))

	var energy_slots: Dictionary = system['energy_slots']
	var resource_slots: Dictionary = system['resource_slots']
	var buildings: Array = []
	for i in range(mini(mine_target, int(resource_slots['total']))):
		buildings.append(MINE_ID)
	for i in range(mini(refinery_target, int(energy_slots['total']))):
		buildings.append(REFINERY_ID)
	resource_slots['used'] = _count_buildings(buildings, MINE_ID)
	energy_slots['used'] = _count_buildings(buildings, REFINERY_ID)
	system['buildings'] = buildings
	return buildings

func _initUnits():
	# add units to each faction based on the faction config.
	pass
