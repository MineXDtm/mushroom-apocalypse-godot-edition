extends Panel
var ItemClass = preload("res://gui/item.tscn")
var item = null
var default_tex = preload("res://textures/gui/slot_off.png")
var null_tex = preload("res://textures/gui/slot_null.png")
var selected_tex = preload("res://textures/gui/slot_on.png")
var null_hand_tex = preload("res://textures/gui/slot_null_hand.png")
var default_style: StyleBoxTexture = null
var null_hand_style: StyleBoxTexture = null
var selected_style: StyleBoxTexture = null
var null_style: StyleBoxTexture = null
var slot_index
var tex = false
var mouse_entered = false
func _ready():
	connect("mouse_entered",self,"mause_entered")
	connect("mouse_exited",self,"mause_exited")
	default_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	null_style = StyleBoxTexture.new()
	null_hand_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	selected_style.texture = selected_tex
	null_style.texture = null_tex
	null_hand_style.texture = null_hand_tex
	default_style.region_rect.position.x = 5
	default_style.region_rect.position.y = 5
	default_style.region_rect.size.y = 22
	default_style.region_rect.size.x = 22
	selected_style.region_rect.position.x = 5
	selected_style.region_rect.position.y = 5
	selected_style.region_rect.size.y = 22
	selected_style.region_rect.size.x = 22
	null_hand_style.region_rect.position.x = 5
	null_hand_style.region_rect.position.y = 5
	null_hand_style.region_rect.size.y = 22
	null_hand_style.region_rect.size.x = 22
	null_style.region_rect.position.x = 5
	null_style.region_rect.position.y = 5
	null_style.region_rect.size.y = 22
	null_style.region_rect.size.x = 22
func selcted():
	set('custom_styles/panel', selected_style)
func unselcted():
	set('custom_styles/panel', default_style)
func pickFromSlot():
	tex = false
	set('custom_styles/panel', null_style)
	if name == "slot1":
		set('custom_styles/panel', null_hand_style)
	if name == "slot2":
		set('custom_styles/panel', null_hand_style)
	if name == "slot3":
		set('custom_styles/panel', null_hand_style)
	remove_child(item)
	if name == "slot1":
		var inv = get_parent().get_parent().get_parent().get_node('hand_slots/'+ str(name))
		inv.pickFromSlot()
	elif name == "slot2":
		var inv = get_parent().get_parent().get_parent().get_node('hand_slots/'+ str(name))
		inv.pickFromSlot()
	elif name == "slot3":
		var inv = get_parent().get_parent().get_parent().get_node('hand_slots/'+ str(name))
		inv.pickFromSlot()
	item = null
func can_drop_data(position, data):
	return true
func drop_data(position, data):
	if item != null:
		get_parent().get_parent().drop()
		moved = false
		moved_moved = false
		return
	var _selected_slot = get_parent().get_parent().get_node(get_parent().get_parent().selected)
	if PlayerInventory.inventory.has(slot_index) and name != "slot1"and name != "slot2"and name != "slot3":
		putIntoSlot(data)
		PlayerInventory.add_item_to_empty_slot(data, self)
		get_parent().get_parent().holding_item = null
		get_parent().get_parent().select = false
	elif name != "slot1" and name != "slot2" and name != "slot3":
		PlayerInventory.add_item(data.item_name,data.item_quantity)
		get_parent().get_parent().holding_item = null
		get_parent().get_parent().select = false
	else:
		putIntoSlot(data)
		PlayerInventory.add_item_to_empty_slot(data, self)
		get_parent().get_parent().holding_item = null
		get_parent().get_parent().select = false
	moved = false
	moved_moved = false
func putIntoSlot(new_item):
	if new_item == null: return
	if name == "slot1" || name == "slot2" || name == "slot3":
		var new = ItemClass.instance()
		new.set_item(new_item.item_name, 99)
		item = new
		add_child(new)
	else:
		item = new_item
		add_child(item)
	get_parent().get_parent().selected_name = name
	set('custom_styles/panel', selected_style)
	moved = false
	moved_moved = false
func initialize_item(item_name, item_quantity):
	if item == null:
		
		item = ItemClass.instance()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
		if tex == false:
			if mouse_entered == false:
				set('custom_styles/panel', default_style)
			else:
				set('custom_styles/panel', selected_style)
			tex = true




func _physics_process(_delta):
	if mouse_entered == false and item != null:
		set('custom_styles/panel', default_style)
	elif item != null:
		set('custom_styles/panel', selected_style)
var moved = false
var moved_moved = false
var block = false
var entered = false
func get_drag_data(position):
	if item == null: return
	get_parent().get_parent().selected_name = name
	get_parent().get_parent().holding_item = item
	if name == "slot1":
		get_parent().get_parent().selected = str("GridContainer2/",name)
	elif name == "slot2":
		get_parent().get_parent().selected = str("GridContainer2/",name)
	elif name == "slot3":
		get_parent().get_parent().selected = str("GridContainer2/",name)
	else:
		get_parent().get_parent().selected = str("GridContainer/",name)
	PlayerInventory.remove_item(self)
	tex = false
	if name != "slot1"and name != "slot2"and name != "slot3" and get_parent().get_parent().get_node("GridContainer/"+"slot"+str(int(name) + 1)).item != null and get_parent().get_parent().get_node("GridContainer/"+"slot"+str(int(name) + 2)).item == null:
		moved = true
		get_parent().get_parent().select = true 
	elif name != "slot1"and name != "slot2"and name != "slot3" and get_parent().get_parent().get_node("GridContainer/"+"slot"+str(int(name) + 1)).item != null and get_parent().get_parent().get_node("GridContainer/"+"slot"+str(int(name)+ 2)).item != null:
		moved_moved = true
		moved = true
		get_parent().get_parent().select = true
	set('custom_styles/panel', null_style)
	if name == "slot1":
		set('custom_styles/panel',null_hand_style)
	if name == "slot2":
		set('custom_styles/panel', null_hand_style)
	if name == "slot3":
		set('custom_styles/panel', null_hand_style)
	remove_child(get_parent().get_parent().holding_item)
	if name == "slot1":
		var inv = get_parent().get_parent().get_parent().get_node('hand_slots/'+ str(name))
		inv.pickFromSlot()
	elif name == "slot2":
		var inv = get_parent().get_parent().get_parent().get_node('hand_slots/'+ str(name))
		inv.pickFromSlot()
	elif name == "slot3":
		var inv = get_parent().get_parent().get_parent().get_node('hand_slots/'+ str(name))
		inv.pickFromSlot()
	var data = item
	item = null
	var slot_hand = load("res://gui/slot_hand.tscn")
	var slot_hand_s = slot_hand.instance()
	slot_hand_s.get_node("item/Label").text = str(get_parent().get_parent().holding_item.item_quantity)
	slot_hand_s.get_node("item").texture = load("res://textures/items/" + get_parent().get_parent().holding_item.item_name + ".png")
	var c = Control.new()
	c.add_child(slot_hand_s)
	slot_hand_s.rect_position = -0.5 * slot_hand_s.rect_size
	set_drag_preview(c)
	return data
func mause_entered():
		
		
		get_parent().get_parent().selected2 = name
		mouse_entered = true
		if name == "slot15":
			return
		if name == "slot1":
			return
		if name == "slot2":
			return
		if name == "slot3":
			return
		if get_parent().get_parent().holding_item != null and moved == false and item != null and get_parent().get_parent().select == false and get_parent().get_node("slot"+str(int(name) +1)).item == null:
			moved = true
			get_parent().get_parent().select = true 
			var item2 = item
			PlayerInventory.inventory.erase(slot_index)
			pickFromSlot()
			get_parent().get_node("slot"+str(int(name) +1)).putIntoSlot(item2)
			PlayerInventory.add_item_to_empty_slot(item2, get_parent().get_node("slot"+str(int(name) +1)))
		elif get_parent().get_parent().holding_item != null and moved == false and moved_moved == false and item != null and get_parent().get_parent().select == false:
			get_parent().get_node("slot"+str(int(name) +1)).move_()
			moved = true
			moved_moved = true
			get_parent().get_parent().select = true 
			var item2 = item
			PlayerInventory.inventory.erase(slot_index)
			pickFromSlot()
			get_parent().get_node("slot"+str(int(name) +1)).putIntoSlot(item2)
			PlayerInventory.add_item_to_empty_slot(item2, get_parent().get_node("slot"+str(int(name) +1)))
func mause_exited():
		mouse_entered = false
		if name == "slot1":
			return
		if name == "slot2":
			return
		if name == "slot3":
			return
		if get_parent().get_parent().holding_item != null and moved == true and get_parent().get_parent().select == true  and get_parent().get_node("slot"+str(int(name) +2)).item == null :
			moved = false
			get_parent().get_parent().select = false 
			var item2 = get_parent().get_node("slot"+str(int(name) +1)).item
			PlayerInventory.inventory.erase(slot_index + 1)
			get_parent().get_node("slot"+str(int(name) +1)).pickFromSlot()
			putIntoSlot(item2)
			PlayerInventory.add_item_to_empty_slot(item2, self)
		elif get_parent().get_parent().holding_item != null and moved == true and moved_moved == true and get_parent().get_parent().select == true :
			moved = false
			moved_moved = false
			get_parent().get_parent().select = false 
			var item2 = get_parent().get_node("slot"+str(int(name) +1)).item
			PlayerInventory.inventory.erase(slot_index + 1)
			get_parent().get_node("slot"+str(int(name) +1)).pickFromSlot()
			putIntoSlot(item2)
			PlayerInventory.add_item_to_empty_slot(item2, self)
			get_parent().get_node("slot"+str(int(name) +1)).move_back()
func move_():
	if get_parent().get_node("slot"+str(int(name) +1)).item == null:
		moved = true
		moved_moved = true
		var item2 = item
		PlayerInventory.inventory.erase(slot_index)
		pickFromSlot()
		get_parent().get_node("slot"+str(int(name) +1)).putIntoSlot(item2)
		PlayerInventory.add_item_to_empty_slot(item2, get_parent().get_node("slot"+str(int(name) +1)))
	else:
		get_parent().get_node("slot"+str(int(name) +1)).move_()
		moved = true
		moved_moved = true
		var item2 = item
		PlayerInventory.inventory.erase(slot_index)
		pickFromSlot()
		get_parent().get_node("slot"+str(int(name) +1)).putIntoSlot(item2)
		PlayerInventory.add_item_to_empty_slot(item2, get_parent().get_node("slot"+str(int(name) +1)))
func move_back():
	if get_parent().get_node("slot"+str(int(name) +2)).item == null:
		var item2 = get_parent().get_node("slot"+str(int(name) +1)).item
		PlayerInventory.inventory.erase(slot_index + 1)
		get_parent().get_node("slot"+str(int(name) +1)).pickFromSlot()
		PlayerInventory.add_item_to_empty_slot(item2, self)
		putIntoSlot(item2)
	else:
		var item2 = get_parent().get_node("slot"+str(int(name) +1)).item
		PlayerInventory.inventory.erase(slot_index + 1)
		get_parent().get_node("slot"+str(int(name) +1)).pickFromSlot()
		putIntoSlot(item2)
		PlayerInventory.add_item_to_empty_slot(item2, self)
		get_parent().get_node("slot"+str(int(name) +1)).move_back()


