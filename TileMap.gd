extends TileMap
var rotare = "up"
var again
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var p
var tile
var checker = false
var type = "block_beta"
var empty = load("res://textures/build_player/" + type +"_true.png")
var empty_rotare = load("res://textures/build_player/" + type +"_rotare_true.png")
var full_rotare = load("res://textures/build_player/" + type +"_rotare_false.png")
var full  = load("res://textures/build_player/" + type +"_false.png")
var rotared = false
var pos = null
func _ready():
	$Node2D/Sprite.texture = empty
func _physics_process(_delta):
	tile = world_to_map(get_global_mouse_position())
	$Node2D.position = map_to_world(tile)
	if $Node2D/checker.is_colliding():
		if rotared == false:
			$Node2D/Sprite.texture = full
		else:
			$Node2D/Sprite.texture = full_rotare
		var p = get_parent().get_node_or_null(str(WorldData.map,"/sort/player"))
		if p != null:
			p.full = true
	else:
		if rotared == false:
			$Node2D/Sprite.texture = empty
		else:
			$Node2D/Sprite.texture = empty_rotare
		var p = get_parent().get_node_or_null(str(WorldData.map,"/sort/player"))
		if p != null:
			p.full = false
	if WorldData.map != "map" :
		$Node2D.position.x -= 2048
	if Input.is_action_just_pressed("rotare") and type == "block_beta" || Input.is_action_just_pressed("rotare") and type == "stone_block"|| Input.is_action_just_pressed("rotare") and type == "door" :
		if rotare == "up":
			$Node2D/Sprite.position = Vector2(33,24)
			rotared = true
			rotare = "right"
		elif rotare == "right":
			$Node2D/Sprite.position = Vector2(16,32)
			rotared = false
			rotare = "down"
		elif rotare == "down":
			$Node2D/Sprite.position = Vector2(16,25)
			rotared = true
			rotare = "left"
		elif rotare == "left":
			$Node2D/Sprite.position = Vector2(16,16)
			rotared = false
			rotare = "up"
	if Input.is_action_just_pressed("rotare") and name == "TileMap8":
		if rotare == "up":
			$Node2D/Sprite.play("rotare")
			$Node2D/Sprite.position = Vector2(33,24)
			rotare = "right"
		elif rotare == "right":
			$Node2D/Sprite.play("default")
			$Node2D/Sprite.position = Vector2(16,32)
			rotare = "down"
		elif rotare == "down":
			$Node2D/Sprite.play("rotare")
			$Node2D/Sprite.position = Vector2(16,25)
			rotare = "left"
		elif rotare == "left":
			$Node2D/Sprite.play("default")
			$Node2D/Sprite.position = Vector2(16,16)
			rotare = "up"
	if Input.is_action_just_pressed("rotare") and name == "TileMap5":
		if rotare == "up":
			$Node2D/Sprite.play("rotare")
			$Node2D/Sprite.flip_h = true
			rotare = "right"
		elif rotare == "right":
			$Node2D/Sprite.flip_h = false
			$Node2D/Sprite.play("default")
			$Node2D/Sprite.position = Vector2(16,38)
			rotare = "down"
		elif rotare == "down":
			$Node2D/Sprite.play("rotare")
			$Node2D/Sprite.position = Vector2(16,16)
			rotare = "left"
		elif rotare == "left":
			$Node2D/Sprite.play("default")
			$Node2D/Sprite.position = Vector2(16,16)
			rotare = "up"


