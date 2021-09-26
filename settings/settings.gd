extends TextureRect
func _physics_process(_delta):
	if get_parent().get_parent().get_parent().list == "2":
		visible = true
	else:
		visible = false
var type = "off"

func _on_fullscreen_pressed():
	if type == "off":
		OS.window_fullscreen = true
		type = "on"
	else:
		OS.window_fullscreen = false
		type = "off"
