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
		world_file_instance.get_node("icon").texture = image_texture
		world_file_instance.get_node("icon/name").text = i
		world_file_instance.name = i
		world_file_instance.name_world = i
		world_file_instance.directory = save_path 
		var file = File.new()
		#var error = file.open(save_path, File.READ)
		var save_path5 = SAVE_DIR + i + "/world_data.json"
		var error = file.open_encrypted_with_pass(save_path5, File.READ, "P@paB3ar6969")
		var text = file.get_as_text()
		
		file.close()
		var save_data3 = parse_json(text)
		if save_data3 == null|| save_data3.has("creation_date") == false|| save_data3["creation_date"].size() == 0|| save_data3.has("last_join") == false || save_data3["last_join"].size() == 0:
			$VBoxContainer/HBoxContainer2/container/VBoxContainer.add_child(world_file_instance)
			continue
		world_file_instance.get_node("icon/date").text = str("%02d" % save_data3["creation_date"]["day"] ,".","%02d" % save_data3["creation_date"]["month"],".",save_data3["creation_date"]["year"] ,"\n", save_data3["creation_date"]["hour"],":","%02d" % save_data3["creation_date"]["minute"] )
		world_file_instance.get_node("icon/box1/box2/MarginContainer/VBoxContainer/last_join").text = str("Last Join: ","%02d" % save_data3["last_join"]["day"] ,".", "%02d" %save_data3["last_join"]["month"],".",save_data3["last_join"]["year"] ,"\n", save_data3["last_join"]["hour"],":","%02d" % save_data3["last_join"]["minute"] )
		$VBoxContainer/HBoxContainer2/container/VBoxContainer.add_child(world_file_instance)


func _on_create_pressed():
	$ColorRect.visible = true
	$ColorRect/mode_select.visible = true


func _on_join_pressed():
	if selected != null:
		var file = File.new()
		#var error = file.open(save_path, File.READ)
		var save_path5 = SAVE_DIR + selected + "/world_data.json"
		var error = file.open_encrypted_with_pass(save_path5, File.READ, "P@paB3ar6969")
		var text = file.get_as_text()
		
		file.close()
		var save_data3 = parse_json(text)
		if save_data3 == null|| save_data3.has("creation_date") == false|| save_data3["creation_date"].size() == 0|| save_data3.has("last_join") == false || save_data3["last_join"].size() == 0:
			WorldData.world_date_is_required = true
		
		WorldData.new = false
		WorldData.world_path = get_node(str("VBoxContainer/HBoxContainer2/container/VBoxContainer/",selected)).directory
		WorldData.world_name = get_node(str("VBoxContainer/HBoxContainer2/container/VBoxContainer/",selected,"/icon/name")).text
		get_tree().change_scene("res://world_run.tscn")


func _on_remove_pressed():
	if selected != null:
		dir_contents(str(SAVE_DIR,selected))
		get_node(str("VBoxContainer/HBoxContainer2/container/VBoxContainer/",selected)).queue_free()
		selected = null

func dir_contents(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				if not file_name.begins_with("."):
					dir_contents(str(path,"/",file_name))
			else:
				dir.remove(path+"/"+file_name)
			file_name = dir.get_next()
		dir.remove(path)
	else:
		print("An error occurred when trying to access the path.")
func _on_Button_pressed():
	WorldData.new = true
	if $ColorRect/write_name/bg/name_edit.text.empty():
		WorldData.world_name = "world"
	else:
		WorldData.world_name = $ColorRect/write_name/bg/name_edit.text
	get_tree().change_scene("res://world_run.tscn")


func _on_Sorvival_mode_pressed():
	$ColorRect/mode_select.visible = false
	$ColorRect/write_name.visible = true
