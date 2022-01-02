extends Control




func _ready():
	SkinManager.connect("skinloaded",self,"skinloaded")
	for i in get_node("/root/menu/Viewport/playerview/model").get_children():
		if i.name == "shadow":continue
		i.texture.set_atlas(SkinManager.skin)
	yield(get_tree().create_timer(1),"timeout")
	get_node("Viewport/playerview/player").play("hello")
func skinloaded(skin):
	for i in get_node("/root/menu/Viewport/playerview/model").get_children():
		if i.name == "shadow":continue
		i.texture.set_atlas(skin)
	get_node("Viewport/playerview/player").play("newskin")
func _on_Button_pressed():
	get_tree().change_scene("res://menu.tscn")




