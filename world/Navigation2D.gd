extends Navigation2D

export(float) var character_speed = 40.0
var path = []
var cords = [0,32,64,96,128,160,192,224,256,288,320,352,384,416,448,480]
var cords2 = [16,48,80,112,144,176,208,240,272,304,336,368,400,432,464,496]
var speed = 40
var number = 0
var number2 = 0
var random_x = 16
var random_y = 16
var random_pos
var inplayer = false
var cooldown = 0
var end_pos
var inblock = false
var block_pos = null
var playerrange = false
var rands
var fix = false
var ret = false
func _process(delta):
	var walk_distance = character_speed * delta
	for i in Ganaretor.zombie:
		if Ganaretor.zombies.has(i):
			if cooldown == 10:
				get_node(Ganaretor.zombies[i][2]).standing = true
			move_along_path(walk_distance)
			_update_navigation_path(get_node(Ganaretor.zombies[i][2]).position, get_parent().get_node("car").position)
func _ready():
	random_pos = Vector2(random_x,random_y)
	var navigationscene = load("res://world/NavigationPolygonInstance.tscn")
	while number != 15:
		for i in range(0,16):
			var _world = get_parent()
			var navigation = navigationscene.instance()
			navigation.position.x = cords[i]
			navigation.position.y = cords[number]
			add_child(navigation)
		number += 1
func move_along_path(distance):
	for i in Ganaretor.zombie:
		if Ganaretor.zombies.has(i):
			if inplayer == false and inblock == false: 
				var last_point = get_node(Ganaretor.zombies[i][2]).position
				ret = false
				while path.size():
					var distance_between_points = last_point.distance_to(path[0])
					# The position to move to falls between two points.
					if distance <= distance_between_points:
						get_node(Ganaretor.zombies[i][2]).selected = get_parent().get_node("car").position.x
						if get_parent().get_node("car").position == end_pos:
							get_node(Ganaretor.zombies[i][2]).noplayerfinded = false
							get_node(Ganaretor.zombies[i][2] + "/body/CollisionShape2D").disabled = true
							block_pos = null
							playerrange = true
						elif get_parent().get_node("player").position == end_pos:
							get_node(Ganaretor.zombies[i][2]).noplayerfinded = false
							get_node(Ganaretor.zombies[i][2] + "/body/CollisionShape2D").disabled = true
							block_pos = null
							playerrange = true
						get_node(Ganaretor.zombies[i][2]).position = last_point.linear_interpolate(path[0], distance / distance_between_points)
						return
					# The position is past the end of the segment.
					if ret == false:
						distance -= distance_between_points
						last_point = path[0]
						path.remove(0)
						get_node(Ganaretor.zombies[i][2]).standing = true
				# The character reached the end of the path.
				get_node(Ganaretor.zombies[i][2]).position = last_point
				set_process(false)


func _update_navigation_path(start_position, end_position):
	for i in Ganaretor.zombie:
		if Ganaretor.zombies.has(i):
			if get_node(Ganaretor.zombies[i][2]).inplayer == false and get_node(Ganaretor.zombies[i][2]).inblock == false:
				# get_simple_path is part of the Navigation2D class.
				# It returns a PoolVector2Array of points that lead you
				# from the start_position to the end_position.
				path = get_simple_path(start_position, end_position, true)
				end_pos = end_position
				# The first point is always the start_position.
				# We don't need it in this example as it corresponds to the character's position.
				if (0 < path.size()):
					path.remove(0)
					get_node(Ganaretor.zombies[i][2]).standing = false
