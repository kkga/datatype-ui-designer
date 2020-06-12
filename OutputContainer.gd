extends VBoxContainer

const LABEL_WIDTH = 48
const CONTROL_WIDTH = 172


func create_controls(property_list: Array) -> void:
	_clear()
	for prop in property_list:
		var control: = _create_property_control(prop.name, prop.type, prop.hint)
		add_child(control)


func _clear() -> void:
	for child in get_children():
		child.queue_free()


func _create_property_control(property: String, type: int, hint: String) -> Control:
	var container: = HBoxContainer.new()

	var label: = Label.new()
	var control: Control

	label.text = property

	match type:
		Main.DataTypes.BOOLEAN:
			control = CheckBox.new()
		Main.DataTypes.OPTION:
			control = OptionButton.new()

	print(hint)

	label.rect_min_size.x = LABEL_WIDTH
	control.rect_min_size.x = CONTROL_WIDTH

	container.add_child(label)
	container.add_child(control)

	return container
