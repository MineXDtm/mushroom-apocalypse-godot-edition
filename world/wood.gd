extends Area2D


func _on_wood_area_entered(area):
	if area.is_in_group("body"):
		get_parent().queue_free()
		queue_free()
	
	
