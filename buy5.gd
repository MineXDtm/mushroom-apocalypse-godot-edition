extends TextureButton
var nedded1 = null
var nedded2 = null
var done
var done_number
var needed_number1
var needed_number2

func _on_buy1_pressed():
	if nedded1 == null:
		for item in PlayerInventory.inventory1:
			if PlayerInventory.inventory1[item][0] == nedded2 and PlayerInventory.inventory1[item][1] >= needed_number2:
				PlayerInventory.inventory1[item][1] -= needed_number2
				if PlayerInventory.inventory1[item][1] == 0:
					PlayerInventory.inventory1.erase(item)
					var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
					inventory1.finder(item)
				PlayerInventory.add_item(done, done_number)
				return
		for item in PlayerInventory.inventory:
			if PlayerInventory.inventory[item][0] == nedded2 and PlayerInventory.inventory[item][1] >= needed_number2:
				PlayerInventory.inventory[item][1] -= needed_number2
				if PlayerInventory.inventory[item][1] == 0:
					PlayerInventory.inventory.erase(item)
					var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
					inventory1.finder1(item)
				PlayerInventory.add_item(done, done_number)
				return
	else:
		for item in PlayerInventory.inventory1:
			for item2 in PlayerInventory.inventory1:
				print(PlayerInventory.inventory1[item2][0])
				if PlayerInventory.inventory1[item][0] == nedded2 and PlayerInventory.inventory1[item][1] >= needed_number2 and PlayerInventory.inventory1[item2][0] == nedded1 and PlayerInventory.inventory1[item2][1] >= needed_number1:
					PlayerInventory.inventory1[item][1] -= needed_number2
					PlayerInventory.inventory1[item2][1] -= needed_number1
					if PlayerInventory.inventory1[item][1] == 0:
						PlayerInventory.inventory1.erase(item)
						var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
						inventory1.finder(item)
					if PlayerInventory.inventory1[item2][1] == 0:
						PlayerInventory.inventory1.erase(item2)
						var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
						inventory1.finder(item2)
					PlayerInventory.add_item(done, done_number)
					return
				elif  PlayerInventory.inventory1[item][0] == nedded2 and PlayerInventory.inventory1[item][1] >= needed_number2:
					for item3 in PlayerInventory.inventory:
						if PlayerInventory.inventory[item3][0] == nedded1 and PlayerInventory.inventory[item3][1] >= needed_number1:
							PlayerInventory.inventory1[item][1] -= needed_number2
							PlayerInventory.inventory[item3][1] -= needed_number1
							if PlayerInventory.inventory1[item][1] == 0:
								PlayerInventory.inventory1.erase(item)
								var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
								inventory1.finder(item)
							if PlayerInventory.inventory[item3][1] == 0:
								PlayerInventory.inventory.erase(item3)
								var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
								inventory1.finder1(item3)
							PlayerInventory.add_item(done, done_number)
							return
		for item in PlayerInventory.inventory:
			for item2 in PlayerInventory.inventory:
				if PlayerInventory.inventory[item][0] == nedded2 and PlayerInventory.inventory[item][1] >= needed_number2 and PlayerInventory.inventory[item2][0] == nedded1 and PlayerInventory.inventory[item2][1] >= needed_number1:
					PlayerInventory.inventory[item][1] -= needed_number2
					PlayerInventory.inventory[item2][1] -= needed_number1
					if PlayerInventory.inventory[item][1] == 0:
						PlayerInventory.inventory.erase(item)
						var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
						inventory1.finder1(item)
					if PlayerInventory.inventory[item2][1] == 0:
						PlayerInventory.inventory.erase(item2)
						var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
						inventory1.finder1(item2)
					PlayerInventory.add_item(done, done_number)
					return
				
