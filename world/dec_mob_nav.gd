extends Navigation2D
var map_size_min = 0
var map_size_max = 1536
var num_dec_mobs = 0
var decs = ["butterfly"]
var has_decs = []
export var mob_dec: PackedScene
func spawn():
	var mob_dec_s = mob_dec.instance()
	random.randomize()
	mob_dec_s.position = Vector2(random.randi_range(map_size_min, map_size_max),random.randi_range(map_size_min, map_size_max))
	has_decs.append(mob_dec_s)
	random.randomize()
	var path = get_simple_path(mob_dec_s.position, Vector2(random.randi_range(map_size_min, map_size_max),random.randi_range(map_size_min, map_size_max)) , true)
	mob_dec_s.path = path
	add_child(mob_dec_s)

var random = RandomNumberGenerator.new()


func _on_dec_nav_update_timeout():
	for i in has_decs:
		random.randomize()
		var path = get_simple_path(i.position, Vector2(random.randi_range(map_size_min, map_size_max),random.randi_range(map_size_min, map_size_max)) , true)
		i.path = path
