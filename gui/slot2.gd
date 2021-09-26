extends Panel
var ItemClass = preload("res://gui/item.tscn")
var item = null
var default_tex = preload("res://textures/gui/slot_off.png")
var null_tex = preload("res://textures/gui/slot_null.png")
var selected_tex = preload("res://textures/gui/slot_on.png")
var default_style: StyleBoxTexture = null
var selected_style: StyleBoxTexture = null
var null_style: StyleBoxTexture = null
var slot_index
var tex = false
var mouse_entered = false
func _ready():
	default_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	null_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	selected_style.texture = selected_tex
	null_style.texture = null_tex
	default_style.region_rect.position.x = 5
	default_style.region_rect.position.y = 5
	default_style.region_rect.size.y = 22
	default_style.region_rect.size.x = 22
	selected_style.region_rect.position.x = 5
	selected_style.region_rect.position.y = 5
	selected_style.region_rect.size.y = 22
	selected_style.region_rect.size.x = 22
func selcted():
	set('custom_styles/panel', selected_style)
func unselcted():
	set('custom_styles/panel', default_style)
func pickFromSlot():
	tex = false
	set('custom_styles/panel', null_style)
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
func _on_Area2D_area_entered(area):
	if area.is_in_group("cursor_zone"):
		get_parent().get_parent().selected2 = name
		mouse_entered = true
func _on_Area2D_area_exited(area):
	if area.is_in_group("cursor_zone"):
		mouse_entered = false
