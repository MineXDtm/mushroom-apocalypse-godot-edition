extends Control

var holding_item = null
var selected = "slot1"
var selected_name = "slot1"
func _ready():
	initialize_inventory()
func _process(_delta):
	holding_item = get_node(selected).item
func initialize_inventory():
	var slots = get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory1.has(i):
			slots[i].initialize_item(PlayerInventory.inventory1[i][0], PlayerInventory.inventory1[i][1])
func select(slot):
	var slots = get_node(slot)
	slots.selcted()
	selected = str(slot)
	holding_item = get_node(selected).item
	selected_name = get_node(selected).name
	print("work")
func unselect(slot):
	var slots = get_node(slot)
	slots.unselcted()
func _input(event):
	if event.is_action_pressed("drop") and holding_item and get_parent().get_node("inventory").visible == false:
		var _selected_slot = get_node(selected)
		var world = get_parent().get_parent().get_node(str(WorldData.map,"/sort"))
		var player = get_parent().get_parent().get_node(str(WorldData.map,"/sort/player"))
		var drop_scene = load("res://world/drop/ItemDrop.tscn")
		var _drop_intance = drop_scene.instance()
		_drop_intance.item_name = holding_item.item_name
		_drop_intance.position = player.position
		world.add_child(_drop_intance)
		if holding_item.item_quantity > 1:
			holding_item.decrease_item_quantity(1)
			if selected_name == "slot1":
				PlayerInventory.inventory1[0][1] -= 1
			elif selected_name == "slot2":
				PlayerInventory.inventory1[1][1] -= 1
			elif selected_name == "slot3":
				PlayerInventory.inventory1[2][1] -= 1
		else:
			holding_item.item_quantity -= 1
			get_parent().get_parent().get_node(str("inventory/GridContainer2/",selected_name)).pickFromSlot()
			if selected_name == "slot1":
				PlayerInventory.inventory1.erase(0)
			elif selected_name == "slot2":
				PlayerInventory.inventory1.erase(1)
			elif selected_name == "slot3":
				PlayerInventory.inventory1.erase(2)
			holding_item = null
