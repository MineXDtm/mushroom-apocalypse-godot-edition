extends Control
const SAVE_DIR = "user://worlds/"
var selected
var save_path = SAVE_DIR
func _ready():
	var dir = Directory.new()
	dir.open("user://")
	dir.make_dir("worlds")
	dir.make_dir("screen_shot")
	var files = []
	dir.open(SAVE_DIR)
	dir.list_dir_begin()
	for _i in range(0,99):
		var file1 = dir.get_next()
		if file1 == "":
			break
		elif not file1.begins_with("."):
			files.append(file1)
	for i in files:
		var world_file = load("res://world_file.tscn")
		var world_file_instance = world_file.instance()
		save_path = SAVE_DIR + i
		var file1 = File.new()
		file1.open(SAVE_DIR + i + "/icon.png", File.READ)
		var buffer = file1.get_buffer(file1.get_len())
		var image = Image.new()
		image.load_png_from_buffer(buffer)
		var image_texture = ImageTexture.new()
		image_texture.create_from_image(image)
		world_file_instance.get_node("image_box/icon").texture = image_texture
		world_file_instance.get_node("name").text = i
		world_file_instance.name = i
		world_file_instance.name_world = i
		world_file_instance.directory = save_path 
		$container/VBoxContainer.add_child(world_file_instance)


func _on_create_pressed():
	$ColorRect.visible = true
	


func _on_join_pressed():
	if selected != null:
		WorldData.new = false
		WorldData.world_path = get_node(str("container/VBoxContainer/",selected)).directory
		WorldData.world_name = get_node(str("container/VBoxContainer/",selected,"/name")).text
		get_tree().change_scene("res://world_run.tscn")


func _on_remove_pressed():
	if selected != null:
		var dir = Directory.new()
		dir.remove(str(SAVE_DIR,selected,"/world/objects.json"))
		dir.remove(str(SAVE_DIR,selected,"/world/save_virables.json"))
		dir.remove(str(SAVE_DIR,selected,"/world"))
		dir.remove(str(SAVE_DIR,selected,"/icon.png"))
		dir.remove(str(SAVE_DIR,selected))
		get_node(str("container/VBoxContainer/",selected)).queue_free()
		selected = null
		


func _on_Button_pressed():
	WorldData.new = true
	if $ColorRect/gui/name_edit.text.empty():
		WorldData.world_name = "world"
	else:
		WorldData.world_name = $ColorRect/gui/name_edit.text
	get_tree().change_scene("res://world_run.tscn")
