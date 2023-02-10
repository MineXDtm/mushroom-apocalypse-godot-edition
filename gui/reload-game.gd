extends Button


func _on_Button_pressed():
	get_tree().paused = false
	get_parent().get_parent().get_parent().get_node(str(WorldData.map+"/sort/player")).died = false
	get_parent().visible = false
	for i in Ganaretor.zombie:
		if Ganaretor.zombies.has(i):
			Ganaretor.zombies.erase(i)
	for i in range(3):
		if get_tree().get_nodes_in_group("player")[0].arm.has(i):
			get_tree().get_nodes_in_group("player")[0].arm.erase(i)
	for i in  range(12):
		if get_tree().get_nodes_in_group("player")[0].inventory.has(i):
			get_tree().get_nodes_in_group("player")[0].inventory.erase(i)
	Ganaretor.zombie = 0
	get_tree().reload_current_scene()
