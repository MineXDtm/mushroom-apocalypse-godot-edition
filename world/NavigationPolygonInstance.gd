extends NavigationPolygonInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_navarea_area_entered(area):
	#if area.is_in_group("block") and area.rotare == "right":
	#	var world = get_parent()
	#	var drop_scene = load("res://world/NavigationPolygonInstance_right.tscn")
	#	var _drop_intance = drop_scene.instance()
	#	_drop_intance.position = position
	#	world.add_child(_drop_intance)
	#	_drop_intance.position = position
	#	get_parent().astar.remove_point(int(position.x + position.y + int(name)))
	#	get_parent().walk_zone.erase(position)
	#	queue_free()
	#elif area.is_in_group("block") and area.rotare == "left":
	#	var world = get_parent()
	#	var drop_scene = load("res://world/NavigationPolygonInstance_left.tscn")
	#	var _drop_intance = drop_scene.instance()
	#	_drop_intance.position = position
	#	world.add_child(_drop_intance)
	#	_drop_intance.position = position
	#	get_parent().astar.remove_point(int(position.x + position.y + int(name)))
	#	get_parent().walk_zone.erase(position)
	#	queue_free()
	if area.is_in_group("kust"):
		get_parent().astar.set_point_disabled(int(position.x + position.y + int(get_parent().indexes[Vector2(position.x, position.y)])) ,true)
		get_parent().walk_zone.erase(position)
		queue_free()
	elif area.is_in_group("door"):
		get_parent().astar.set_point_disabled(int(position.x + position.y + int(get_parent().indexes[Vector2(position.x, position.y)])) ,true)
		get_parent().walk_zone.erase(position)
		queue_free()
	if area.is_in_group("blocked"):
		get_parent().astar.set_point_disabled(int(position.x + position.y + int(get_parent().indexes[Vector2(position.x, position.y)])) ,true)
		get_parent().walk_zone.erase(position)
		queue_free()
	if area.is_in_group("kust_fruit"):
		get_parent().set_point_disabled(int(position.x + position.y + int(get_parent().indexes[Vector2(position.x, position.y)])) ,true)
		get_parent().walk_zone.erase(position)
		queue_free()
	if area.is_in_group("stone"):
		get_parent().astar.set_point_disabled(int(position.x + position.y + int(get_parent().indexes[Vector2(position.x, position.y)])) ,true)
		get_parent().walk_zone.erase(position)
		queue_free()
	if area.is_in_group("block"):
		get_parent().astar.set_point_disabled(int(position.x + position.y + int(get_parent().indexes[Vector2(position.x, position.y)])) ,true)
		get_parent().walk_zone.erase(position)
		print('deleted')
		queue_free()
	if area.is_in_group("area_car"):
		get_parent().astar.set_point_disabled(int(position.x + position.y + int(get_parent().indexes[Vector2(position.x, position.y)])) ,true)
		get_parent().walk_zone.erase(position)
		queue_free()
#	if area.is_in_group("zombie_dis"):
#		if get_parent().name != area.get_parent().get_parent().name:
#			$Timer.start()
#			enabled = false
func _ready():
	if added_by_gen == true:
		get_parent().astar.add_point(int(position.x + position.y + int(name)), Vector2(position.x, position.y))
		get_parent().walk_zone[Vector2(position.x, position.y)] = self
		get_parent().indexes[Vector2(position.x, position.y)] = name
		
		$navarea/CollisionShape2D.disabled = false
	else:
		get_parent().astar.set_point_disabled(int(position.x + position.y + int(get_parent().indexes[Vector2(position.x, position.y)])) ,false)
		get_parent().walk_zone[Vector2(position.x, position.y)] = self
		$navarea/CollisionShape2D.disabled = false
func _on_Timer_timeout():
	if enabled == false:
		enabled = true
var added_by_gen = true
