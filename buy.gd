extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_buy_pressed():
	for item in PlayerInventory.inventory1:
		print(PlayerInventory.inventory1[item][0])
		for item2 in PlayerInventory.inventory1:
			print(PlayerInventory.inventory1[item2][0])
			if PlayerInventory.inventory1[item][0] == "drop_wood" and PlayerInventory.inventory1[item][1] >= 1 and PlayerInventory.inventory1[item2][0] == "cobblestone" and PlayerInventory.inventory1[item2][1] >= 2:
				PlayerInventory.inventory1[item][1] -= 1
				PlayerInventory.inventory1[item2][1] -= 2
				if PlayerInventory.inventory1[item][1] == 0:
					PlayerInventory.inventory1.erase(item)
					var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
					inventory1.finder(item)
				if PlayerInventory.inventory1[item2][1] == 0:
					PlayerInventory.inventory1.erase(item2)
					var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
					inventory1.finder(item2)
				PlayerInventory.add_item("stone_pickaxe", 1)
				return
			elif  PlayerInventory.inventory1[item][0] == "drop_wood" and PlayerInventory.inventory1[item][1] >= 1:
				for item3 in PlayerInventory.inventory:
					if PlayerInventory.inventory[item3][0] == "cobblestone" and PlayerInventory.inventory[item3][1] >= 2:
						PlayerInventory.inventory1[item][1] -= 1
						PlayerInventory.inventory[item3][1] -= 2
						if PlayerInventory.inventory1[item][1] == 0:
							PlayerInventory.inventory1.erase(item)
							var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
							inventory1.finder(item)
						if PlayerInventory.inventory[item3][1] == 0:
							PlayerInventory.inventory.erase(item3)
							var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
							inventory1.finder1(item3)
						PlayerInventory.add_item("stone_pickaxe", 1)
						return
	for item in PlayerInventory.inventory:
		for item2 in PlayerInventory.inventory:
			if PlayerInventory.inventory[item][0] == "drop_wood" and PlayerInventory.inventory[item][1] >= 1 and PlayerInventory.inventory[item2][0] == "cobblestone" and PlayerInventory.inventory[item2][1] >= 2:
				PlayerInventory.inventory[item][1] -= 1
				PlayerInventory.inventory[item2][1] -= 2
				if PlayerInventory.inventory[item][1] == 0:
					PlayerInventory.inventory.erase(item)
					var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
					inventory1.finder1(item)
				if PlayerInventory.inventory[item2][1] == 0:
					PlayerInventory.inventory.erase(item2)
					var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
					inventory1.finder1(item2)
				PlayerInventory.add_item("stone_pickaxe", 1)
				return
			
			

