extends PanelContainer

export (PackedScene) var ControlScene

onready var vbox: = $VBoxContainer

var current_state: = {} setget , get_current_state


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


func update_conditional_visibility() -> void:
	return
	for child in vbox.get_children():
		child.show()
		if child.conditions.empty():
			continue
		else:
			for condition in child.conditions:
				if self.current_state.has(condition.property):
					if child.property_value == condition.value:
						child.hide()
#		NEXT STEPS: figure out how to compare enum ints and condition string values


# SETGET =======================================================================


func get_current_state() -> Dictionary:
	var state = {}
	for child in vbox.get_children():
		state[child.property_name] = child.property_value
	return state


# SIGNAL CALLBACKS =============================================================


func _on_Main_property_list_updated(property_list) -> void:
	update_controls(property_list)
	update_conditional_visibility()
