extends Control



func _input(event):
	pass
#	if event.is_action_pressed("drop"):
#		var _selected_slot = get_node(selected)
#		var world = get_parent().get_parent().get_node(str(WorldData.map,"/sort"))
#		var player = get_parent().get_parent().get_node(str(WorldData.map,"/sort/player"))
#		var drop_scene = load("res://world/drop/ItemDrop.tscn")
#		var _drop_intance = drop_scene.instance()
#		_drop_intance.item_name = holding_item.item_name
#		_drop_intance.position = player.position
#		world.add_child(_drop_intance)
#		if holding_item.item_quantity > 1:
#			holding_item.decrease_item_quantity(1)
#			if selected_name == "slot1":
#				get_tree().get_nodes_in_group("player")[0].arm[0][1] -= 1
#			elif selected_name == "slot2":
#				get_tree().get_nodes_in_group("player")[0].arm[1][1] -= 1
#			elif selected_name == "slot3":
#				get_tree().get_nodes_in_group("player")[0].arm[2][1] -= 1
#		else:
#			holding_item.decrease_item_quantity(1)
#
#			if selected_name == "slot1":
#				get_tree().get_nodes_in_group("player")[0].arm.erase(0)
#			elif selected_name == "slot2":
#				get_tree().get_nodes_in_group("player")[0].arm.erase(1)
#			elif selected_name == "slot3":
#				get_tree().get_nodes_in_group("player")[0].arm.erase(2)
#			holding_item = null
