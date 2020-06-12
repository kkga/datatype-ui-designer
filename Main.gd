extends Control

onready var ui_panel: = $MarginContainer/HBoxContainer/RightSide/PanelContainer/UIPanelContainer

enum DataTypes { BOOLEAN, OPTION, NUMBER, STRING }

const LABEL_WIDTH = 48
const CONTROL_WIDTH = 172


func create_property_control(property: String, data_type: int, data_hints: = {}) -> Control:
	var container: = HBoxContainer.new()

	var label: = Label.new()
	var control: Control

	label.text = property

	match data_type:
		DataTypes.BOOLEAN:
			control = CheckBox.new()
		DataTypes.OPTION:
			control = OptionButton.new()

	label.rect_min_size.x = LABEL_WIDTH
	control.rect_min_size.x = CONTROL_WIDTH

	container.add_child(label)
	container.add_child(control)

	return container


func add_control(control: Control) -> void:
	ui_panel.add_child(control)


# SIGNAL CALLBACKS =============================================================


func _on_BoolButton_pressed() -> void:
	var control := create_property_control('my_bool', DataTypes.BOOLEAN)
	add_control(control)


func _on_OptionButton_pressed() -> void:
	var control := create_property_control('my_enum', DataTypes.OPTION)
	add_control(control)
