extends VBoxContainer
func _physics_process(_delta):
	if get_parent().get_parent().list == "1":
		visible = true
	else:
		visible = false
