extends Node






func add_item_to_empty_slot(item, slot):
	if slot.name == "slot1":
		inventory1[slot.slot_index] = [item.item_name, item.item_quantity]
	elif slot.name == "slot2":
		inventory1[slot.slot_index] = [item.item_name, item.item_quantity]
	elif slot.name == "slot3":
		inventory1[slot.slot_index] = [item.item_name, item.item_quantity]
	else:
		inventory[slot.slot_index] = [item.item_name, item.item_quantity]

func add_item_quantity(slot, quantity_to_add: int):
	inventory1[slot.slot_index][1] += quantity_to_add
