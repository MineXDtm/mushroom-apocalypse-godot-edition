extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var dir = Directory.new()
	dir.open("user://")
	dir.make_dir("accaunts")
	
func updatelist():
	for i in get_children():
		i.queue_free()
	var files = []
	var dir = Directory.new()
	dir.make_dir("user://accaunts/")
	dir.open("user://accaunts/")
	
	dir.list_dir_begin()
	
	for _i in range(0,99):
		var file1 = dir.get_next()
		if file1 == "":
			break
		elif not file1.begins_with("."):
			files.append(file1)
	print(files)
	var acc_file = load("res://menu/acc.tscn")
	for i in files:
		
		
		var acc_file_instance = acc_file.instance()
		var file = File.new()
		#var error = file.open(save_path, File.READ)
		var save_path5 = "user://accaunts/" + i
		var error = file.open_encrypted_with_pass(save_path5, File.READ, "P@paB3ar6969")
		var text = file.get_as_text()
		
		file.close()
		var save_data3 = parse_json(text)
		
		acc_file_instance.get_node("Button/CenterContainer/box/Label").text = save_data3["name"]
		acc_file_instance.id = save_data3["accountid"]
		acc_file_instance.token= save_data3["token"]
		var t =  acc_file_instance.get_node("Button/CenterContainer/box/CenterContainer/iconb/TextureRect").texture.duplicate(true)
		acc_file_instance.get_node("Button/CenterContainer/box/CenterContainer/iconb/TextureRect").texture = t
		#epic.gethead(save_data3["accountid"], save_data3["token"],acc_file_instance.get_node("Button/CenterContainer/box/CenterContainer/iconb/TextureRect").texture,0)
		add_child(acc_file_instance)
		
	var add_acc_file = load("res://menu/addaccount.tscn")
	var add_acc_file_instance = add_acc_file.instance()
	add_child(add_acc_file_instance)
func save(id,nick,token):
	
	
	var dir = Directory.new()
	var file = File.new()
	if !file.file_exists("user://accaunts/accaunt.json"):
		dir.open("user://accaunts/accaunt.json")
		var acc_data = {}
		acc_data["accountid"] = id
		acc_data["name"] = nick
		acc_data["token"] = token
		var acc_datas = acc_data.duplicate(true)
		
		#var error = file.open(save_path, File.WRITE)
		var error = file.open_encrypted_with_pass("user://accaunts/accaunt.json", File.WRITE, "P@paB3ar6969")
		if error == OK:
			file.store_line(to_json(acc_datas))
			file.close()
			acc_datas.clear()
	else:
		#var error = file.open(save_path, File.READ)
		var error = file.open_encrypted_with_pass("user://accaunts/accaunt.json", File.READ, "P@paB3ar6969")
		var text = file.get_as_text()
		file.close()
		var acc_data = parse_json(text)
		acc_data["accountid"] = id
		acc_data["name"] = nick
		acc_data["token"] = token
		var acc_datas = acc_data
		
		var file2 = File.new()
		#var error = file.open(save_path, File.WRITE)
		var error2 = file2.open_encrypted_with_pass("user://accaunts/accaunt.json", File.WRITE, "P@paB3ar6969")
		
		if error == OK:
			file2.store_line(to_json(acc_datas) )
			file2.close()
			acc_datas.clear()
