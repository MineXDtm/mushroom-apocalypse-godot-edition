extends Area2D

const ACCELERATION = 460
const MAX_SPEED = 225
var velocity = Vector2.ZERO
var item_name
var type = "drop"
var player = null
var being_picked_up = false

func _ready():
	$wooden_exe.texture = load("res://textures/items/" + item_name + ".png")
	if item_name == "drop_wood":
		$wooden_exe.scale.x = 1.3
		$wooden_exe.scale.y = 1.3

func pick_up_item(body):
	player = body
	being_picked_up = true


func _on_ItemDrop_area_entered(area):
	if area.is_in_group("body") and area.is_in_group("player"):
		get_tree().get_nodes_in_group("player")[0].add_item(item_name, 1)
		queue_free()


func _on_VisibilityNotifier2D_viewport_entered(_viewport):
	visible = true


func _on_VisibilityNotifier2D_screen_exited():
	visible = false
