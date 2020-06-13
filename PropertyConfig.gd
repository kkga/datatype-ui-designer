extends PanelContainer

signal value_changed(property, value)

onready var name_field: = $MarginContainer/VBoxContainer/NameContainer/NameField
onready var type_field: = $MarginContainer/VBoxContainer/TypeContainer/TypeField

onready var boolean_settings: = $MarginContainer/VBoxContainer/Boolean
onready var option_settings: = $MarginContainer/VBoxContainer/Option
onready var number_settings: = $MarginContainer/VBoxContainer/Number


func update_fields(property: Dictionary) -> void:
	boolean_settings.hide()
	option_settings.hide()
	number_settings.hide()

	name_field.text = property.name
	type_field.select(property.type)

	match property.type:
		Main.DataTypes.BOOLEAN:
			boolean_settings.show()
		Main.DataTypes.OPTION:
			option_settings.show()
		Main.DataTypes.NUMBER:
			number_settings.show()


# SIGNAL CALLBACKS =============================================================


func _on_NameField_text_changed(new_text: String) -> void:
	emit_signal("value_changed", "name", new_text)


func _on_TypeField_item_selected(id: int) -> void:
	emit_signal("value_changed", "type", id)
