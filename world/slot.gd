extends Panel
var ItemClass = preload("res://gui/item.tscn")
var item = null
var default_tex = preload("res://textures/gui/slot_inv.png")
var selected_tex = preload("res://textures/gui/slot_inv_Selected.png")
var default_style: StyleBoxTexture = null
var selected_style: StyleBoxTexture = null
var slot_index


func _ready():
	default_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	selected_style.texture = selected_tex
	if name == "slot1":
		set('custom_styles/panel', selected_style)

func selcted():
	rect_scale = Vector2(1.1,1.1)
	set('custom_styles/panel', selected_style)
func unselcted():
	rect_scale =  Vector2(1,1)
	set('custom_styles/panel', default_style)
func pickFromSlot():
	remove_child(item)
	item = null

func putIntoSlot(new_item):
	item = new_item
	add_child(item)
	
func initialize_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instance()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
