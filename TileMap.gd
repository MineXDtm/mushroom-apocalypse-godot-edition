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
	if  get_tree().get_nodes_in_group("player")[0].fliped:
		tile = world_to_map( get_tree().get_nodes_in_group("player")[0].position- Vector2(32,0))
	else:
		tile = world_to_map( get_tree().get_nodes_in_group("player")[0].position+ Vector2(32,0))
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
	if visible == true: 
		if type == "block_beta" || type == "stone_block"|| type == "door":
			if Input.is_action_just_pressed("rotare")  :
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
		else:
			$Node2D/Sprite.position = Vector2(16,16)
			rotared = false
			rotare = "up"
