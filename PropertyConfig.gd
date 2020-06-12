extends PanelContainer

signal value_changed(property, value)

onready var name_field: = $MarginContainer/VBoxContainer/HBoxContainer/NameField
onready var type_field: = $MarginContainer/VBoxContainer/HBoxContainer2/TypeField


func _ready() -> void:
	pass


func update_fields(property: Dictionary) -> void:
	name_field.text = property.name
	type_field.select(property.type)


# SIGNAL CALLBACKS =============================================================


func _on_NameField_text_changed(new_text: String) -> void:
	emit_signal("value_changed", "name", new_text)


func _on_TypeField_item_selected(id: int) -> void:
	emit_signal("value_changed", "type", id)
