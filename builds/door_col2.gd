extends CollisionShape2D
func _process(_delta):
	if get_parent().get_parent().opened == false and get_parent().get_parent().rotare == "down":
		disabled = false
	elif get_parent().get_parent().rotare == "down":
		disabled = true
