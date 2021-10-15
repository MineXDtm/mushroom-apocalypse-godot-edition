extends Camera2D
var mouse_start_pos
var screen_start_position
var dragging = false
var block = false
var block2 = false
func _input(event):
	if get_parent().get_parent().get_parent().get_parent().visible == true:
		current = true
		if Input.is_action_just_pressed("scrolling_down") and zoom.x != 2 :
			zoom.x += 0.5
			zoom.y += 0.5
		if Input.is_action_just_pressed("scrolling_up") and zoom.x != 0.5:
			zoom.x -= 0.5
			zoom.y -= 0.5
		if event is InputEventMagnifyGesture:
			zoom *= event.factor
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				mouse_start_pos = event.position
				screen_start_position = position
				dragging = true
				smoothing_enabled = false
			else:
				dragging = false
		elif event is InputEventMouseMotion and dragging and block == false and block2 == false:
			position = zoom * (mouse_start_pos - event.position) + screen_start_position
	else:
		current = false
