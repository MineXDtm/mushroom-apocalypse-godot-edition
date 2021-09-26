extends Control


func _physics_process(_delta):
	$bg.rect_size = rect_size
	

func _on_play_pressed():
	$menu_1.visible = false
	$worlds_list.visible = true


func _on_back_pressed():
	$menu_1.visible = true
	$worlds_list.visible = false


func _on_quit_pressed():
	get_tree().quit()

func _ready():
	PlayerInventory.inventory = {}
	PlayerInventory.inventory1 = {}
	discord_rpc.icon = "icon"
	discord_rpc.icon_desc = "Game Icon"
	discord_rpc.small_icon = ""
	discord_rpc.small_icon_desc = ""
