extends TextureButton
var directory
var name_world


func _on_world_file_pressed():
	get_parent().get_parent().get_parent().get_parent().selected = name_world

