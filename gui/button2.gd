extends TextureButton

func _on_button2_pressed():
	for item in PlayerInventory.inventory1:
		if PlayerInventory.inventory1[item][0] == "cobblestone" and PlayerInventory.inventory1[item][1] >= 12:
			PlayerInventory.inventory1[item][1] -= 12
			if PlayerInventory.inventory1[item][1] == 0:
				PlayerInventory.inventory1.erase(item)
				var inventory1 = get_parent().get_parent().get_parent().get_node("inventory")
				inventory1.finder(item)
			PlayerInventory.add_item("stove", 1)
			return
	for item in PlayerInventory.inventory:
		if PlayerInventory.inventory[item][0] == "cobblestone" and PlayerInventory.inventory[item][1] >= 12:
			PlayerInventory.inventory[item][1] -= 12
			if PlayerInventory.inventory[item][1] == 0:
				PlayerInventory.inventory.erase(item)
				var inventory1 = get_parent().get_parent().get_parent().get_node("inventory")
				inventory1.finder1(item)
			PlayerInventory.add_item("stove", 1)
			return
