extends Button
var directory
var name_world


func _on_world_file_pressed():
	get_parent().get_parent().get_parent().get_parent().get_parent().selected = name_world



func _on_world_file_mouse_entered():
	$AnimationPlayer.play("openinfo")


func _on_world_file_mouse_exited():
	$AnimationPlayer.play_backwards("openinfo")
