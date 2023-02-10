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
	for item in get_tree().get_nodes_in_group("player")[0].arm:
		if get_tree().get_nodes_in_group("player")[0].arm[item][0] == "drop_wood" and get_tree().get_nodes_in_group("player")[0].arm[item][1] >= 2:
			get_tree().get_nodes_in_group("player")[0].arm[item][1] -= 2
			if get_tree().get_nodes_in_group("player")[0].arm[item][1] == 0:
				get_tree().get_nodes_in_group("player")[0].arm.erase(item)
				var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
				inventory1.finder(item)
			get_tree().get_nodes_in_group("player")[0].add_item("wooden_floor", 1)
			return
	for item in get_tree().get_nodes_in_group("player")[0].inventory:
		if get_tree().get_nodes_in_group("player")[0].inventory[item][0] == "drop_wood" and get_tree().get_nodes_in_group("player")[0].inventory[item][1] >= 2:
			get_tree().get_nodes_in_group("player")[0].inventory[item][1] -= 2
			if get_tree().get_nodes_in_group("player")[0].inventory[item][1] == 0:
				get_tree().get_nodes_in_group("player")[0].inventory.erase(item)
				var inventory1 = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("inventory")
				inventory1.finder1(item)
			get_tree().get_nodes_in_group("player")[0].add_item("wooden_floor", 1)
			return
