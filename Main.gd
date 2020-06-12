class_name Main
extends Control

signal property_added(property)
signal property_changed(property)
signal property_deleted(property)

signal property_list_updated(property_list)

onready var prop_item_list: = $MarginContainer/HBoxContainer/LeftSide/PropListContainer/PropertyItemList
onready var add_button: = $MarginContainer/HBoxContainer/LeftSide/PropListContainer/HBoxContainer/AddButton
onready var delete_button: = $MarginContainer/HBoxContainer/LeftSide/PropListContainer/HBoxContainer/DeleteButton
onready var prop_config: = $MarginContainer/HBoxContainer/LeftSide/PropConfigContainer/PropertyConfig
onready var output: = $MarginContainer/HBoxContainer/RightSide/PanelContainer/OutputContainer

enum DataTypes { BOOLEAN, OPTION, NUMBER }

var property_list: = []

var property_dict_base: = {
	name = "",
	type = 0,
	hint = ""
}


func _ready() -> void:
	connect("property_added", self, "_on_property_added")
	connect("property_deleted", self, "_on_property_deleted")
	connect("property_changed", self, "_on_property_changed")
	connect("property_list_updated", self, "_on_property_list_updated")


func add_property() -> void:
	var new_property: = property_dict_base.duplicate()
	new_property.name = "new property"
	new_property.type = DataTypes.BOOLEAN
	new_property.hint = ""

	property_list.append(new_property)

	emit_signal("property_added", new_property)


func update_property(index:int, config_property: String, value) -> void:
	var selected_property = property_list[index]

	match config_property:
		"name":
			selected_property.name = value
		"type":
			selected_property.type = value
		"hint":
			selected_property.hint = value

	emit_signal("property_changed", selected_property)
	emit_signal("property_list_updated", property_list)


func handle_selection(index) -> void:
	if index == -1:
		prop_config.hide()
		return

	var selected_property = property_list[index]

	prop_config.show()
	prop_config.update_fields(selected_property)


# SIGNAL CALLBACKS =============================================================


func _on_property_added(property) -> void:
	prop_item_list.add_item(property.name)
	prop_item_list.select(prop_item_list.get_item_count()-1)
	handle_selection(prop_item_list.get_item_count()-1)


func _on_property_changed(property) -> void:
	var selected_item: int = prop_item_list.get_selected_items()[0]
	prop_item_list.set_item_text(selected_item, property.name)


func _on_property_list_updated(property_list) -> void:
	output.create_controls(property_list)


func _on_AddButton_pressed() -> void:
	add_property()


func _on_DeleteButton_pressed() -> void:
#	property_list.erase(_selected_property)
	prop_item_list.unselect_all()


func _on_PropertyItemList_nothing_selected() -> void:
#	-1 means deselect
	handle_selection(-1)


func _on_PropertyItemList_item_selected(index: int) -> void:
	handle_selection(index)


func _on_PropertyConfig_value_changed(config_property, value) -> void:
	var selected_item: int = prop_item_list.get_selected_items()[0]
	update_property(selected_item, config_property, value)

