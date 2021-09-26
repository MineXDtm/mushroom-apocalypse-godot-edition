extends NavigationPolygonInstance


var index
var parent
var action
var first_path = "null"
var areas = {
	"area1":[false, "null", null],
	"area2":[false, "null", null],
	"area3":[false, "null", null],
	"area4":[false, "null", null],
}
onready var tile_t = get_parent().get_parent().get_node("TileMap")
func _on_navarea_area_entered(area):
	if area.is_in_group("block") and area.rotare == "right":
		var world = get_parent()
		var drop_scene = load("res://world/NavigationPolygonInstance_right.tscn")
		var _drop_intance = drop_scene.instance()
		_drop_intance.position = position
		world.add_child(_drop_intance)
		_drop_intance.position = position
		queue_free()
	elif area.is_in_group("block") and area.rotare == "left":
		var world = get_parent()
		var drop_scene = load("res://world/NavigationPolygonInstance_left.tscn")
		var _drop_intance = drop_scene.instance()
		_drop_intance.position = position
		world.add_child(_drop_intance)
		_drop_intance.position = position
		queue_free()
	#elif area.is_in_group("kust"):
	#	queue_free()
	#elif area.is_in_group("door"):
	#	if area.opened == true:
	#		enabled = true
	#	else:
	#		enabled = false
	#if area.is_in_group("blocked"):
	#	queue_free()
	#if area.is_in_group("kust_fruit"):
	#	queue_free()
	#if area.is_in_group("stone"):
	#	queue_free()
	#if area.is_in_group("block"):
	#	queue_free()
#	if area.is_in_group("zombie_dis"):
#		if get_parent().name != area.get_parent().get_parent().name:
#			$Timer.start()
#			enabled = false


func _on_Timer_timeout():
	if enabled == false:
		enabled = true


func _on_area1_area_entered(area):
	if area.is_in_group("nav"):
		if area.get_parent().parent == parent and area.get_parent().index == index - 1 and index != 1:
			areas["area1"] = [false, "nav",area ]
			$area1.queue_free()
func _on_area2_area_entered(area):
	if area.is_in_group("nav"):
		if area.get_parent().parent == parent and area.get_parent().index == index - 1 and index != 1:
			areas["area2"] = [false, "nav",area ]
			$area2.queue_free()
func _on_area3_area_entered(area):
	if area.is_in_group("nav"):
		if area.get_parent().parent == parent and area.get_parent().index == index - 1 and index != 1:
			areas["area3"] = [false, "nav",area ]
			$area3.queue_free()
func _on_area4_area_entered(area):
	if area.is_in_group("nav"):
		if area.get_parent().parent == parent and area.get_parent().index == index - 1 and index != 1:
			areas["area4"] = [false, "nav",area ]
			$area4.queue_free()
func _on_Timer2_timeout():
	var path = get_parent().get_parent().get_node("pathes/" + WorldData.playerInpath)
	if position.y < path.position.y :
		var nav = load("res://world/NavigationPolygonInstance_gen.tscn")
		var nav_s = nav.instance()
		var tile = tile_t.world_to_map(Vector2(position.x,position.y + 32))
		get_parent().get_parent().get_node("TileMap/Node2D").position = tile_t.map_to_world(tile)
		nav_s.position = get_parent().get_parent().get_node("TileMap/Node2D").position
		nav_s.parent = parent
		nav_s.index = index + 1
		get_parent().add_child(nav_s)
	elif position.y > path.position.y:
		var nav = load("res://world/NavigationPolygonInstance_gen.tscn")
		var nav_s = nav.instance()
		var tile = tile_t.world_to_map(Vector2(position.x,position.y - 32))
		get_parent().get_parent().get_node("TileMap/Node2D").position = tile_t.map_to_world(tile)
		nav_s.position = get_parent().get_parent().get_node("TileMap/Node2D").position
		nav_s.parent = parent
		nav_s.index = index + 1
		get_parent().add_child(nav_s)
	elif position.x < path.position.x:
		var nav = load("res://world/NavigationPolygonInstance_gen.tscn")
		var nav_s = nav.instance()
		var tile = tile_t.world_to_map(Vector2(position.x + 32,position.y))
		get_parent().get_parent().get_node("TileMap/Node2D").position = tile_t.map_to_world(tile)
		nav_s.position = get_parent().get_parent().get_node("TileMap/Node2D").position
		nav_s.parent = parent
		nav_s.index = index + 1
		get_parent().add_child(nav_s)
	elif position.x > path.position.x:
		var nav = load("res://world/NavigationPolygonInstance_gen.tscn")
		var nav_s = nav.instance()
		var tile = tile_t.world_to_map(Vector2(position.x - 32,position.y))
		get_parent().get_parent().get_node("TileMap/Node2D").position = tile_t.map_to_world(tile)
		nav_s.position = get_parent().get_parent().get_node("TileMap/Node2D").position
		nav_s.parent = parent
		nav_s.index = index + 1
		get_parent().add_child(nav_s)
	else:
		first_path = WorldData.playerInpath
		pathing = false
func _physics_process(delta):
	if WorldData.playerInpath != first_path and pathing == false:
		for i in areas:
			if areas[i][1] == "nav":
				if str(areas[i][2]) != "[Deleted Object]":
					if areas[i][2].get_parent().parent == parent and areas[i][2].get_parent().index == index - 1 and index != 1:
						areas[i][2].get_parent().redo()
						queue_free()
					elif index == 1:
						$Timer2.start()

var pathing = true
func redo():
	for i in areas:
		if areas[i][1] == "nav":
			if str(areas[i][2]) != "[Deleted Object]":
				if areas[i][2].get_parent().parent == parent and areas[i][2].get_parent().index == index - 1 and index != 1:
					areas[i][2].get_parent().redo()
					queue_free()
				elif index == 1:
					$Timer2.start()
