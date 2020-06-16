extends PanelContainer

export (PackedScene) var ControlScene

onready var vbox: = $VBoxContainer

var current_state: = {} setget , get_current_state

var _property_list: Array


func _ready() -> void:
	for child in vbox.get_children():
		child.queue_free()


func update_controls(property_list: Array) -> void:
	_property_list = property_list
	for i in range(0, property_list.size()):
		if vbox.get_child_count() >= i+1:
			vbox.get_child(i).update_control(property_list[i])
		else:
			var control: TypeControl = ControlScene.instance()
			vbox.add_child(control)
			control.update_control(property_list[i])
			control.connect("value_changed", self, "_on_Control_value_changed")


func update_conditional_visibility() -> void:
	for child in vbox.get_children():
		child.show()
		if child.conditions.empty():
			continue
		else:
			child.hide()
			for condition in child.conditions:
				if self.current_state.has(condition.property):
					var conditional_control = vbox.get_child(self.current_state.keys().find(condition.property))
					for i in range(0, _property_list.size()):
						if _property_list[i].name == condition.property:
							var property_options = []
							var option_strings = _property_list[i].meta.options.split(', ')
							for string in option_strings:
								property_options.append(string)

							printt(conditional_control.property_value, property_options.find(condition.value))
							if conditional_control.property_value == property_options.find(condition.value):
								child.show()


# SETGET =======================================================================


func get_current_state() -> Dictionary:
	var state = {}
	for child in vbox.get_children():
		state[child.property_name] = child.property_value
	print(state)
	return state


# SIGNAL CALLBACKS =============================================================


func _on_Main_property_list_updated(property_list) -> void:
	update_controls(property_list)
	update_conditional_visibility()


func _on_Control_value_changed() -> void:
	update_controls(_property_list)
	update_conditional_visibility()
