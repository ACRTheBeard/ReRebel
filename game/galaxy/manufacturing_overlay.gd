class_name ManufacturingOverlay
extends PanelContainer

signal action_requested(action_id: int)
signal target_drag_started(panel_id: int)
signal target_drag_ended(panel_id: int, screen_position: Vector2)

const FLEET_PANEL := 0
const TRAINING_PANEL := 1
const CONSTRUCTION_PANEL := 2

@onready var _header: Control = $Margin/Column/HeaderRow
@onready var _construction_box: Control = %ConstructionBox
@onready var _fleet_box: Control = %FleetBox
@onready var _training_box: Control = %TroopBox

var _action_menu: PopupMenu
var _dragging := false
var _drag_offset := Vector2.ZERO
var _target_dragging := false
var _target_panel_id := CONSTRUCTION_PANEL


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	_action_menu = PopupMenu.new()
	_action_menu.name = "ManufacturingActions"
	_action_menu.id_pressed.connect(func(action_id: int) -> void: action_requested.emit(action_id))
	add_child(_action_menu)
	_construction_box.gui_input.connect(_on_construction_box_gui_input)
	_fleet_box.gui_input.connect(_on_fleet_box_gui_input)
	_training_box.gui_input.connect(_on_training_box_gui_input)
	_header.gui_input.connect(_on_header_gui_input)


func _on_construction_box_gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	var mouse_button := event as InputEventMouseButton
	if mouse_button.button_index != MOUSE_BUTTON_RIGHT or not mouse_button.pressed:
		if mouse_button.button_index == MOUSE_BUTTON_LEFT and mouse_button.pressed:
			_target_dragging = true
			_target_panel_id = CONSTRUCTION_PANEL
			target_drag_started.emit(_target_panel_id)
			_construction_box.accept_event()
		return
	_action_menu.clear()
	_action_menu.add_item("Build", 1)
	_action_menu.position = Vector2i(get_global_mouse_position())
	_action_menu.popup()
	_construction_box.accept_event()


func _on_fleet_box_gui_input(event: InputEvent) -> void:
	_on_target_box_gui_input(event, FLEET_PANEL, _fleet_box)


func _on_training_box_gui_input(event: InputEvent) -> void:
	_on_target_box_gui_input(event, TRAINING_PANEL, _training_box)


func _on_target_box_gui_input(event: InputEvent, panel_id: int, box: Control) -> void:
	if event is InputEventMouseButton and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT and (event as InputEventMouseButton).pressed:
		_target_dragging = true
		_target_panel_id = panel_id
		target_drag_started.emit(panel_id)
		box.accept_event()


func _on_header_gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	var mouse_button := event as InputEventMouseButton
	if mouse_button.button_index != MOUSE_BUTTON_LEFT:
		return
	if mouse_button.pressed:
		_dragging = true
		_drag_offset = get_global_mouse_position() - global_position
		_header.accept_event()
	elif _dragging:
		_dragging = false
		_header.accept_event()


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_button := event as InputEventMouseButton
		if mouse_button.button_index == MOUSE_BUTTON_RIGHT and mouse_button.pressed:
			if _construction_box.get_global_rect().has_point(get_global_mouse_position()):
				_action_menu.clear()
				_action_menu.add_item("Build", 1)
				_action_menu.position = Vector2i(get_global_mouse_position())
				_action_menu.popup()
				accept_event()
	elif event is InputEventMouseMotion and _dragging:
		global_position = get_global_mouse_position() - _drag_offset
		accept_event()


func _input(event: InputEvent) -> void:
	if not _target_dragging or not event is InputEventMouseButton:
		return
	var mouse_button := event as InputEventMouseButton
	if mouse_button.button_index == MOUSE_BUTTON_LEFT and not mouse_button.pressed:
		_target_dragging = false
		target_drag_ended.emit(_target_panel_id, get_viewport().get_mouse_position())
		get_viewport().set_input_as_handled()
