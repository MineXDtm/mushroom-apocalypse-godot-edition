extends TileMap


var parent = null
func _physics_process(delta):
	var left = world_to_map(Vector2(parent.position.x - 32, parent.position.y))
	$checker1.position = map_to_world(left)
	var right = world_to_map(Vector2(parent.position.x + 32, parent.position.y))
	$checker3.position = map_to_world(right)
	var up = world_to_map(Vector2(parent.position.x, parent.position.y - 32))
	$checker4.position = map_to_world(up)
	var down = world_to_map(Vector2(parent.position.x, parent.position.y + 32))
	$checker2.position = map_to_world(down)
