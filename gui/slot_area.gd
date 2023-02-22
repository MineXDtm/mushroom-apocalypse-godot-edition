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
	get_node("CenterContainer").remove_child(item)
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
	if get_tree().get_nodes_in_group("player")[0].inventory.size() > slot_index:
		putIntoSlot(data)
		get_tree().get_nodes_in_group("player")[0].add_item_to_empty_slot(data, self)
		get_parent().get_parent().holding_item = null
		get_parent().get_parent().select = false
	else:
		putIntoSlot(data)
		get_tree().get_nodes_in_group("player")[0].add_item_to_empty_slot(data, self)
		get_parent().get_parent().holding_item = null
		get_parent().get_parent().select = false
	moved = false
	moved_moved = false
func putIntoSlot(new_item):
	if new_item == null: return
	item = new_item
	get_node("CenterContainer").add_child(item)
	get_parent().get_parent().selected_name = name
	set('custom_styles/panel', selected_style)
	moved = false
	moved_moved = false
func initialize_item(item_name, item_quantity):
	if item == null:
		
		item = ItemClass.instance()
		get_node("CenterContainer").add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
		if tex == false:
			if mouse_entered == false:
				set('custom_styles/panel', default_style)
			else:
				set('custom_styles/panel', selected_style)
			tex = true




func _process(_delta):
	if mouse_entered == false and item != null:
		set('custom_styles/panel', default_style)
	elif item != null:
		set('custom_styles/panel', selected_style)
	if get_tree().get_nodes_in_group("player")[0].inventory.size() >= int(name):
		var item = get_tree().get_nodes_in_group("player")[0].inventory[ int(name)-1]
		if item != null:
			initialize_item(item[0],item[1])
	elif item != null:
		pickFromSlot()
var moved = false
var moved_moved = false
var block = false
var entered = false
func get_drag_data(position):
	if item == null: return
	
	get_parent().get_parent().selected_name = name
	get_parent().get_parent().holding_item = item
	get_parent().get_parent().selected = str("GridContainer/",name)
	get_tree().get_nodes_in_group("player")[0].inventory.erase(slot_index)
	tex = false
	if get_parent().get_parent().get_node("GridContainer/"+"slot"+str(int(name) + 1)).item != null and get_parent().get_parent().get_node("GridContainer/"+"slot"+str(int(name) + 2)).item == null:
		moved = true
		get_parent().get_parent().select = true 
	elif   get_parent().get_parent().get_node("GridContainer/"+"slot"+str(int(name) + 1)).item != null and get_parent().get_parent().get_node("GridContainer/"+"slot"+str(int(name)+ 2)).item != null:
		moved_moved = true
		moved = true
		get_parent().get_parent().select = true
	set('custom_styles/panel', null_style)
	get_node("CenterContainer").remove_child(get_parent().get_parent().holding_item)
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
	get_tree().get_nodes_in_group("player")[0].inventory.remove(int(name)-1)
	
	return data
func mause_entered():
		
		
		get_parent().get_parent().selected2 = name
		mouse_entered = true
		return
		if name == "slot12":
			return
		if get_parent().get_parent().holding_item != null and moved == false and item != null and get_parent().get_parent().select == false and get_parent().get_node("slot"+str(int(name) +1)).item == null:
			moved = true
			get_parent().get_parent().select = true 
			var item2 = item
			get_tree().get_nodes_in_group("player")[0].inventory.erase(slot_index)
			pickFromSlot()
			get_parent().get_node("slot"+str(int(name) +1)).putIntoSlot(item2)
			get_tree().get_nodes_in_group("player")[0].add_item_to_empty_slot(item2, get_parent().get_node("slot"+str(int(name) +1)))
		elif get_parent().get_parent().holding_item != null and moved == false and moved_moved == false and item != null and get_parent().get_parent().select == false:
			get_parent().get_node("slot"+str(int(name) +1)).move_()
			moved = true
			moved_moved = true
			get_parent().get_parent().select = true 
			var item2 = item
			get_tree().get_nodes_in_group("player")[0].inventory.erase(slot_index)
			pickFromSlot()
			get_parent().get_node("slot"+str(int(name) +1)).putIntoSlot(item2)
			get_tree().get_nodes_in_group("player")[0].add_item_to_empty_slot(item2, get_parent().get_node("slot"+str(int(name) +1)))
func mause_exited():
		
		mouse_entered = false
		return
		if get_parent().get_parent().holding_item != null and moved == true and get_parent().get_parent().select == true  and get_parent().get_node("slot"+str(int(name) +2)).item == null :
			moved = false
			get_parent().get_parent().select = false 
			var item2 = get_parent().get_node("slot"+str(int(name) +1)).item
			get_tree().get_nodes_in_group("player")[0].inventory.erase(slot_index + 1)
			get_parent().get_node("slot"+str(int(name) +1)).pickFromSlot()
			putIntoSlot(item2)
			get_tree().get_nodes_in_group("player")[0].add_item_to_empty_slot(item2, self)
		elif get_parent().get_parent().holding_item != null and moved == true and moved_moved == true and get_parent().get_parent().select == true :
			moved = false
			moved_moved = false
			get_parent().get_parent().select = false 
			var item2 = get_parent().get_node("slot"+str(int(name) +1)).item
			get_tree().get_nodes_in_group("player")[0].inventory.erase(slot_index + 1)
			get_parent().get_node("slot"+str(int(name) +1)).pickFromSlot()
			putIntoSlot(item2)
			get_tree().get_nodes_in_group("player")[0].add_item_to_empty_slot(item2, self)
			get_parent().get_node("slot"+str(int(name) +1)).move_back()
func move_():
	if get_parent().get_node("slot"+str(int(name) +1)).item == null:
		moved = true
		moved_moved = true
		var item2 = item
		get_tree().get_nodes_in_group("player")[0].inventory.erase(slot_index)
		pickFromSlot()
		get_parent().get_node("slot"+str(int(name) +1)).putIntoSlot(item2)
		get_tree().get_nodes_in_group("player")[0].add_item_to_empty_slot(item2, get_parent().get_node("slot"+str(int(name) +1)))
	else:
		get_parent().get_node("slot"+str(int(name) +1)).move_()
		moved = true
		moved_moved = true
		var item2 = item
		get_tree().get_nodes_in_group("player")[0].inventory.erase(slot_index)
		pickFromSlot()
		get_parent().get_node("slot"+str(int(name) +1)).putIntoSlot(item2)
		get_tree().get_nodes_in_group("player")[0].add_item_to_empty_slot(item2, get_parent().get_node("slot"+str(int(name) +1)))
func move_back():
	if get_parent().get_node("slot"+str(int(name) +2)).item == null:
		var item2 = get_parent().get_node("slot"+str(int(name) +1)).item
		get_tree().get_nodes_in_group("player")[0].inventory.erase(slot_index + 1)
		get_parent().get_node("slot"+str(int(name) +1)).pickFromSlot()
		get_tree().get_nodes_in_group("player")[0].add_item_to_empty_slot(item2, self)
		putIntoSlot(item2)
	else:
		var item2 = get_parent().get_node("slot"+str(int(name) +1)).item
		get_tree().get_nodes_in_group("player")[0].inventory.erase(slot_index + 1)
		get_parent().get_node("slot"+str(int(name) +1)).pickFromSlot()
		putIntoSlot(item2)
		get_tree().get_nodes_in_group("player")[0].add_item_to_empty_slot(item2, self)
		get_parent().get_node("slot"+str(int(name) +1)).move_back()


