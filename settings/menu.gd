extends Control

onready var settings_but = "HBoxContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/settings_but"
var opened_settings = false
func _on_settings_but_pressed():
	if opened_settings == false:
		get_node("HBoxContainer/ScrollContainer").visible = true
		var new_style = load("res://settings/game_menu_selected.tres")
		get_node(settings_but).set('custom_styles/normal', new_style)
		get_node(settings_but).set('custom_styles/hover', new_style)
		opened_settings = true
	else:
		var new_style = load("res://settings/game_menu.tres")
		get_node(settings_but).set('custom_styles/normal', new_style)
		get_node(settings_but).set('custom_styles/hover', new_style)
		get_node("HBoxContainer/ScrollContainer").visible = false
		opened_settings = false

func _on_screen_size_item_selected(index):
	if index == 0:
		 OS.set_window_size(Vector2(1920, 1080))
	elif index == 1:
		OS.set_window_size(Vector2(640, 480))
	elif index == 2:
		 OS.set_window_size(Vector2(1280, 720))
	elif index == 3:
		 OS.set_window_size(Vector2(800, 600))


func _on_exit_button_down():
	get_parent().get_parent().get_parent().get_node("map").update_chunks()
	get_parent().get_parent().get_parent().get_node("map").save_virables()
	get_parent().get_parent().get_parent().get_node("map").save_chunksinlayer0()
	get_tree().change_scene("res://menu.tscn")
	
func _on_fullscreen_pressed():
	if OS.window_fullscreen == false:
		OS.window_fullscreen = true
		$HBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/Label.text = "on"
		$HBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer2/screen_size.disabled = true
	else:
		OS.window_fullscreen = false
		$HBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/Label.text = "off"
		$HBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer2/screen_size.disabled = false


func _on_fps_lock_item_selected(index):
	if index == 0:
		Engine.set_target_fps(60)
	elif index == 1:
		Engine.set_target_fps(120)
	elif index == 2:
		Engine.set_target_fps(180)
	elif index == 3:
		Engine.set_target_fps(30)
	elif index == 4:
		Engine.set_target_fps(300)
	elif index == 5:
		ProjectSettings.set("display/window/vsync/use_vsync", false)
		Engine.set_target_fps(0)
		OS.set_use_vsync(false)


func _on_shadow_mode_item_selected(index):
	if index == 0:
		gamesettings.shadow_mode = "low"
	elif index == 1:
		gamesettings.shadow_mode = "hight"
	gamesettings.change()
