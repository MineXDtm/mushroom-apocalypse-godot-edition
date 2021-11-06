extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(_delta):
	if get_parent().selected == 1:
		get_parent().get_node("instruments").visible = true
		disabled = true
	else:
		get_parent().get_node("instruments").visible = false
		disabled = false

func _on_menu_button_pressed():
	get_parent().selected = 1
