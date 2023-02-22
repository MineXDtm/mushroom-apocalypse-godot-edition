extends Area2D

const ACCELERATION = 460
const MAX_SPEED = 225
var velocity = Vector2.ZERO
var item_name
var count = 1
var type = "drop"
var player = null
var being_picked_up = false

func _ready():
	$tex.texture = load("res://textures/items/" + item_name + ".png")

func pick_up_item(body):
	player = body
	being_picked_up = true


func _on_ItemDrop_area_entered(area):
	if area.is_in_group("body") and area.get_parent().is_in_group("player"):
		get_tree().get_nodes_in_group("player")[0].add_item(item_name, count)
		queue_free()


func _on_VisibilityNotifier2D_viewport_entered(_viewport):
	visible = true


func _on_VisibilityNotifier2D_screen_exited():
	visible = false
