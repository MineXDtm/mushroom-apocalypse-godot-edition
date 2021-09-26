extends Node2D

func set_clock(time):
	if time == 0:
		get_node("CanvasLayer/clock").rect_position.x = -8
	else:
		get_node("CanvasLayer/clock").rect_position.x = -23 
func next_step():
	get_node("CanvasLayer/clock").rect_position.x -= 1
