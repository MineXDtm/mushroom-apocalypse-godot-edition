extends Panel
var ItemClass = preload("res://gui/item.tscn")
var item = null
var default_style = load("res://gui/slot_defaultstyle.tres")
var selected_style = load("res://gui/slot_selectedstyle.tres")
var slot_index

func _ready():
	if name == "slot1":
		rect_min_size = Vector2(80,34)
		set('custom_styles/panel', selected_style)
func selcted():
	rect_min_size = Vector2(80,34)
	set('custom_styles/panel', selected_style)
func unselcted():
	rect_min_size = Vector2(60,34)
	set('custom_styles/panel', default_style)
func pickFromSlot():
	remove_child(item)
	item = null

func putIntoSlot(new_item):
	item = new_item
	item.rect_position = Vector2(0,0)
	add_child(item)
	
func initialize_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instance()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
