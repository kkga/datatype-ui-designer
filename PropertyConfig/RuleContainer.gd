extends PanelContainer

signal condition_changed(condition)
signal delete_pressed()

onready var prop_field := $VBoxContainer/HBoxContainer/RulePropField
onready var comparison_field := $VBoxContainer/HBoxContainer/RuleComparisonField
onready var value_field := $VBoxContainer/HBoxContainer/RuleValueField
onready var title_label := $VBoxContainer/HBoxContainer2/TitleLabel

var _condition := {}
var _property_list


func setup(condition: Dictionary, property_list: Array) -> void:
	_condition = condition.duplicate()
	_property_list = property_list

	prop_field.text = _condition.property

	if get_index() > 0:
		title_label.text = "Or..."

	_update_value_options(_condition.property)


func _update_value_options(property_name: String) -> void:
	value_field.clear()
	var options = []

	for i in range(0, _property_list.size()):
		if property_name == _property_list[i].name:
			var option_strings = _property_list[i].meta.options.split(', ')
			for string in option_strings:
				options.append(string)

	for option in options:
		value_field.add_item(option)

	value_field.selected = options.find(_condition.value)
	emit_signal("condition_changed", _condition)


func _update_condition_value(selected_id) -> void:
	print(_condition)
	for i in range(0, _property_list.size()):
		if _condition.property == _property_list[i].name:
			var options = _property_list[i].meta.options.split(', ')
			var selected_option = options[selected_id]
			_condition.value = selected_option
#			printt(options, selected_option)
			break
	print(_condition)
	emit_signal("condition_changed", _condition)



# SIGNAL CALLBACKS =============================================================


func _on_DeleteRuleBtn_pressed() -> void:
	emit_signal("delete_pressed")


func _on_RulePropField_text_changed(new_text: String) -> void:
	_condition.property = new_text
	_update_value_options(new_text)
	emit_signal("condition_changed", _condition)


func _on_RuleComparisonField_item_selected(id: int) -> void:
	match id:
		0:
			_condition.comparison = "Is"
		1:
			_condition.comparison = "Is Not"
	emit_signal("condition_changed", _condition)


func _on_RuleValueField_text_changed(new_text: String) -> void:
	_condition.value = new_text
	emit_signal("condition_changed", _condition)


func _on_RuleValueField_item_selected(id: int) -> void:
	_update_condition_value(id)
