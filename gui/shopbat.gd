extends TextureButton



func _on_shop_mouse_entered():
	set_as_toplevel(true)
	get_node("AnimationPlayer").play("shophover")
	get_node("AnimationPlayer2").play("shophover")


func _on_shop_mouse_exited():
	
	get_node("AnimationPlayer").play_backwards("shophover")
	get_node("AnimationPlayer2").play_backwards("shophover")
	yield(get_node("AnimationPlayer"),"animation_finished")
	set_as_toplevel(false)
