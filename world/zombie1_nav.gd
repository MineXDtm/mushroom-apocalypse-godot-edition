extends Navigation2D

var cords = [0]
var cords2 = [0]
var number = 0
var number2 = 0
var inplayer = false
var inblock = false
var playerrange = false
var rands
var fix = false
var ret = false
var distance_between_points
var last_point
var cooldown = false
var map_size = 1536
var needed = 0
var cooldown32 = 0
var added = 0
var check
var random_x = 16
var random_y = 16
var random_pos
var cooldown2 = 0
var num = 0
var indexes = {}
onready var astar = AStar2D.new()
var walk_zone = {}
func _ready():
	return
	while cooldown32 <= map_size:
		cooldown32 += 32
		needed += 1 
	for i in needed:
		added += 32
		cords.append(added)
		cords2.append(added)
	random_pos = Vector2( random_x,random_y)
	var o = 0;
	var id = 0
	for i in cords: 
		for ii in cords2:
			var navigationscene = load("res://world/NavigationPolygonInstance.tscn")
			var nav_instance = navigationscene.instance()
			nav_instance.position.x = ii
			nav_instance.position.y = cords[o]
			nav_instance.name = str("path" , id)
			id += 1
			add_child(nav_instance)
		o += 1
	
	for points in walk_zone:
		var point = walk_zone[points]
		var indexes = [Vector2(point.position.x + 32 ,point.position.y ),
					Vector2(point.position.x - 32 ,point.position.y ),
					Vector2(point.position.x ,point.position.y + 32 ),
					Vector2(point.position.x ,point.position.y - 32)]
		for point_relative in indexes:
			if not walk_zone.has(point_relative):
				continue
			if not astar.has_point(int(point_relative.x + point_relative.y) + int(walk_zone[point_relative].name)):
				continue
				
			
			# Note the 3rd argument. It tells the astar_node that we want the
			# connection to be bilateral: from point A to B and B to A
			# If you set this value to false, it becomes a one-way path
			# As we loop through all points we can set it to false
			astar.connect_points(int(point_relative.x + point_relative.y) + int(walk_zone[point_relative].name),int((point.position.x) + (point.position.y) + int(point.name)), false)
			
