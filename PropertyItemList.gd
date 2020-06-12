extends ItemList


#func create_items(property_list: Array) -> void:
#	clear()
#	for prop in property_list:
#		add_item(prop.name)
##	if selected_item:
##		select(selected_item)


func update_item(index: int, name: String) -> void:
	set_item_text(index, name)
