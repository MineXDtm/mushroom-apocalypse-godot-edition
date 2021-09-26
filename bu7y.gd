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
		if PlayerInventory.inventory1[item][0] == "drop_wood" and PlayerInventory.inventory1[item][1] >= 2:
			PlayerInventory.inventory1[item][1] -= 2
			if PlayerInventory.inventory1[item][1] == 0:
				PlayerInventory.inventory1.erase(item)
				var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
				inventory1.finder(item)
			PlayerInventory.add_item("wooden_floor", 1)
			return
	for item in PlayerInventory.inventory:
		if PlayerInventory.inventory[item][0] == "drop_wood" and PlayerInventory.inventory[item][1] >= 2:
			PlayerInventory.inventory[item][1] -= 2
			if PlayerInventory.inventory[item][1] == 0:
				PlayerInventory.inventory.erase(item)
				var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
				inventory1.finder1(item)
			PlayerInventory.add_item("wooden_floor", 1)
			return
