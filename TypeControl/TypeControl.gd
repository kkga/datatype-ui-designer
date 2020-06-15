extends HBoxContainer
class_name TypeControl

const LABEL_WIDTH = 48
const CONTROL_SIZE = Vector2(172, 24)

export (Main.DataTypes) var type: int = 1 setget set_type

onready var label := $Label
onready var control := $Control

var meta: Dictionary = {}


func _ready() -> void:
	_change_control(type)


func update_control(property: Dictionary) -> void:
	label.text = property.name

	if not type == property.type:
		self.type = property.type

	if not meta.hash() == property.meta.hash():
		meta = property.meta.duplicate()
	else:
		return

	match type:
		Main.DataTypes.BOOLEAN:
			var checkbox = control as CheckBox
			checkbox.pressed = meta.enabled
		Main.DataTypes.OPTION:
			var option_btn = control as OptionButton
			var options = meta.options.split(', ')
			option_btn.clear()
			for option in options:
				option_btn.add_item(option)
			option_btn.selected = meta.default
		Main.DataTypes.NUMBER:
			var spinbox = control as SpinBox
			spinbox.value = meta.default
			spinbox.min_value = meta.min
			spinbox.max_value = meta.max
			spinbox.step = meta.step
#			TODO: add slider functionality


func _change_control(control_type: int) -> void:
	for child in get_children():
		if not child.name == "Label":
			child.queue_free()
	var new_control: Control

	match control_type:
		Main.DataTypes.BOOLEAN:
			new_control = CheckBox.new()
		Main.DataTypes.OPTION:
			new_control = OptionButton.new()
		Main.DataTypes.NUMBER:
			new_control = SpinBox.new()
	new_control.name = "Control"
	add_child(new_control)
	control = new_control
	control.size_flags_horizontal = SIZE_EXPAND_FILL


# SETGET =======================================================================


func set_type(value: int) -> void:
	type = value
	_change_control(type)
