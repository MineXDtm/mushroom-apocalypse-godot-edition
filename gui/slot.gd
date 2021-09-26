extends Panel
var ItemClass = preload("res://gui/item.tscn")
var item = null
var default_tex = preload("res://textures/gui/slot_off.png")
var selected_tex = preload("res://textures/gui/slot_on.png")
var default_style: StyleBoxTexture = null
var selected_style: StyleBoxTexture = null
var slot_index


func _ready():
	default_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	selected_style.texture = selected_tex
func selcted():
	set('custom_styles/panel', selected_style)
func unselcted():
	set('custom_styles/panel', default_style)
func pickFromSlot():
	set('custom_styles/panel', default_style)
	remove_child(item)
	if name == "slot1":
		var inv = get_parent().get_parent().get_parent().get_node('items/inventory/GridContainer/'+ str(name))
		inv.pickFromSlot()
	elif name == "slot2":
		var inv = get_parent().get_parent().get_parent().get_node('items/inventory/GridContainer/'+ str(name))
		inv.pickFromSlot()
	elif name == "slot3":
		var inv = get_parent().get_parent().get_parent().get_node('items/inventory/GridContainer/'+ str(name))
		inv.pickFromSlot()
	item.position = Vector2(0, 0)
	item = null

func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	add_child(item)

func initialize_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instance()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
