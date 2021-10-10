extends GridContainer


func drop_data(position, data):
	PlayerInventory.add_item(data.item_name,data.item_quantity)
	get_parent().holding_item = null
	get_parent().select = false
