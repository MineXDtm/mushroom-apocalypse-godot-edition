extends VBoxContainer


func _on_play_mouse_entered():
	$play.set_v_size_flags(SIZE_FILL)
	$play.rect_min_size.y = $play.rect_size.y *1.5


func _on_play_mouse_exited():
	$play.set_v_size_flags(SIZE_EXPAND_FILL)
	$play.rect_min_size.y = 0

