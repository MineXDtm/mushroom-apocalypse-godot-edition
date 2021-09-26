extends Button


func _on_Button_pressed():
	get_tree().paused = false
	get_parent().get_parent().get_parent().get_node(str(WorldData.map+"/sort/player")).died = false
	get_parent().visible = false
	for i in Ganaretor.zombie:
		if Ganaretor.zombies.has(i):
			Ganaretor.zombies.erase(i)
	for i in PlayerInventory.NUM_INVENTORY_SLOTS2:
		if PlayerInventory.inventory1.has(i):
			PlayerInventory.inventory1.erase(i)
	for i in PlayerInventory.NUM_INVENTORY_SLOTS:
		if PlayerInventory.inventory.has(i):
			PlayerInventory.inventory.erase(i)
	Ganaretor.zombie = 0
	get_tree().reload_current_scene()
