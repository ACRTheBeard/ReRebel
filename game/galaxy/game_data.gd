class_name GameData

const BUILDING_CATALOG_PATH := "res://theme/building_catalog.json"
const MINE_ID := 1
const REFINERY_ID := 2
const FACTION_COUNT := 2
const ALLIANCE_SIDE := 0
const EMPIRE_SIDE := 1
const EMPIRE_HQ_SYSTEM_ID := 265
const CONSTRUCTION_YARD_ID := 3
const SHIPYARD_ID := 4
const BASIC_TRAINING_ID := 5
const INHABITED_FACILITY_CHANCE := 0.03

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
	setData('faction_data', _initialize_factions(faction_data))
	setData('system_data', system_data)
	_initSlots()
	_initEconomy()
	_initKnowledge()
	_initHeadquarters()
	return

func _initialize_factions(faction_data: Array) -> Array:
	var factions := faction_data
	while factions.size() < FACTION_COUNT:
		factions.append({'raw': 0, 'refined': 0, 'maintenance': 0})
	for faction in factions:
		if faction is Dictionary:
			faction['raw'] = int(faction.get('raw', 0))
			faction['refined'] = int(faction.get('refined', 0))
			faction['maintenance'] = int(faction.get('maintenance', 0))
	return factions
	
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
		var political_share := 0.2 + 0.6 * float((system_id * 37 + 2 * 101) % 100) / 100.0
		system['economy'] = {
			'raw': mine_count,
			'refined': mini(mine_count, refinery_count),
			'construction': _economy_value(system_id, 2, 0, 6),
			'maintenance': _economy_value(system_id, 3, 0, 4),
			'political_share': political_share,
		}
		system['owner'] = _owner_for(political_share, bool(system.get('explored', false)))
	_calculate_maintenance()

func _initKnowledge() -> void:
	for system in getData('system_data'):
		var known_to := [ALLIANCE_SIDE, EMPIRE_SIDE] if bool(system.get('explored', false)) else []
		system['knowledge'] = {
			'sector_known_to': known_to.duplicate(),
			'ownership_known_to': known_to.duplicate(),
			'buildings_known_to': known_to.duplicate(),
			'fleets_known_to': [],
			'units_known_to': [],
			'troops_known_to': [],
		}

func _initHeadquarters() -> void:
	var alliance_candidates: Array = []
	for system in getData('system_data'):
		if not bool(system.get('explored', false)) and int(system.get('id', -1)) != EMPIRE_HQ_SYSTEM_ID:
			alliance_candidates.append(int(system.get('id', -1)))
	var alliance_hq := -1
	if not alliance_candidates.is_empty():
		var rng := RandomNumberGenerator.new()
		rng.randomize()
		alliance_hq = alliance_candidates[rng.randi_range(0, alliance_candidates.size() - 1)]
	_set_headquarters_system(alliance_hq, ALLIANCE_SIDE)
	_set_headquarters_system(EMPIRE_HQ_SYSTEM_ID, EMPIRE_SIDE)
	_initKnowledge()
	_calculate_maintenance()
	setData('headquarters', {
		ALLIANCE_SIDE: {
			'system_id': alliance_hq,
			'known_to': [ALLIANCE_SIDE],
		},
		EMPIRE_SIDE: {
			'system_id': EMPIRE_HQ_SYSTEM_ID,
			'known_to': [ALLIANCE_SIDE, EMPIRE_SIDE],
		},
	})

func _set_headquarters_system(system_id: int, faction_id: int) -> void:
	if system_id < 0:
		return
	for system in getData('system_data'):
		if int(system.get('id', -1)) != system_id:
			continue
		system['explored'] = true
		system['owner'] = faction_id
		var buildings := _seed_buildings(system, true)
		var economy: Dictionary = system.get('economy', {})
		economy['raw'] = _count_buildings(buildings, MINE_ID)
		economy['refined'] = mini(economy['raw'], _count_buildings(buildings, REFINERY_ID))
		economy['political_share'] = 1.0 if faction_id == int(getData('side')) else 0.0
		system['economy'] = economy
		return

func headquarters_known_to(faction_id: int) -> Dictionary:
	var known: Dictionary = {}
	var headquarters: Dictionary = game_data.get('headquarters', {})
	for faction_id_key in headquarters:
		var headquarters_data: Dictionary = headquarters[faction_id_key]
		if faction_id in headquarters_data.get('known_to', []):
			known[int(faction_id_key)] = int(headquarters_data.get('system_id', -1))
	return known

func _calculate_maintenance() -> void:
	var factions: Array = getData('faction_data')
	var mines := [0, 0]
	var refineries := [0, 0]
	for system in getData('system_data'):
		var owner := int(system.get('owner', -1))
		if owner < 0 or owner >= FACTION_COUNT:
			continue
		var buildings: Array = system.get('buildings', [])
		mines[owner] += _count_buildings(buildings, MINE_ID)
		refineries[owner] += _count_buildings(buildings, REFINERY_ID)
	var points_per_pair := int(GalaxyData.economy(_difficulty).get('maintenance_points_per_pair', 50))
	for faction_id in range(FACTION_COUNT):
		factions[faction_id]['maintenance'] = mini(mines[faction_id], refineries[faction_id]) * points_per_pair

func _owner_for(political_share: float, explored: bool) -> int:
	# Uncharted systems are not connected to either faction yet.
	if not explored:
		return -1
	var threshold := float(GalaxyData.politics()['ownership_threshold'])
	if political_share >= threshold:
		return int(getData('side'))
	if political_share <= 1.0 - threshold:
		return 1 - int(getData('side'))
	return -1

func _production_for(buildings: Array, resource: String) -> int:
	var amount := 0
	for value in buildings:
		var entry := _catalog_entry(int(value))
		if str(entry.get('produces', '')) == resource:
			amount += int(entry.get('producesAmount', 0))
	return amount

func process_day() -> Dictionary:
	var produced_raw := [0, 0]
	for system in getData('system_data'):
		var owner := int(system.get('owner', -1))
		if owner < 0 or owner >= FACTION_COUNT:
			continue
		produced_raw[owner] += _production_for(system.get('buildings', []), 'raw')
	var factions: Array = getData('faction_data')
	for faction_id in range(FACTION_COUNT):
		factions[faction_id]['raw'] += produced_raw[faction_id]
	var produced_refined := [0, 0]
	for system in getData('system_data'):
		var owner := int(system.get('owner', -1))
		if owner < 0 or owner >= FACTION_COUNT:
			continue
		var refinery_result := _refine_resources(system.get('buildings', []), factions[owner]['raw'])
		factions[owner]['raw'] -= refinery_result['raw_used']
		factions[owner]['refined'] += refinery_result['refined']
		produced_refined[owner] += refinery_result['refined']
	_process_construction_orders()
	return {
		'raw': produced_raw,
		'refined': produced_refined,
		'factions': factions,
	}

func building_catalog() -> Dictionary:
	return _building_catalog.duplicate(true)

func queue_building(system_id: int, building_id: int, quantity: int, target_system_id := -1) -> bool:
	var entry := _catalog_entry(building_id)
	if quantity <= 0 or entry.is_empty() or not entry.has('cost') or not entry.has('daysToProduce'):
		return false
	for system in getData('system_data'):
		if int(system.get('id', -1)) != system_id:
			continue
		if int(system.get('owner', -1)) != int(getData('side')):
			return false
		if _count_buildings(system.get('buildings', []), CONSTRUCTION_YARD_ID) <= 0:
			return false
		var target: Dictionary = system if target_system_id < 0 else _system_by_id(target_system_id)
		if target.is_empty() or int(target.get('owner', -1)) != int(getData('side')):
			return false
		var orders: Dictionary = system.get('manufacturing_orders', {})
		var existing: Variant = orders.get('construction', {})
		if existing is Dictionary and not (existing as Dictionary).is_empty():
			return false
		var slots: Dictionary = target.get('%s_slots' % str(entry.get('slot', 'energy')), {})
		var available_slots := int(slots.get('total', 0)) - int(slots.get('used', 0))
		if quantity > available_slots:
			return false
		orders['construction'] = {
			'building_id': building_id,
			'remaining': quantity,
			'construction_points': 0,
			'elapsed_days': 0.0,
			'target_system_id': int(target.get('id', system_id)),
		}
		system['manufacturing_orders'] = orders
		_recalculate_slots(system)
		if int(target.get('id', -1)) != system_id:
			_recalculate_slots(target)
		return true
	return false

func cancel_building_order(system_id: int) -> void:
	for system in getData('system_data'):
		if int(system.get('id', -1)) == system_id:
			var orders: Dictionary = system.get('manufacturing_orders', {})
			orders.erase('construction')
			system['manufacturing_orders'] = orders
			for affected_system in getData('system_data'):
				_recalculate_slots(affected_system)
			return

func _process_construction_orders() -> void:
	var factions: Array = getData('faction_data')
	var player_faction := int(getData('side'))
	_process_transit_orders()
	for system in getData('system_data'):
		var orders: Dictionary = system.get('manufacturing_orders', {})
		var order: Variant = orders.get('construction', {})
		if not order is Dictionary or order.is_empty():
			continue
		var entry := _catalog_entry(int(order.get('building_id', -1)))
		var owner := int(system.get('owner', -1))
		if entry.is_empty() or owner < 0 or owner >= factions.size():
			continue
		var construction_yards := _count_buildings(system.get('buildings', []), CONSTRUCTION_YARD_ID)
		if construction_yards <= 0:
			continue
		var cycle_days := maxf(0.01, float(entry.get('daysToProduce', 1)))
		order['elapsed_days'] = float(order.get('elapsed_days', 0.0)) + 1.0
		if float(order['elapsed_days']) < cycle_days:
			continue
		var cost := maxi(1, int(entry.get('cost', 0)))
		var resource := 'refined'
		var available_resources := int(factions[owner].get(resource, 0))
		if available_resources <= 0:
			order['elapsed_days'] = cycle_days
			continue
		var points_produced := mini(construction_yards, available_resources)
		factions[owner][resource] = available_resources - points_produced
		order['construction_points'] = int(order.get('construction_points', 0)) + points_produced
		order['elapsed_days'] = 0.0
		while int(order.get('construction_points', 0)) >= cost and int(order.get('remaining', 0)) > 0:
			var completed_building_id := int(order.get('building_id', -1))
			order['construction_points'] = int(order.get('construction_points', 0)) - cost
			order['remaining'] = int(order.get('remaining', 1)) - 1
			orders['construction'] = order
			system['manufacturing_orders'] = orders
			_start_transit(system, completed_building_id, int(order.get('target_system_id', system.get('id', -1))))
		if int(order.get('remaining', 0)) <= 0:
			orders.erase('construction')
		else:
			orders['construction'] = order
		_recalculate_slots(system)
		system['manufacturing_orders'] = orders
		if owner == player_faction:
			system['economy']['construction'] = int(system.get('economy', {}).get('construction', 0)) + points_produced

func _start_transit(source: Dictionary, building_id: int, target_id: int) -> void:
	var target := _system_by_id(target_id)
	if target.is_empty():
		return
	if int(source.get('id', -1)) == target_id:
		_add_completed_building(target, building_id)
		return
	var transit: Array = target.get('building_transit', [])
	transit.append({'building_id': building_id, 'days_remaining': 1.0, 'source_system_id': source.get('id', -1)})
	target['building_transit'] = transit
	_recalculate_slots(target)

func _process_transit_orders() -> void:
	for target in getData('system_data'):
		var transit: Array = target.get('building_transit', [])
		var remaining: Array = []
		for shipment in transit:
			var delivery := shipment as Dictionary
			delivery['days_remaining'] = float(delivery.get('days_remaining', 1.0)) - 1.0
			if float(delivery['days_remaining']) <= 0.0:
				_add_completed_building(target, int(delivery.get('building_id', -1)))
			else:
				remaining.append(delivery)
		target['building_transit'] = remaining
		_recalculate_slots(target)

func _add_completed_building(system: Dictionary, building_id: int) -> void:
	var buildings: Array = system.get('buildings', [])
	buildings.append(building_id)
	system['buildings'] = buildings
	_recalculate_slots(system)

func _system_by_id(system_id: int) -> Dictionary:
	for system in getData('system_data'):
		if int(system.get('id', -1)) == system_id:
			return system
	return {}

func _has_building_slot(system: Dictionary, slot: String) -> bool:
	var slots: Dictionary = system.get('%s_slots' % slot, {})
	return int(slots.get('used', 0)) < int(slots.get('total', 0))

func _recalculate_slots(system: Dictionary) -> void:
	var buildings: Array = system.get('buildings', [])
	var resource_slots: Dictionary = system.get('resource_slots', {})
	resource_slots['used'] = _count_buildings(buildings, MINE_ID) + _reserved_slots(system, 'resource')
	var energy_slots: Dictionary = system.get('energy_slots', {})
	energy_slots['used'] = buildings.size() - _count_buildings(buildings, MINE_ID) + _reserved_slots(system, 'energy')
	system['resource_slots'] = resource_slots
	system['energy_slots'] = energy_slots

func _reserved_slots(system: Dictionary, slot: String) -> int:
	var reserved := 0
	var system_id := int(system.get('id', -1))
	for source in getData('system_data'):
		var order: Variant = source.get('manufacturing_orders', {}).get('construction', {})
		if not order is Dictionary or order.is_empty():
			continue
		if int(order.get('target_system_id', source.get('id', -1))) != system_id:
			continue
		var entry := _catalog_entry(int(order.get('building_id', -1)))
		if str(entry.get('slot', 'energy')) == slot:
			reserved += int(order.get('remaining', 0))
	for shipment in system.get('building_transit', []):
		var transit_entry := _catalog_entry(int((shipment as Dictionary).get('building_id', -1)))
		if str(transit_entry.get('slot', 'energy')) == slot:
			reserved += 1
	return reserved

func _refine_resources(buildings: Array, available_raw: int) -> Dictionary:
	var raw_used := 0
	var refined := 0
	for value in buildings:
		var entry := _catalog_entry(int(value))
		if str(entry.get('produces', '')) != 'refined':
			continue
		var needed := maxi(1, int(entry.get('neededToProduce', 1)))
		if available_raw - raw_used < needed:
			break
		raw_used += needed
		refined += int(entry.get('producesAmount', 0))
	return {'raw_used': raw_used, 'refined': refined}

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

func _seed_buildings(system: Dictionary, ensure_construction := false) -> Array:
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
	if bool(system.get('explored', false)):
		if rng.randf() < INHABITED_FACILITY_CHANCE and buildings.size() < int(energy_slots['total']):
			buildings.append(CONSTRUCTION_YARD_ID)
		if rng.randf() < INHABITED_FACILITY_CHANCE and buildings.size() < int(energy_slots['total']):
			buildings.append(SHIPYARD_ID)
		if rng.randf() < INHABITED_FACILITY_CHANCE and buildings.size() < int(energy_slots['total']):
			buildings.append(BASIC_TRAINING_ID)
	if ensure_construction:
		if buildings.size() >= int(energy_slots['total']):
			for index in range(buildings.size() - 1, -1, -1):
				if int(buildings[index]) != MINE_ID:
					buildings.remove_at(index)
					break
		if buildings.size() < int(energy_slots['total']):
			buildings.append(CONSTRUCTION_YARD_ID)
	resource_slots['used'] = _count_buildings(buildings, MINE_ID)
	energy_slots['used'] = buildings.size() - resource_slots['used']
	system['buildings'] = buildings
	return buildings

func _initUnits():
	# add units to each faction based on the faction config.
	pass
