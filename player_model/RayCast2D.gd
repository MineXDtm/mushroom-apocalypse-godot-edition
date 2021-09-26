extends RayCast2D

func _physics_process(delta):
	cast_to = global_position.direction_to(get_parent().get_parent().get_node("car").global_position) * 800.0
