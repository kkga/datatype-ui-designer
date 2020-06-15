extends PanelContainer

signal value_changed(property, value)

onready var name_field := $MarginContainer/VBoxContainer/NameContainer/NameField
onready var type_field := $MarginContainer/VBoxContainer/TypeContainer/TypeField

onready var boolean_settings := $MarginContainer/VBoxContainer/Boolean
onready var option_settings := $MarginContainer/VBoxContainer/Option
onready var number_settings := $MarginContainer/VBoxContainer/Number

# bool controls
onready var bool_enabled_btn := $MarginContainer/VBoxContainer/Boolean/HBoxContainer/BoolEnabled

# option controls
onready var option_options_field := $MarginContainer/VBoxContainer/Option/HBoxContainer/OptionOptions
onready var option_default := $MarginContainer/VBoxContainer/Option/HBoxContainer2/OptionDefault

# number controls
onready var number_min_field := $MarginContainer/VBoxContainer/Number/HBoxContainer/NumberMin
onready var number_max_field := $MarginContainer/VBoxContainer/Number/HBoxContainer2/NumberMax
onready var number_step_field := $MarginContainer/VBoxContainer/Number/HBoxContainer4/NumberStep
onready var number_default_field := $MarginContainer/VBoxContainer/Number/HBoxContainer5/NumberDefault
onready var number_suffix_field := $MarginContainer/VBoxContainer/Number/HBoxContainer6/NumberSuffix
onready var number_slider_btn := $MarginContainer/VBoxContainer/Number/HBoxContainer3/NumberShowSlider


func update_fields(property: Dictionary) -> void:
	boolean_settings.hide()
	option_settings.hide()
	number_settings.hide()

	name_field.text = property.name
	type_field.select(property.type)

	match property.type:
		Main.DataTypes.BOOLEAN:
			boolean_settings.show()
			bool_enabled_btn.pressed = property.meta.enabled
		Main.DataTypes.OPTION:
			option_settings.show()
			option_options_field.text = property.meta.options
			option_default.value = property.meta.default + 1
		Main.DataTypes.NUMBER:
			number_settings.show()
			number_min_field.value = property.meta.min
			number_max_field.value = property.meta.max
			number_step_field.value = property.meta.step
			number_default_field.value = property.meta.default
			number_suffix_field.text = property.meta.suffix
			number_slider_btn.pressed = property.meta.use_slider


# SIGNAL CALLBACKS =============================================================

# base props


func _on_NameField_text_changed(new_text: String) -> void:
	emit_signal("value_changed", "name", new_text)


func _on_TypeField_item_selected(id: int) -> void:
	emit_signal("value_changed", "type", id)


# Boolean props


func _on_BoolEnabled_toggled(button_pressed: bool) -> void:
	emit_signal("value_changed", "bool_enabled", button_pressed)


# Option props


func _on_OptionOptions_text_changed(new_text: String) -> void:
	emit_signal("value_changed", "option_options", new_text)


func _on_OptionDefault_value_changed(value: float) -> void:
	emit_signal("value_changed", "option_default", value)


# Number props


func _on_NumberMin_value_changed(value: float) -> void:
	emit_signal("value_changed", "number_min", value)


func _on_NumberMax_value_changed(value: float) -> void:
	emit_signal("value_changed", "number_max", value)


func _on_NumberStep_value_changed(value: float) -> void:
	emit_signal("value_changed", "number_step", value)


func _on_NumberDefault_value_changed(value: float) -> void:
	emit_signal("value_changed", "number_default", value)


func _on_NumberShowSlider_toggled(button_pressed: bool) -> void:
	emit_signal("value_changed", "number_show_slider", button_pressed)


func _on_NumberSuffix_text_changed(new_text: String) -> void:
	emit_signal("value_changed", "number_suffix", new_text)
