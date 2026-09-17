class_name BuildDialog
extends PanelContainer

signal build_confirmed(building_id: int, quantity: int)
signal closed
signal catalog_selected(building_id: int)

@onready var _catalog: OptionButton = %BuildCatalog
@onready var _quantity: SpinBox = %BuildQuantity
@onready var _close_button: Button = $Margin/Column/Header/CloseButton
@onready var _build_button: Button = $Margin/Column/BuildButton


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	_close_button.pressed.connect(func() -> void:
		closed.emit()
	)
	_build_button.pressed.connect(func() -> void:
		if _catalog.item_count > 0:
			build_confirmed.emit(_catalog.get_selected_id(), int(_quantity.value))
	)
	_catalog.item_selected.connect(func(_index: int) -> void:
		catalog_selected.emit(_catalog.get_selected_id())
	)


func apply_faction_theme(accent: Color) -> void:
	var bright := accent.lerp(Color.WHITE, 0.3)
	var panel := _dialog_style(Color(0.018, 0.032, 0.06, 1.0), accent, 10)
	panel.shadow_color = Color(0, 0, 0, 0.85)
	panel.shadow_size = 20
	panel.shadow_offset = Vector2(0, 6)
	add_theme_stylebox_override("panel", panel)
	var normal := _dialog_style(Color(0.035, 0.065, 0.11, 1.0), accent.darkened(0.35), 5)
	var hover := _dialog_style(accent.darkened(0.58), bright, 5)
	var pressed := _dialog_style(accent.darkened(0.4), Color.WHITE, 5)
	for control in [_catalog, _quantity, _close_button, _build_button]:
		control.add_theme_stylebox_override("normal", normal)
		control.add_theme_stylebox_override("hover", hover)
		control.add_theme_stylebox_override("pressed", pressed)
		control.add_theme_color_override("font_color", bright)
		control.add_theme_color_override("font_hover_color", Color.WHITE)
		control.add_theme_color_override("font_pressed_color", Color.WHITE)
	$Margin/Column/Header/Title.add_theme_color_override("font_color", bright)


func _dialog_style(background: Color, border: Color, radius: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = background
	style.border_color = border
	style.border_width_left = 2
	style.border_width_top = 2
	style.border_width_right = 2
	style.border_width_bottom = 2
	style.corner_radius_top_left = radius
	style.corner_radius_top_right = radius
	style.corner_radius_bottom_left = radius
	style.corner_radius_bottom_right = radius
	style.content_margin_left = 10.0
	style.content_margin_right = 10.0
	return style


func configure(entries: Array, maximum_quantity: int) -> void:
	_catalog.clear()
	for entry in entries:
		_catalog.add_item(str(entry["label"]), int(entry["id"]))
	_quantity.max_value = maxi(1, maximum_quantity)
	_quantity.value = mini(_quantity.value, _quantity.max_value)
	_build_button.disabled = maximum_quantity <= 0
	visible = true


func set_quantity_limit(maximum_quantity: int) -> void:
	_quantity.max_value = maxi(1, maximum_quantity)
	_quantity.value = mini(_quantity.value, _quantity.max_value)
	_build_button.disabled = maximum_quantity <= 0
