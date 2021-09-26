extends Area2D

func _on_apple_area_entered(area):
	if area.is_in_group("body"):
		queue_free()
	
