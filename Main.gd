class_name Main
extends Control

signal property_added(property)
signal property_changed(property)
signal property_deleted(property)

signal property_list_updated(property_list)

onready var export_popup: = $ExportPopup

onready var prop_item_list: = $HBoxContainer/Panel/MarginContainer/LeftSide/PropListContainer/PropertyItemList
onready var add_button: = $HBoxContainer/Panel/MarginContainer/LeftSide/PropListContainer/HBoxContainer/AddButton
onready var delete_button: = $MarginContainer/HBoxContainer/LeftSide/PropListContainer/HBoxContainer/DeleteButton
onready var prop_config: = $HBoxContainer/Panel/MarginContainer/LeftSide/PropConfigContainer/PropertyConfig
onready var output: = $HBoxContainer/Panel2/RightSide/PanelContainer/OutputContainer

enum DataTypes { BOOLEAN, OPTION, NUMBER }

var property_list: = []

var property_dict_base: = {
	name = "",
	type = 0,
	meta = {}
}
var meta_dict_base: = {
	boolean = {
		enabled = false
	},
	option = {
		options = "one, two, three",
		default = 0
	},
	number = {
		min = 0,
		max = 10,
		step = 1,
		default = 0,
		use_slider = true
	}
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
	new_property.meta  = meta_dict_base.boolean.duplicate()

	property_list.append(new_property)

	emit_signal("property_added", new_property)
	emit_signal("property_list_updated", property_list)


func update_property(index:int, config_property: String, value) -> void:
	var selected_property = property_list[index]

	match config_property:
		"name":
			selected_property.name = value
		"type":
			selected_property.type = value
			match value:
				DataTypes.BOOLEAN:
					selected_property.meta = meta_dict_base.boolean.duplicate()
				DataTypes.OPTION:
					selected_property.meta = meta_dict_base.option.duplicate()
				DataTypes.NUMBER:
					selected_property.meta = meta_dict_base.number.duplicate()

		# bool configs
		"bool_enabled":
			selected_property.meta.enabled = value

		# option configs
		"option_options":
			selected_property.meta.options = value
		"option_default":
			selected_property.meta.default = value - 1

		# number configs
		"number_min":
			selected_property.meta.min = value
		"number_max":
			selected_property.meta.max = value
		"number_step":
			selected_property.meta.step = value
		"number_default":
			selected_property.meta.default = value
		"number_show_slider":
			selected_property.meta.use_slider = value

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


func _on_property_list_updated(property_list) -> void:
	output.create_controls(property_list)
	print(property_list)


func _on_property_added(property) -> void:
	prop_item_list.add_item(property.name)
	prop_item_list.select(prop_item_list.get_item_count()-1)
	handle_selection(prop_item_list.get_item_count()-1)


func _on_property_changed(property) -> void:
	var selected_item: int = prop_item_list.get_selected_items()[0]
	prop_item_list.set_item_text(selected_item, property.name)


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
	var selected_property = property_list[selected_item]
	update_property(selected_item, config_property, value)

	if config_property == "type":
		prop_config.update_fields(selected_property)


func _on_ExportButton_pressed() -> void:
	export_popup.update_export(property_list)
	export_popup.popup_centered_ratio()
