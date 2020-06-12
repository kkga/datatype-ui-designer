class_name Main
extends Control

signal property_list_updated()

onready var prop_item_list: = $MarginContainer/HBoxContainer/LeftSide/PropListContainer/PropertyItemList
onready var add_button: = $MarginContainer/HBoxContainer/LeftSide/PropListContainer/HBoxContainer/AddButton
onready var delete_button: = $MarginContainer/HBoxContainer/LeftSide/PropListContainer/HBoxContainer/DeleteButton
onready var prop_config: = $MarginContainer/HBoxContainer/LeftSide/PropConfigContainer/PropertyConfig
onready var output: = $MarginContainer/HBoxContainer/RightSide/PanelContainer/OutputContainer

enum DataTypes { BOOLEAN, OPTION, NUMBER }

var property_list: = []

var property_dict: = {
	name = "",
	type = 0,
}


func _ready() -> void:
	connect("property_list_updated", self, "_on_property_list_updated")


func add_property() -> void:
	var new_property: = property_dict.duplicate()
	new_property.name = "new property"
	new_property.type = DataTypes.BOOLEAN

	property_list.append(new_property)

	emit_signal("property_list_updated")


# SIGNAL CALLBACKS =============================================================


func _on_AddButton_pressed() -> void:
	add_property()


func _on_DeleteButton_pressed() -> void:
	pass # Replace with function body.


func _on_property_list_updated() -> void:
	print(property_list)

	prop_item_list.create_items(property_list)
	output.create_controls(property_list)


func _on_PropertyItemList_nothing_selected() -> void:
	delete_button.disabled = true


func _on_PropertyItemList_item_selected(index: int) -> void:
	delete_button.disabled = false
	prop_config.update_fields(property_list[index])


func _on_PropertyConfig_value_changed(property, value) -> void:
	var selected_property = property_list[prop_item_list.get_selected_items()[0]]
	match property:
		"name":
			selected_property.name = value
		"type":
			selected_property.type = value
	emit_signal("property_list_updated")

