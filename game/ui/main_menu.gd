extends Control
## Main menu: the first interactive screen of the vertical slice.
## Only wired controls live here — no dead ends.

const SETTINGS_PATH := "user://rerebel_settings.cfg"

const SIDES: PackedStringArray = ["Alliance", "Empire"]
const SIDE_SECTION := "side"
const SIDE_KEY := "side"

const GALAXY_SIZES: PackedStringArray = ["Standard", "Large", "Huge"]
const GALAXY_SECTION := "galaxy"
const GALAXY_KEY := "galaxy_size"

const DIFFICULTIES: PackedStringArray = ["Novice", "Intermediate", "Expert"]
const DIFFICULTY_SECTION := "difficulty"
const DIFFICULTY_KEY := "difficulty"

@onready var _about_dialog: AcceptDialog = %AboutDialog
@onready var _side_button: OptionButton = %SideButton
@onready var _galaxy_size_button: OptionButton = %GalaxySizeButton
@onready var _difficulty_button: OptionButton = %DifficultyButton


func _ready() -> void:
	_populate(_side_button, SIDES, _load_setting(SIDE_SECTION, SIDE_KEY, SIDES.size()))
	_populate(_galaxy_size_button, GALAXY_SIZES, _load_setting(GALAXY_SECTION, GALAXY_KEY, GALAXY_SIZES.size()))
	_populate(_difficulty_button, DIFFICULTIES, _load_setting(DIFFICULTY_SECTION, DIFFICULTY_KEY, DIFFICULTIES.size()))


func get_side_name() -> String:
	return SIDES[_side_button.selected]


func get_galaxy_size() -> int:
	return _galaxy_size_button.selected


func get_galaxy_size_name() -> String:
	return GALAXY_SIZES[get_galaxy_size()]


func get_difficulty_name() -> String:
	return DIFFICULTIES[_difficulty_button.selected]


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://galaxy/galaxy_map.tscn")


func _on_about_pressed() -> void:
	_about_dialog.popup_centered()


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_side_selected(index: int) -> void:
	_save_setting(SIDE_SECTION, SIDE_KEY, index)


func _on_galaxy_size_selected(index: int) -> void:
	_save_setting(GALAXY_SECTION, GALAXY_KEY, index)


func _on_difficulty_selected(index: int) -> void:
	_save_setting(DIFFICULTY_SECTION, DIFFICULTY_KEY, index)


func _populate(button: OptionButton, items: PackedStringArray, selected: int) -> void:
	for item in items:
		button.add_item(item)
	button.select(selected)


func _load_setting(section: String, key: String, count: int) -> int:
	var settings := ConfigFile.new()
	var err := settings.load(SETTINGS_PATH)
	if err != OK:
		return 0
	return clampi(int(settings.get_value(section, key, 0)), 0, count - 1)


func _save_setting(section: String, key: String, index: int) -> void:
	var settings := ConfigFile.new()
	settings.load(SETTINGS_PATH)
	settings.set_value(section, key, index)
	var err := settings.save(SETTINGS_PATH)
	if err != OK:
		push_warning("Could not save settings: %s" % error_string(err))
