extends CollisionShape2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _on_Timer_timeout():
	if WorldData.map != get_parent().get_parent().get_parent().get_parent().name:
		disabled = true
	elif get_parent().get_parent().isattacking == true   and get_parent().get_parent().get_parent().get_parent().get_node("sort/player").died == false:
		disabled = false
	else:
		disabled = true
