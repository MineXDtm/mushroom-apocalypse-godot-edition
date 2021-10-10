extends TextureRect
var ItemClass = preload("res://gui/item.tscn")
var item = null
var default_tex = preload("res://textures/gui/slot_inv.png")
var selected_tex = preload("res://textures/gui/slot_inv_Selected.png")
var default_style: StyleBoxTexture = null
var selected_style: StyleBoxTexture = null
var slot_index


func _ready():
	if name == "slot1":
		texture = selected_tex
		rect_min_size = Vector2(50,50)
func selcted():
	rect_min_size = Vector2(50,50)
	texture = selected_tex
func unselcted():
	rect_min_size = Vector2(40,40)
	texture = default_tex
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
