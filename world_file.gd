extends TextureButton
var directory
var name_world


func _on_world_file_pressed():
	get_parent().get_parent().get_parent().selected = name_world
func _physics_process(_delta):
	$image_box/icon.rect_size = $image_box.rect_size
