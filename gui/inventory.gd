extends Control

const SlotClass = preload('res://gui/slot_area.gd')
onready var inventory_slots = $GridContainer
onready var inventory_slots2 = $GridContainer2
var holding_item = null
var selected
var entered_mouse = false
const drop_script = preload('res://world/drop/drop_system.gd')
var selected_name
var slot_s
var selected2
var select = false
var select2 = false
func _ready():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].slot_index = i
	var slots2 = inventory_slots2.get_children()
	for i in range(slots2.size()):
		slots2[i].slot_index = i
	initialize_inventory()
func can_drop_data(position, data):
	return true
func drop_data(position, data):
	drop()
func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])
			
	var slots1 = inventory_slots2.get_children()
	for i in range(slots1.size()):
		if PlayerInventory.inventory1.has(i):
			slots1[i].initialize_item(PlayerInventory.inventory1[i][0], PlayerInventory.inventory1[i][1])
func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			if holding_item  == null:
				if slot.item:
					selected_name = slot.name
					left_click_not_holding(slot)
		elif event.button_index == BUTTON_LEFT and event.pressed == false:
			if $cursor_zone.is_colliding() == true:
				if holding_item  != null and selected2 != "slot1" and selected2 != "slot2" and selected2!= "slot3":
					get_parent().get_node("slot").queue_free()
					if !inventory_slots.get_node(selected2).item:
						left_click_empty_slot(inventory_slots.get_node(selected2))
					else:
						PlayerInventory.add_item(holding_item.item_name,holding_item.item_quantity)
						holding_item = null
						select = false
				elif holding_item  != null :
					
					get_parent().get_node("slot").queue_free()
					if !inventory_slots2.get_node(selected2).item:
						left_click_empty_slot(inventory_slots2.get_node(selected2))
					else:
						PlayerInventory.add_item(holding_item.item_name,holding_item.item_quantity)
						holding_item = null
						select = false
			else:
				drop()

func left_click_empty_slot(slot: SlotClass):
	var _selected_slot = get_node(selected)
	if PlayerInventory.inventory.has(slot.slot_index) and slot.name != "slot1"and slot.name != "slot2"and slot.name != "slot3":
		slot.putIntoSlot(holding_item)
		
		PlayerInventory.add_item_to_empty_slot(holding_item, slot)
		holding_item = null
		select = false
	elif slot.name != "slot1"and slot.name != "slot2"and slot.name != "slot3":
		PlayerInventory.add_item(holding_item.item_name,holding_item.item_quantity)
		holding_item = null
		select = false
	else:
		slot.putIntoSlot(holding_item)
		PlayerInventory.add_item_to_empty_slot(holding_item, slot)
		holding_item = null
		select = false
	slot.moved = false
	slot.moved_moved = false

func left_click_not_holding(slot: SlotClass):
	holding_item = slot.item
	
	if slot.name == "slot1":
		selected = str("GridContainer2/",slot.name)
	elif slot.name == "slot2":
		selected = str("GridContainer2/",slot.name)
	elif slot.name == "slot3":
		selected = str("GridContainer2/",slot.name)
	else:
		selected = str("GridContainer/",slot.name)
	PlayerInventory.remove_item(slot)
	slot.tex = false
	if slot.name != "slot1"and slot.name != "slot2"and slot.name != "slot3" and get_node("GridContainer/"+"slot"+str(int(slot.name) + 1)).item != null and get_node("GridContainer/"+"slot"+str(int(slot.name) + 2)).item == null:
		slot.moved = true
		select = true 
	elif slot.name != "slot1"and slot.name != "slot2"and slot.name != "slot3" and get_node("GridContainer/"+"slot"+str(int(slot.name) + 1)).item != null and get_node("GridContainer/"+"slot"+str(int(slot.name)+ 2)).item != null:
		slot.moved_moved = true
		slot.moved = true
		select = true
	slot.set('custom_styles/panel', slot.null_style)
	if slot.name == "slot1":
		slot.set('custom_styles/panel', slot.null_hand_style)
	if slot.name == "slot2":
		slot.set('custom_styles/panel', slot.null_hand_style)
	if slot.name == "slot3":
		slot.set('custom_styles/panel', slot.null_hand_style)
	slot.remove_child(holding_item)
	var slot_hand = load("res://gui/slot_hand.tscn")
	var slot_hand_s = slot_hand.instance()
	slot_hand_s.get_node("item/Label").text = str(holding_item.item_quantity)
	slot_hand_s.get_node("item").texture = load("res://textures/items/" + holding_item.item_name + ".png")
	get_parent().add_child(slot_hand_s)
	if slot.name == "slot1":
		var inv = get_parent().get_node('hand_slots/'+ str(slot.name))
		inv.pickFromSlot()
	elif slot.name == "slot2":
		var inv = get_parent().get_node('hand_slots/'+ str(slot.name))
		inv.pickFromSlot()
	elif slot.name == "slot3":
		var inv = get_parent().get_node('hand_slots/'+ str(slot.name))
		inv.pickFromSlot()
	slot.item.rect_position = Vector2(0, 0)
	slot.item = null
func drop_all():
	for i in PlayerInventory.NUM_INVENTORY_SLOTS2:
		if PlayerInventory.inventory1.has(i):
			for ii in int(PlayerInventory.inventory1[i][1]):
				var _selected_slot = get_tree().get_nodes_in_group('hand_slot')
				var world = get_parent().get_parent().get_node(WorldData.map)
				var player = get_parent().get_parent().get_node("map/sort/player")
				var drop_scene = load("res://world/drop/ItemDrop.tscn")
				var _drop_intance = drop_scene.instance()
				_drop_intance.item_name = PlayerInventory.inventory1[i][0]
				world.add_child(_drop_intance)
				_drop_intance.position = player.position
				PlayerInventory.inventory1[i][1] -= 1
				if PlayerInventory.inventory1[i][1] <= 0:
					for iii in _selected_slot.size():
						if _selected_slot[iii].name != "slot4" and _selected_slot[iii].name != "slot5"  and _selected_slot[iii].name != "slot6" and _selected_slot[iii].item != null:
							_selected_slot[iii].pickFromSlot()
							print('work')
							PlayerInventory.inventory1.erase(i)
	for i in PlayerInventory.NUM_INVENTORY_SLOTS:
		if PlayerInventory.inventory.has(i):
			
			for ii in int(PlayerInventory.inventory[i][1]):
				var _selected_slot = get_tree().get_nodes_in_group(str(i))
				var world = get_parent().get_parent().get_node(WorldData.map)
				var player = get_parent().get_parent().get_node(WorldData.map+"/sort/player")
				var drop_scene = load("res://world/drop/ItemDrop.tscn")
				var _drop_intance = drop_scene.instance()
				_drop_intance.item_name = PlayerInventory.inventory[i][0]
				_drop_intance.position = player.position
				world.add_child(_drop_intance)
				PlayerInventory.inventory[i][1] -= 1
				if PlayerInventory.inventory[i][1] <= 0:
					get_node(str("GridContainer/slot",i+4)).pickFromSlot()
					PlayerInventory.inventory.erase(i)
func drop():
	if holding_item and visible == true:
		for i in holding_item.item_quantity:
			var _selected_slot = get_node(selected)
			var world = get_parent().get_parent().get_node(str(WorldData.map))
			var player = get_parent().get_parent().get_node(str(WorldData.map,"/sort/player"))
			var drop_scene = load("res://world/drop/ItemDrop.tscn")
			var _drop_intance = drop_scene.instance()
			_drop_intance.item_name = holding_item.item_name
			world.add_child(_drop_intance)
			_drop_intance.position = player.position
			if holding_item.item_quantity == 1:
				holding_item = null
			else:
				holding_item.item_quantity -= 1
func place(slot):
	if slot == "slot1" :
		if $GridContainer2/slot1/item.item_quantity > 1:
			$GridContainer2/slot1/item.decrease_item_quantity(1)
			PlayerInventory.inventory1[0][1] -= 1
		else:
			$GridContainer2/slot1/item.item_quantity -= 1
			$GridContainer2/slot1.pickFromSlot()
			PlayerInventory.inventory1.erase(0)
		
	if slot == "slot2" :
		if $GridContainer2/slot2/item.item_quantity > 1:
			$GridContainer2/slot2/item.decrease_item_quantity(1)
			PlayerInventory.inventory1[1][1] -= 1
		else:
			$GridContainer2/slot2/item.item_quantity -= 1
			$GridContainer2/slot2.pickFromSlot()
			PlayerInventory.inventory1.erase(1)
	if slot == "slot3" :
		if $GridContainer2/slot3/item.item_quantity > 1:
			$GridContainer2/slot3/item.decrease_item_quantity(1)
			PlayerInventory.inventory1[2][1] -= 1
		else:
			$GridContainer2/slot3/item.item_quantity -= 1
			$GridContainer2/slot3.pickFromSlot()
			PlayerInventory.inventory1.erase(2)
func finder(slotnumber):
		for slot in range(1,4):
			if inventory_slots2.get_node("slot" + str(slot)).slot_index == slotnumber:
				var slotr = inventory_slots2.get_node("slot" + str(slot))
				slotr.pickFromSlot()
func finder1(slotnumber):
		for slot in range(4,16):
			if inventory_slots.get_node("slot" + str(slot)).slot_index == slotnumber:
				var slotr = inventory_slots.get_node("slot" + str(slot))
				slotr.pickFromSlot()
func _physics_process(_delta):
	if holding_item:
		holding_item.rect_position = get_global_mouse_position()









func _on_Area2D_area_entered(area):
	select2 = true


func _on_Area2D_area_exited(area):
	select2 = false
