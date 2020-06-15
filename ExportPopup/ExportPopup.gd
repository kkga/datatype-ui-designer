extends WindowDialog

onready var text_edit: = $MarginContainer/TextEdit


func update_export(property_list) -> void:
	var json = JSON.print(property_list)
	text_edit.text = JSONBeautifier.beautify_json(json)
