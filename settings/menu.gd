extends TextureRect

func _physics_process(_delta):
	if get_parent().get_parent().get_parent().list == "1":
		visible = true
	else: 
		visible = false
	


func _on_settings_but_pressed():
	get_parent().get_parent().get_parent().list = "2"


func _on_settings_but_button_down():
	$but/settings_but/text_image.rect_position.y = 4


func _on_settings_but_button_up():
	$but/settings_but/text_image.rect_position.y = 3.333


func _on_exit_button_down():
	get_parent().get_parent().get_parent().get_parent().get_node("map").update_chunks()
	get_parent().get_parent().get_parent().get_parent().get_node("map").save_virables()
	get_tree().change_scene("res://menu.tscn")
