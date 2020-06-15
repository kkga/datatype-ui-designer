extends PanelContainer

signal condition_changed(condition)
signal delete_pressed()

onready var prop_field := $VBoxContainer/HBoxContainer/RulePropField
onready var comparison_field := $VBoxContainer/HBoxContainer/RuleComparisonField
onready var value_field := $VBoxContainer/HBoxContainer/RuleValueField
onready var title_label := $VBoxContainer/HBoxContainer2/TitleLabel

var condition := {
	property = "",
	comparison = "Is",
	value = ""
}


func setup(_condition: Dictionary) -> void:
	condition = _condition.duplicate()
	prop_field.text = condition.property
	value_field.text = condition.value

	if get_index() > 0:
		title_label.text = "Or..."

	match condition.comparison:
		"Is":
			comparison_field.select(0)
		"Is Not":
			comparison_field.select(1)


func _on_DeleteRuleBtn_pressed() -> void:
	emit_signal("delete_pressed")


func _on_RulePropField_text_changed(new_text: String) -> void:
	condition.property = new_text
	emit_signal("condition_changed", condition)


func _on_RuleComparisonField_item_selected(id: int) -> void:
	match id:
		0:
			condition.comparison = "Is"
		1:
			condition.comparison = "Is Not"
	emit_signal("condition_changed", condition)


func _on_RuleValueField_text_changed(new_text: String) -> void:
	condition.value = new_text
	emit_signal("condition_changed", condition)
