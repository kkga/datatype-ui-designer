extends ItemList

var selected_item:int

func _ready() -> void:
	connect("item_selected", self, "_on_item_selected")


func create_items(property_list: Array) -> void:
	clear()
	for prop in property_list:
		add_item(prop.name)
	if selected_item:
		select(selected_item)


# SIGNAL CALLBACKS =============================================================


func _on_item_selected(index: int) -> void:
	selected_item = index
