extends TextureButton
var nedded1 = null
var nedded2 = null
var done
var done_number
var needed_number1
var needed_number2

func _on_buy1_pressed():
	if nedded1 == null:
		for item in get_tree().get_nodes_in_group("player")[0].arm:
			if get_tree().get_nodes_in_group("player")[0].arm[item][0] == nedded2 and get_tree().get_nodes_in_group("player")[0].arm[item][1] >= needed_number2:
				get_tree().get_nodes_in_group("player")[0].arm[item][1] -= needed_number2
				if get_tree().get_nodes_in_group("player")[0].arm[item][1] == 0:
					get_tree().get_nodes_in_group("player")[0].arm.erase(item)
					var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
					inventory1.finder(item)
				get_tree().get_nodes_in_group("player")[0].add_item(done, done_number)
				return
		for item in get_tree().get_nodes_in_group("player")[0].inventory:
			if get_tree().get_nodes_in_group("player")[0].inventory[item][0] == nedded2 and get_tree().get_nodes_in_group("player")[0].inventory[item][1] >= needed_number2:
				get_tree().get_nodes_in_group("player")[0].inventory[item][1] -= needed_number2
				if get_tree().get_nodes_in_group("player")[0].inventory[item][1] == 0:
					get_tree().get_nodes_in_group("player")[0].inventory.erase(item)
					var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
					inventory1.finder1(item)
				get_tree().get_nodes_in_group("player")[0].add_item(done, done_number)
				return
	else:
		for item in get_tree().get_nodes_in_group("player")[0].arm:
			for item2 in get_tree().get_nodes_in_group("player")[0].arm:
				print(get_tree().get_nodes_in_group("player")[0].arm[item2][0])
				if get_tree().get_nodes_in_group("player")[0].arm[item][0] == nedded2 and get_tree().get_nodes_in_group("player")[0].arm[item][1] >= needed_number2 and get_tree().get_nodes_in_group("player")[0].arm[item2][0] == nedded1 and get_tree().get_nodes_in_group("player")[0].arm[item2][1] >= needed_number1:
					get_tree().get_nodes_in_group("player")[0].arm[item][1] -= needed_number2
					get_tree().get_nodes_in_group("player")[0].arm[item2][1] -= needed_number1
					if get_tree().get_nodes_in_group("player")[0].arm[item][1] == 0:
						get_tree().get_nodes_in_group("player")[0].arm.erase(item)
						var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
						inventory1.finder(item)
					if get_tree().get_nodes_in_group("player")[0].arm[item2][1] == 0:
						get_tree().get_nodes_in_group("player")[0].arm.erase(item2)
						var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
						inventory1.finder(item2)
					get_tree().get_nodes_in_group("player")[0].add_item(done, done_number)
					return
				elif  get_tree().get_nodes_in_group("player")[0].arm[item][0] == nedded2 and get_tree().get_nodes_in_group("player")[0].arm[item][1] >= needed_number2:
					for item3 in get_tree().get_nodes_in_group("player")[0].inventory:
						if get_tree().get_nodes_in_group("player")[0].inventory[item3][0] == nedded1 and get_tree().get_nodes_in_group("player")[0].inventory[item3][1] >= needed_number1:
							get_tree().get_nodes_in_group("player")[0].arm[item][1] -= needed_number2
							get_tree().get_nodes_in_group("player")[0].inventory[item3][1] -= needed_number1
							if get_tree().get_nodes_in_group("player")[0].arm[item][1] == 0:
								get_tree().get_nodes_in_group("player")[0].arm.erase(item)
								var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
								inventory1.finder(item)
							if get_tree().get_nodes_in_group("player")[0].inventory[item3][1] == 0:
								get_tree().get_nodes_in_group("player")[0].inventory.erase(item3)
								var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
								inventory1.finder1(item3)
							get_tree().get_nodes_in_group("player")[0].add_item(done, done_number)
							return
		for item in get_tree().get_nodes_in_group("player")[0].inventory:
			for item2 in get_tree().get_nodes_in_group("player")[0].inventory:
				if get_tree().get_nodes_in_group("player")[0].inventory[item][0] == nedded2 and get_tree().get_nodes_in_group("player")[0].inventory[item][1] >= needed_number2 and get_tree().get_nodes_in_group("player")[0].inventory[item2][0] == nedded1 and get_tree().get_nodes_in_group("player")[0].inventory[item2][1] >= needed_number1:
					get_tree().get_nodes_in_group("player")[0].inventory[item][1] -= needed_number2
					get_tree().get_nodes_in_group("player")[0].inventory[item2][1] -= needed_number1
					if get_tree().get_nodes_in_group("player")[0].inventory[item][1] == 0:
						get_tree().get_nodes_in_group("player")[0].inventory.erase(item)
						var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
						inventory1.finder1(item)
					if get_tree().get_nodes_in_group("player")[0].inventory[item2][1] == 0:
						get_tree().get_nodes_in_group("player")[0].inventory.erase(item2)
						var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
						inventory1.finder1(item2)
					get_tree().get_nodes_in_group("player")[0].add_item(done, done_number)
					return
				
