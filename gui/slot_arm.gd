extends Panel
var ItemClass = preload("res://gui/item.tscn")
var item = null
var default_tex = preload("res://textures/gui/slot_off.png")
var null_tex = preload("res://textures/gui/slot_null.png")
var selected_tex = preload("res://textures/gui/slot_on.png")
var null_hand_tex = preload("res://textures/gui/slot_null_hand.png")
var mouse_entered = false
var tex = false
var default_style: StyleBoxTexture = null
var null_hand_style: StyleBoxTexture = null
var selected_style: StyleBoxTexture = null
var null_style: StyleBoxTexture = null
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
func pickFromSlot():
	tex = false
	set('custom_styles/panel', null_hand_style)
	get_node("CenterContainer").remove_child(item)
	item = null
func _process(delta):
	if mouse_entered == false and item != null:
		set('custom_styles/panel', default_style)
	elif item != null:
		set('custom_styles/panel', selected_style)
	if get_tree().get_nodes_in_group("player")[0].arm.has(int(name)-1):
		var item = get_tree().get_nodes_in_group("player")[0].arm[ int(name)-1]
		if item != null:
			initialize_item(item[0],item[1])
	elif item != null:
		pickFromSlot()
func initialize_item(item_name, item_quantity):
	if item == null:
		
		item = ItemClass.instance()
		get_node("CenterContainer").add_child(item)
		item.rect_position = Vector2.ZERO
		item.set_item(item_name, item_quantity)
	else:
		
		item.set_item(item_name, item_quantity)
		if tex == false:
			if mouse_entered == false:
				set('custom_styles/panel', default_style)
			else:
				set('custom_styles/panel', selected_style)
			tex = true



func mause_entered():
		
		
		get_parent().get_parent().selected2 = name
		mouse_entered = true
		
func mause_exited():
		
		mouse_entered = false
		return
		
func drop_data(position, data):
	if item != null:
		get_parent().get_parent().drop()
		return
	var _selected_slot = get_parent().get_parent().get_node(get_parent().get_parent().selected)
	if not get_tree().get_nodes_in_group("player")[0].arm.has(int(name)-1):
		putIntoSlot(data)
		
		get_tree().get_nodes_in_group("player")[0].arm[int(name)-1] = [data.item_name,data.item_quantity]
		get_parent().get_parent().holding_item = null
		get_parent().get_parent().select = false
func putIntoSlot(new_item):
	if new_item == null: return
	item = new_item
	
	get_node("CenterContainer").add_child(item)
	
	set('custom_styles/panel', selected_style)
func get_drag_data(position):
	if item == null: return
	
	get_parent().get_parent().selected_name = name
	get_parent().get_parent().holding_item = item
	get_parent().get_parent().selected = str("GridContainer2/",name)
	tex = false
	
	set('custom_styles/panel', null_hand_style)
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
	get_tree().get_nodes_in_group("player")[0].arm.erase(int(name)-1)
	print(get_tree().get_nodes_in_group("player")[0].arm)
	return data
func can_drop_data(position, data):
	return true
