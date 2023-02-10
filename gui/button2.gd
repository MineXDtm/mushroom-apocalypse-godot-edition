extends TextureButton

func _on_button2_pressed():
	for item in get_tree().get_nodes_in_group("player")[0].arm:
		if get_tree().get_nodes_in_group("player")[0].arm[item][0] == "cobblestone" and get_tree().get_nodes_in_group("player")[0].arm[item][1] >= 12:
			get_tree().get_nodes_in_group("player")[0].arm[item][1] -= 12
			if get_tree().get_nodes_in_group("player")[0].arm[item][1] == 0:
				get_tree().get_nodes_in_group("player")[0].arm.erase(item)
				var inventory1 = get_parent().get_parent().get_parent().get_node("inventory")
				inventory1.finder(item)
			get_tree().get_nodes_in_group("player")[0].add_item("stove", 1)
			return
	for item in get_tree().get_nodes_in_group("player")[0].inventory:
		if get_tree().get_nodes_in_group("player")[0].inventory[item][0] == "cobblestone" and get_tree().get_nodes_in_group("player")[0].inventory[item][1] >= 12:
			get_tree().get_nodes_in_group("player")[0].inventory[item][1] -= 12
			if get_tree().get_nodes_in_group("player")[0].inventory[item][1] == 0:
				get_tree().get_nodes_in_group("player")[0].inventory.erase(item)
				var inventory1 = get_parent().get_parent().get_parent().get_node("inventory")
				inventory1.finder1(item)
			get_tree().get_nodes_in_group("player")[0].add_item("stove", 1)
			return
