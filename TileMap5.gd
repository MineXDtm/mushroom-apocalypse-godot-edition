extends TileMap
var rotare = "up"
var again
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tile
var checker = false
func _physics_process(_delta):
	tile = world_to_map(get_global_mouse_position())
	$Node2D.position = map_to_world(tile)
	if WorldData.map != "map":
		$Node2D.position.x -= 2048

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass







func _on_Node2D_area_entered(_area):
	if checker == false:
		if _area.name == "exit":
			$Node2D/Sprite.frame = 0
			get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).full2 = false
		elif _area.name == "exit2":
			$Node2D/Sprite.frame = 0
			get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).full2 = false
		elif _area.name == "exit3":
			$Node2D/Sprite.frame = 0
			get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).full2 = false
		elif _area.name == "exit4":
			$Node2D/Sprite.frame = 0
			get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).full2 = false
		elif _area.name == "exit5":
			$Node2D/Sprite.frame = 0
			get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).full2 = false
		elif _area.name == "exit6":
			$Node2D/Sprite.frame = 0
			get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).full2 = false
		elif _area.name == "exit7":
			$Node2D/Sprite.frame = 0
			get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).full2 = false
		elif _area.name == "exit8":
			$Node2D/Sprite.frame = 0
			get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).full2 = false
		elif _area.name == "armsattack":
			$Node2D/Sprite.frame = 0
			get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).full2 = false
		elif _area.is_in_group("block"):
			$Node2D/Sprite.frame = 0
			get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).full2 = false
		elif _area.is_in_group("torch"):
			$Node2D/Sprite.frame = 0
			get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).full2 = false
		elif _area.name == "navarea":
			pass
		elif _area.is_in_group("door_area"):
			pass
		elif _area.is_in_group("door"):
			pass
		elif _area.is_in_group("car_area"):
			pass
		elif _area.is_in_group("zombie_dis"):
			pass
		elif _area.is_in_group("buildblock"):
			pass
		elif _area.is_in_group("block_area"):
			pass
		elif _area.is_in_group("zombie_area"):
			pass
		elif _area.is_in_group("zombie_arm"):
			pass
		elif _area.is_in_group("kust_fruit_build"):
			pass
		else:
			$Node2D/Sprite.frame = 1
			get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).full2 = true


