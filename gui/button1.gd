extends TextureButton

func _on_button1_pressed():
	for item in get_tree().get_nodes_in_group("player")[0].arm:
		if get_tree().get_nodes_in_group("player")[0].arm[item][0] == "drop_wood" and get_tree().get_nodes_in_group("player")[0].arm[item][1] >= 2:
			print("crafted")
			get_tree().get_nodes_in_group("player")[0].arm[item][1] -= 2
			if get_tree().get_nodes_in_group("player")[0].arm[item][1] == 0:
				get_tree().get_nodes_in_group("player")[0].arm.erase(item)
				var inventory1 = get_parent().get_parent().get_parent().get_node("inventory")
				#inventory1.finder(item)
			get_tree().get_nodes_in_group("player")[0].add_item("build_block", 1)
			return
	for item in range(12):
		if get_tree().get_nodes_in_group("player")[0].inventory[item][0] == "drop_wood" and get_tree().get_nodes_in_group("player")[0].inventory[item][1] >= 2:
			print("cra2ted")
			get_tree().get_nodes_in_group("player")[0].inventory[item][1] -= 2
			if get_tree().get_nodes_in_group("player")[0].inventory[item][1] == 0:
				get_tree().get_nodes_in_group("player")[0].inventory.erase(item)
				var inventory1 = get_parent().get_parent().get_parent().get_node("inventory")
				#inventory1.finder1(item)
			get_tree().get_nodes_in_group("player")[0].add_item("build_block", 1)
			return
