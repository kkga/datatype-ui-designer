extends PanelContainer

signal value_changed(property, value)

onready var name_field: = $MarginContainer/VBoxContainer/NameContainer/NameField
onready var type_field: = $MarginContainer/VBoxContainer/TypeContainer/TypeField

onready var boolean_settings: = $MarginContainer/VBoxContainer/Boolean
onready var option_settings: = $MarginContainer/VBoxContainer/Option
onready var number_settings: = $MarginContainer/VBoxContainer/Number

onready var bool_enabled_btn: = $MarginContainer/VBoxContainer/Boolean/HBoxContainer/BoolEnabled


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
		Main.DataTypes.NUMBER:
			number_settings.show()


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
