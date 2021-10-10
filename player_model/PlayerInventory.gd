extends Node

const SlotClass = preload("res://gui/slot_area.gd")
const ItemClass = preload("res://gui/Item.gd")
const NUM_INVENTORY_SLOTS = 12
const NUM_INVENTORY_SLOTS2 = 3

var inventory = {
	
}
var inventory1 = { 

}
func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add >= item_quantity:
				inventory[item][1] += item_quantity
				return
			else:
				inventory[item][1] += able_to_add
				item_quantity = item_quantity - able_to_add
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			return
	
func _ready():
	Console.add_command('add_item', self, 'add_item')\
			.set_description('god mode')\
			.add_argument('item', TYPE_STRING)\
			.add_argument('num', TYPE_INT)\
			.register()
func remove_item(slot: SlotClass):
	if slot.name == "slot1":
		inventory1.erase(slot.slot_index)
	elif slot.name == "slot2":
		inventory1.erase(slot.slot_index)
	elif slot.name == "slot3":
		inventory1.erase(slot.slot_index)
	else:
		inventory.erase(slot.slot_index)

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	if slot.name == "slot1":
		inventory1[slot.slot_index] = [item.item_name, item.item_quantity]
	elif slot.name == "slot2":
		inventory1[slot.slot_index] = [item.item_name, item.item_quantity]
	elif slot.name == "slot3":
		inventory1[slot.slot_index] = [item.item_name, item.item_quantity]
	else:
		inventory[slot.slot_index] = [item.item_name, item.item_quantity]

func add_item_quantity(slot: SlotClass, quantity_to_add: int):
	inventory1[slot.slot_index][1] += quantity_to_add
