extends Control


func _physics_process(_delta):
	$bg.rect_size = rect_size
	

func _on_play_pressed():
	$menu_1.visible = false
	$worlds_list.visible = true


func _on_back_pressed():
	$menu_1.visible = true
	$worlds_list.visible = false



#token=eyJ0IjoiZXBpY19pZCIsImFsZyI6IlJTMjU2Iiwia2lkIjoibldVQzlxSFVldWRHcnBXb3FvVXVHZkFIYmVWM2NsRnlsdFRYMzhFbXJKSSJ9.eyJhdWQiOiJ4eXphNzg5MWxoeE1WWUdDT043TGduS1paOEhRR0Q1SCIsInN1YiI6Ijk2MjZmNDQxMDU1MzQ5Y2U4Y2I3ZDdkNWE0ODNlYWEyIiwidCI6ImVwaWNfaWQiLCJzY29wZSI6ImJhc2ljX3Byb2ZpbGUgZnJpZW5kc19saXN0IHByZXNlbmNlIiwiYXBwaWQiOiJmZ2hpNDU2N08wM0hST3hFandibjdrZ1hwQmhuaFd3diIsImlzcyI6Imh0dHBzOlwvXC9hcGkuZXBpY2dhbWVzLmRldlwvZXBpY1wvb2F1dGhcL3YxIiwiZG4iOiJLcm5icnkiLCJleHAiOjE1ODgyODYwODMsImlhdCI6MTU4ODI3ODg4Mywibm9uY2UiOiJuLUI1cGNsSXZaSkJaQU1KTDVsNkdvUnJDTzNiRT0iLCJqdGkiOiI2NGMzMGQwMjk4YTM0MzdjOGE3NGU1OTAxYzM0ODZiNSJ9.MZRoCRpjIb--dD7hxoo2GvjSPhUSNpOq1FhtShTBmzMJ1qlHFPzNaUiAEETAc3mabGPKyOxUP6Q1FBadr_P_UtbtB7kf34hN2VTv5czW6WOx1HdpjwUQZuxFyDc_aix7FCS0Egu4rZlC65b-B0FUVlial_s_FrH8ou5L_d-4I0KVpIwtv-b_M6EQ9jtLdQRfMaP6aV0rIerrbqFZ617Pe7XT4IO9jZFwM8F5aDTeDHkkOO41wyVibrm38799lP4B65RIv9CwbAL-TVmV1L5gFYITaZhi5ShfZzTvxAk-3Dxwp8c5JvcO68zpbya5gFSAfhsd7vt9YLU0gQR2uXq3Vw

func _ready():
	
	SkinManager.connect("skinloaded",self,"skinloaded")
	WorldData.world_date_is_required = false
	OS.set_use_vsync(false)
	#discord_rpc.icon = "icon"
	#discord_rpc.icon_desc = "Game Icon"
	#discord_rpc.small_icon = ""
	#discord_rpc.small_icon_desc = ""
	
	
	#if epic.logged():
	#	get_node("accountmenu").visible = false
	#	epic.setfriendlist()
	#	get_node("menu_1/VBoxContainer/MarginContainer/VBoxContainer/p/MarginContainer/HBoxContainer/CenterContainer/icon").texture.set_atlas(SkinManager.skin);
	#	get_node("menu_1/VBoxContainer/MarginContainer/VBoxContainer/p/MarginContainer/HBoxContainer/Nickname").text = epic.nickname
	#else:
	#	get_node("accountmenu").visible = true

func skinloaded(skin):
	get_node("menu_1/VBoxContainer/MarginContainer/VBoxContainer/p/MarginContainer/HBoxContainer/CenterContainer/icon").texture.set_atlas(skin);
func _on_settings_pressed():
	$game_menu.visible = true


func _on_exit_pressed():
	get_tree().quit()


func _on_customization_pressed():
	get_tree().change_scene("res://costumization_menu.tscn")
	


