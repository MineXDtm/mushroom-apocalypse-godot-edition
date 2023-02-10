extends GridContainer


func drop_data(position, data):
	get_tree().get_nodes_in_group("player")[0].add_item(data.item_name,data.item_quantity)
	get_parent().holding_item = null
	get_parent().select = false
