extends PanelContainer

export (PackedScene) var ControlScene

onready var vbox: = $VBoxContainer

var state: = {}


func _ready() -> void:
	for child in vbox.get_children():
		child.queue_free()


func update_controls(property_list: Array) -> void:
	for i in range(0, property_list.size()):
		if vbox.get_child_count() >= i+1:
			vbox.get_child(i).update_control(property_list[i])
		else:
			var control: TypeControl = ControlScene.instance()
			vbox.add_child(control)
			control.update_control(property_list[i])

#		if _check_condition(prop, property_list):
#		var control: = _create_property_control(prop.name, prop.type, prop.meta)

#func _check_condition(property: Dictionary, property_list: Array) -> bool:
#	var condition_state: bool
#	var condition = property.condition
#
#	for prop in property_list:
#		if condition.has(prop.name) and condition[prop.name] == prop.value:
#			condition_state = true
#
#	return condition_state


# SIGNAL CALLBACKS =============================================================


func _on_Main_property_list_updated(property_list) -> void:
	update_controls(property_list)
