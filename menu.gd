extends Control


func _physics_process(_delta):
	$bg.rect_size = rect_size
	

func _on_play_pressed():
	$menu_1.visible = false
	$worlds_list.visible = true


func _on_back_pressed():
	$menu_1.visible = true
	$worlds_list.visible = false




func _ready():
	SkinManager.connect("skinloaded",self,"skinloaded")
	WorldData.world_date_is_required = false
	OS.set_use_vsync(false)
	PlayerInventory.inventory = {}
	PlayerInventory.inventory1 = {}
	discord_rpc.icon = "icon"
	discord_rpc.icon_desc = "Game Icon"
	discord_rpc.small_icon = ""
	discord_rpc.small_icon_desc = ""
	
	
	if epic.logged():
		get_node("accountmenu").visible = false
		epic.setfriendlist()
		get_node("menu_1/VBoxContainer/MarginContainer/VBoxContainer/p/MarginContainer/HBoxContainer/CenterContainer/icon").texture.set_atlas(SkinManager.skin);
		get_node("menu_1/VBoxContainer/MarginContainer/VBoxContainer/p/MarginContainer/HBoxContainer/Nickname").text = epic.nickname
	else:
		get_node("accountmenu").visible = true

func skinloaded(skin):
	get_node("menu_1/VBoxContainer/MarginContainer/VBoxContainer/p/MarginContainer/HBoxContainer/CenterContainer/icon").texture.set_atlas(skin);
func _on_settings_pressed():
	$game_menu.visible = true


func _on_exit_pressed():
	get_tree().quit()


func _on_customization_pressed():
	get_tree().change_scene("res://costumization_menu.tscn")
	
