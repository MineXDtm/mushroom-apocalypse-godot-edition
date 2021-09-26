extends Node2D
var time = "day"
var cooldown = false
var random_x
var random_y
var map_size = 1536
var needed = 0
var cooldown32 = 0
var added = 0
var cords = [0]
var cords2 = [0]
var number = 0
var number2 = 0
var check
var chunks = 0
var types = {
	"forrest":{
		"structures":{
			"kust":100,
			"kust_fruit":50,
			"stone":100
			},
		"graund": "dirt"
	}
}
const SAVE_DIR = "user://worlds/"
const SAVE_DIR2 = "user://screen_shot/"
var save_path = SAVE_DIR + WorldData.world_name + "/world/objects.json"
var save_path3 = SAVE_DIR + WorldData.world_name + "/world/save_virables.json"
var save_path2 = SAVE_DIR + WorldData.world_name
var zombies = {
	
}
var save_data = {

}
var save_data2 = {

}
var object_data = {
	"name":[],
	"position_x":[],
	"position_y":[],
	"type":[]
}
var virables_data = {
	"timer":[],
	"time":[],
	"new2":[]
}
var zombie = 0

func _ready():
	Console.add_command('time', self, 'settime')\
			.set_description('setting time')\
			.add_argument('day/night', TYPE_STRING)\
			.register()
	Console.add_command('timelock', self, 'lock_time')\
			.set_description('locking time')\
			.add_argument('true/false', TYPE_BOOL)\
			.register()
	$time_move.wait_time = $time.wait_time / 15
	$time_move.start()
	if WorldData.new == true:
		for structure in types[WorldData.world_type]["structures"].keys():
			var enemyscene = load("res://world/"+ structure+".tscn")
			for _i in range(0,types[WorldData.world_type]["structures"][structure]):
				yield(get_tree().create_timer(0.01), "timeout")
				var enemy = enemyscene.instance()
				get_node("sort").add_child(enemy)
			pre_save()
	else:
		load_chunks()
		load_virables()
	discord_rpc.details = str("In World: " ,WorldData.world_name)
	discord_rpc.icon = "forrest"
	discord_rpc.icon_desc = "forrest"
	discord_rpc.small_icon = "icon"
	discord_rpc.small_icon_desc = "Game Icon"
	discord_rpc.UpdatePresence()
func _on_kust_spawn_timeout():
	if Ganaretor.kustes < 100 :
		var enemyscene = load("res://world/kust.tscn")
		for _i in range(0,1):
			Ganaretor.kustes += 1
			var enemy = enemyscene.instance()
			get_node("sort").add_child(enemy)
	
func lock_time(value = false):
	if value == true:
		$time.stop()
		$time_move.stop()
	else:
		$time_move.start()
		$time.start()
func settime(time_set = null):
	if time_set == "night" :
		$time_move.start()
		$time.start()
		time = "night"
		$CanvasModulate.color = Color(0.294118, 0.294118, 0.294118)
		get_parent().get_node("UI2/time/bg/ViewportContainer/Viewport/CLockBar").set_clock(1)
	elif time_set == "day":
		$time_move.stop()
		$time.stop()
		time = "day"
		get_parent().get_node("UI2/time/bg/ViewportContainer/Viewport/CLockBar").set_clock(0)
		$time.wait_time += 40
		$CanvasModulate.color = Color(1, 1, 1)
		$time_move.wait_time = $time.wait_time / 15
		$time.stop()
		$time_move.start()
	else:
		Console.write_line("[color=#ffff66][url=time day]day[/url][/color]/[color=#ffff66][url=time night]night[/url][/color]")
func _on_kust_fruit_spawn_timeout():
	if Ganaretor.fruit_kustes < 5 :
		var fruit = load("res://world/kust_fruit.tscn")
		for _i in range(0,1):
			var fruits = fruit.instance()
			Ganaretor.fruit_kustes += 1
			get_node("sort").add_child(fruits)



func _on_time_timeout():
	if time == "day" :
		time = "night"
		$CanvasModulate.color = Color(0.294118, 0.294118, 0.294118)
	else:
		$time_move.stop()
		$time.stop()
		time = "day"
		get_parent().get_node("UI2/time/bg/ViewportContainer/Viewport/CLockBar").set_clock(0)
		$time.wait_time += 40
		$CanvasModulate.color = Color(1, 1, 1)
		$time_move.wait_time = $time.wait_time / 15
		$time.stop()
		$time_move.start()


func _on_zombie_spawn_timeout():
	if zombie != 50:
		print(zombie)
		cooldown = false
		if time == "night" :
			var zombiee = load("res://world/zombie1.tscn")
			for _i in range(0,1):
				zombie += 1
				var zombiess = zombiee.instance()
				for i in zombie:
					if zombies.has(i) == false and cooldown == false:
						zombies[i] = [i,str("zombie",i),str("mob",i)]
						zombiess.name = str("mob",zombies[i][0])
						cooldown = true
				get_node("sort").add_child(zombiess)


func _on_time_move_timeout():
	get_parent().get_node("UI2/time/bg/ViewportContainer/Viewport/CLockBar").next_step()
#	get_parent().get_node("UI2/time/bg/ScrollContainer").scroll_horizontal += 1
func save_chunks():
	var world = $sort.get_children()
	save_path2 = SAVE_DIR + WorldData.world_name
	save_path = SAVE_DIR + WorldData.world_name + "/world/objects.json"
	var dir = Directory.new()
	dir.open(save_path2)
	dir.make_dir("world")
	for i in world.size():
		object_data["type"] = world[i].type
		if world[i].type == "drop":
			object_data["drop_name"] = world[i].item_name
		else:
			object_data["health"] = world[i].health
		object_data["name"] = world[i].name
		if world[i].type == "block":
			object_data["rotare"] = world[i].rotare
		if world[i].type == "stone_block":
			object_data["rotare"] = world[i].rotare
		if world[i].type == "kust_fruit_in_pot":
			object_data["level"] = world[i].level
		object_data["position_x"] = world[i].position.x
		object_data["position_y"] = world[i].position.y
		if world[i].type == "player":
			object_data["inventory"] = PlayerInventory.inventory
			object_data["inventory1"] = PlayerInventory.inventory1
		save_data[str("object",i)] = object_data.duplicate(true)
		if object_data.has("drop_name"):
			object_data.erase("drop_name")
		if object_data.has("rotare"):
			object_data.erase("rotare")
		if object_data.has("inventory1"):
			object_data.erase("inventory1")
		if object_data.has("inventory"):
			object_data.erase("inventory")
		if object_data.has("health"):
			object_data.erase("health")
	var file = File.new()
	#var error = file.open(save_path, File.WRITE)
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "P@paB3ar6969")
	if error == OK:
		file.store_line(to_json(save_data))
		file.close()
		save_data.clear()
func update_chunks():
	var world = $sort.get_children()
	save_path2 = SAVE_DIR + WorldData.world_name
	save_path = SAVE_DIR + WorldData.world_name + "/world/objects.json"
	var dir = Directory.new()
	dir.open(save_path2)
	dir.make_dir("world")
	for i in world.size():
		if world[i].type == "skip":
			continue
		object_data["type"] = world[i].type
		if world[i].type == "kust_fruit_in_pot":
			object_data["level"] = world[i].level
		object_data["name"] = world[i].name
		if world[i].type == "drop":
			object_data["drop_name"] = world[i].item_name
		elif world[i].type != "exit":
			object_data["health"] = world[i].health
		if world[i].type == "block":
			object_data["rotare"] = world[i].rotare
		if world[i].type == "stone_block":
			object_data["rotare"] = world[i].rotare
		object_data["position_x"] = world[i].position.x
		object_data["position_y"] = world[i].position.y
		if world[i].type == "player":
			object_data["inventory"] = PlayerInventory.inventory
			object_data["inventory1"] = PlayerInventory.inventory1
		save_data[str("object",i)] = object_data.duplicate(true)
		if object_data.has("drop_name"):
			object_data.erase("drop_name")
		if object_data.has("rotare"):
			object_data.erase("rotare")
		if object_data.has("inventory1"):
			object_data.erase("inventory1")
		if object_data.has("inventory"):
			object_data.erase("inventory")
		if object_data.has("health"):
			object_data.erase("health")
	var file = File.new()
	#var error = file.open(save_path, File.WRITE)
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "P@paB3ar6969")
	if error == OK:
		file.store_line(to_json(save_data))
		file.close()
		save_data.clear()
func load_chunks():
	var file = File.new()
	#var error = file.open(save_path, File.READ)
	save_path = WorldData.world_path + "/world/objects.json"
	var error = file.open_encrypted_with_pass(save_path, File.READ, "P@paB3ar6969")
	var text = file.get_as_text()
	file.close()
	save_data = parse_json(text)
	for i in save_data:
		if save_data[i]["type"] == "player" and WorldData.map == "map":
			for ii in save_data[i]["inventory"]:
				PlayerInventory.inventory[int(ii)] = [save_data[i]["inventory"][ii][0],int(save_data[i]["inventory"][ii][1])]
			for ii in save_data[i]["inventory1"]:
				PlayerInventory.inventory1[int(ii)] = [save_data[i]["inventory1"][ii][0],int(save_data[i]["inventory1"][ii][1])]
			get_node("sort/player").position.x = int(save_data[i]["position_x"])
			get_node("sort/player").position.y = int(save_data[i]["position_y"])
			get_node("sort/player").health = int(save_data[i]["health"])
			get_parent().get_node("UI2/bars/health/bg/bar_health").value = int(save_data[i]["health"])
		if save_data[i]["type"] == "car" and WorldData.map == "map":
			get_node("sort/car").position.x = int(save_data[i]["position_x"])
			get_node("sort/car").position.y = int(save_data[i]["position_y"])
			get_node("sort/car").health = int(save_data[i]["health"])
			get_parent().get_node("UI2/bars/car/bg/bar_health").value = int(save_data[i]["health"])
		if save_data[i]["type"] == "build_block":
			var enemyscene = load("res://builds/build_block.tscn")
			var enemy = enemyscene.instance()
			enemy.position.x = int(save_data[i]["position_x"])
			enemy.position.y = int(save_data[i]["position_y"])
			if enemy.health > int(save_data[i]["health"]):
				enemy.get_node("ProgressBar").visible = true
				enemy.get_node("ProgressBar").value = int(save_data[i]["health"])
			enemy.health = int(save_data[i]["health"])
			enemy.name = save_data[i]["name"]
			get_node("sort").add_child(enemy)
		if save_data[i]["type"] == "torch":
			var enemyscene = load("res://builds/torch.tscn")
			var enemy = enemyscene.instance()
			enemy.position.x = int(save_data[i]["position_x"])
			enemy.position.y = int(save_data[i]["position_y"])
			if enemy.health > int(save_data[i]["health"]):
				enemy.get_node("ProgressBar").visible = true
				enemy.get_node("ProgressBar").value = int(save_data[i]["health"])
			enemy.health = int(save_data[i]["health"])
			enemy.name = save_data[i]["name"]
			get_node("sort").add_child(enemy)
		if save_data[i]["type"] == "drop":
			var enemyscene = load("res://world/drop/ItemDrop.tscn")
			var enemy = enemyscene.instance()
			enemy.position.x = int(save_data[i]["position_x"])
			enemy.position.y = int(save_data[i]["position_y"])
			enemy.item_name = save_data[i]["drop_name"]
			enemy.name = save_data[i]["name"]
			get_node("sort").add_child(enemy)
		if save_data[i]["type"] == "block":
			var enemyscene = load("res://builds/block_beta.tscn")
			var enemy = enemyscene.instance()
			enemy.position.x = int(save_data[i]["position_x"])
			enemy.position.y = int(save_data[i]["position_y"])
			if enemy.health > int(save_data[i]["health"]):
				enemy.get_node("ProgressBar").visible = true
				enemy.get_node("ProgressBar").value = int(save_data[i]["health"])
			enemy.health = int(save_data[i]["health"])
			get_parent().get_node("TileMap").rotare = save_data[i]["rotare"]
			enemy.name = save_data[i]["name"]
			get_node("sort").add_child(enemy)
		if save_data[i]["type"] == "door":
			var enemyscene = load("res://builds/door.tscn")
			var enemy = enemyscene.instance()
			enemy.position.x = int(save_data[i]["position_x"])
			enemy.position.y = int(save_data[i]["position_y"])
			if enemy.health > int(save_data[i]["health"]):
				enemy.get_node("ProgressBar").visible = true
				enemy.get_node("ProgressBar").value = int(save_data[i]["health"])
			enemy.health = int(save_data[i]["health"])
			enemy.name = save_data[i]["name"]
			get_node("sort").add_child(enemy)
		if save_data[i]["type"] == "stone_block":
			var enemyscene = load("res://builds/stone_block.tscn")
			var enemy = enemyscene.instance()
			enemy.position.x = int(save_data[i]["position_x"])
			enemy.position.y = int(save_data[i]["position_y"])
			if enemy.health > int(save_data[i]["health"]):
				enemy.get_node("ProgressBar").visible = true
				enemy.get_node("ProgressBar").value = int(save_data[i]["health"])
			enemy.health = int(save_data[i]["health"])
			get_parent().get_node("TileMap").rotare = save_data[i]["rotare"]
			enemy.name = save_data[i]["name"]
			get_node("sort").add_child(enemy)
		if save_data[i]["type"] == "kust":
			var enemyscene = load("res://world/kust.tscn")
			Ganaretor.kustes += 1
			var enemy = enemyscene.instance()
			enemy.position.x = int(save_data[i]["position_x"])
			if enemy.health > int(save_data[i]["health"]):
				enemy.get_node("ProgressBar").visible = true
				enemy.get_node("ProgressBar").value = int(save_data[i]["health"])
			enemy.health = int(save_data[i]["health"])
			enemy.position.y = int(save_data[i]["position_y"])
			enemy.name = save_data[i]["name"]
			get_node("sort").add_child(enemy)
		if save_data[i]["type"] == "wooden_trap":
			var enemyscene = load("res://builds/wooden_trap.tscn")
			var enemy = enemyscene.instance()
			enemy.position.x = int(save_data[i]["position_x"])
			if enemy.health > int(save_data[i]["health"]):
				enemy.get_node("ProgressBar").visible = true
				enemy.get_node("ProgressBar").value = int(save_data[i]["health"])
			enemy.health = int(save_data[i]["health"])
			enemy.position.y = int(save_data[i]["position_y"])
			enemy.name = save_data[i]["name"]
			get_node("sort").add_child(enemy)
		if save_data[i]["type"] == "stone":
			var enemyscene = load("res://world/stone.tscn")
			var enemy = enemyscene.instance()
			enemy.position.x = int(save_data[i]["position_x"])
			enemy.position.y = int(save_data[i]["position_y"])
			if enemy.health > int(save_data[i]["health"]):
				enemy.get_node("ProgressBar").visible = true
				enemy.get_node("ProgressBar").value = int(save_data[i]["health"])
			enemy.health = int(save_data[i]["health"])
			enemy.name = save_data[i]["name"]
			get_node("sort").add_child(enemy)
		if save_data[i]["type"] == "kust_fruit":
			var enemyscene = load("res://world/kust_fruit.tscn")
			Ganaretor.fruit_kustes += 1
			var enemy = enemyscene.instance()
			enemy.position.x = int(save_data[i]["position_x"])
			enemy.position.y = int(save_data[i]["position_y"])
			if enemy.health > int(save_data[i]["health"]):
				enemy.get_node("ProgressBar").visible = true
				enemy.get_node("ProgressBar").value = int(save_data[i]["health"])
			enemy.health = int(save_data[i]["health"])
			enemy.name = save_data[i]["name"]
			get_node("sort").add_child(enemy)
	get_parent().get_node("TileMap").rotare = "up"

func save_virables():
	save_path2 = SAVE_DIR + WorldData.world_name
	save_path = SAVE_DIR + WorldData.world_name + "/world/objects.json"
	save_path3 = SAVE_DIR + WorldData.world_name + "/world/save_virables.json"
	var dir = Directory.new()
	dir.open(save_path2)
	dir.make_dir("world")
	virables_data["time"] = time
	virables_data["timer_max_time"] = $time.wait_time
	virables_data["new2"] = WorldData.new2
	save_data2 = virables_data.duplicate(true)
	var file = File.new()
	#var error = file.open(save_path, File.WRITE)
	var error = file.open_encrypted_with_pass(save_path3, File.WRITE, "P@paB3ar6969")
	if error == OK:
		file.store_line(to_json(save_data2))
		file.close()
		save_data2.clear()


func _on_save_timeout():
	update_chunks()
	save_virables()

func _on_screen_shot_icon_timeout():
	var img = get_tree().get_root().get_texture().get_data()
	img.flip_y()
	img.save_png(SAVE_DIR + WorldData.world_name + "/icon.png")


func screen_shot_save():
	var img = get_tree().get_root().get_texture().get_data()
	img.flip_y()
	img.save_png(SAVE_DIR + WorldData.world_name + "/icon.png")
	WorldData.new2 = false
func _on_new_screen_shot_timeout():
	if WorldData.new2 == true:
		var img = get_tree().get_root().get_texture().get_data()
		img.flip_y()
		img.save_png(SAVE_DIR + WorldData.world_name + "/icon.png")
		WorldData.new2 = false
func pre_save():
	if WorldData.new == true:
		var dir = Directory.new()
		dir.open("user://worlds")
		var file = File.new()
		var num = ""
		while file.file_exists(save_path):
			if str(num) == "":
				num = 2
			else:
				num += 1
			save_path = SAVE_DIR + str(WorldData.world_name,num) + "/world/objects.json"
		WorldData.world_name = str(WorldData.world_name,num)
		dir.make_dir(WorldData.world_name)
		save_chunks()
		save_virables()
		WorldData.new = false
func load_virables():
	var file = File.new()
	#var error = file.open(save_path, File.READ)
	save_path3 = SAVE_DIR + WorldData.world_name + "/world/save_virables.json"
	var error = file.open_encrypted_with_pass(save_path3, File.READ, "P@paB3ar6969")
	var text = file.get_as_text()
	file.close()
	save_data2 = parse_json(text)
	time = save_data2["time"]
	if time == "night":
		get_parent().get_node("UI2/time/bg/ViewportContainer/Viewport/CLockBar").set_clock(1)
		$CanvasModulate.color = Color(0.294118, 0.294118, 0.294118)
	$time.wait_time = save_data2["timer_max_time"]
	WorldData.new2 = save_data2["new2"]
	
	
