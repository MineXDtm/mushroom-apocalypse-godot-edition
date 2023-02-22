extends Node2D
var time = "day"
var cooldown = false
var number = 0
var evning_start_in = 25
var darknes_start_in = 10
var number2 = 0
var check
var chunks = 0
var build_memory_layer1={}
onready var load_menu = get_tree().get_root().get_node("world").get_node("UI2/loding_world")
var types = {
	"forrest":{
		"structures":{
			"kust":100,
			"kust_fruit":50,
			"stone":100
			},
		"decs":{
			"grass":{
				"caunt":[500,null,false],
				"day": {
					"random_properties":{
						"texture":[load("res://textures/grass.png"),load("res://textures/flowers.png"),load("res://textures/flowers2.png"),load("res://textures/small_stone.png")]
					},
				},
				"night": {
					"random_properties":{
						"texture":[load("res://textures/grass.png"),load("res://textures/flowers.png"),load("res://textures/flowers2.png"),load("res://textures/small_stone.png")]
					},
				},
				"layer": 0,
				"properties":[],
				"scene":load("res://world/decorashon.tscn")
			},
			"dec_mob":{
				#random count = false | null = max
				"caunt":[25,null,false],
				"day": {
					"random_properties":{
						"type":["blue_butterfly","red_butterfly"]
					},
				},
				"night": {
					"random_properties":{
						"type":["Firefly"]
					},
				},
				"layer": 2,
				"properties":[],
				"scene":load("res://world/Dec_mob.tscn")
			},
		},
		"graund": "dirt"
	},
	"desert":{
		"structures":{
			"bucket":100,
			},
		"decs":{

		},
		"graund": "sand"
	}
}
const SAVE_DIR = "user://worlds/"
const SAVE_DIR2 = "user://screen_shot/"
var save_path = SAVE_DIR + WorldData.world_name + "/"+WorldData.world_type+"/objects.json"
var save_path3 = SAVE_DIR + WorldData.world_name + "/save_virables.json"
var save_path2 = SAVE_DIR + WorldData.world_name
var save_path4 = SAVE_DIR + WorldData.world_name + "/players/player_beta.json"
var save_path6 = SAVE_DIR + WorldData.world_name + "/world_data.json"
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
var player_data = {

}
func _process(delta):
	var time_left = int($time.time_left)
	if evning_start_in == time_left :
		if time == "day":
			$CanvasModulate/AnimationPlayer.play("evening")
		else:
			$CanvasModulate/AnimationPlayer.play_backwards("night")

	if darknes_start_in  == time_left :
		if time == "day":
			$CanvasModulate/AnimationPlayer.play("darkens")
		else:
			$CanvasModulate/AnimationPlayer.play_backwards("darkens")
var rsl1 = RandomNumberGenerator.new()
var map_size = 50
func randomize_slot_layer1():
	rsl1.randomize()
	var x = ((rsl1.randi()%map_size)*32)
	var y = ((rsl1.randi()%map_size)*32)
	var try = 1
	while build_memory_layer1.has(Vector2(x,y)) and try!= 100:
		try+=1
		x=((rsl1.randi()%map_size)*32)
		y=((rsl1.randi()%map_size)*32)
	return Vector2(x,y)

func place_on_slot(position_: Vector2,Build):
	var fixedslotx = (int(position_.x)/32)*32
	var fixedsloty = (int(position_.y)/32)*32
	build_memory_layer1[Vector2(fixedslotx,fixedsloty)]=Build
func remove_from_slot(position_: Vector2,Build):
	var fixedslotx = (int(position_.x)/32)*32
	var fixedsloty = (int(position_.y)/32)*32
	if not build_memory_layer1.has(Vector2(fixedslotx,fixedsloty)) or build_memory_layer1.has(Vector2(fixedslotx,fixedsloty)) and build_memory_layer1[Vector2(fixedslotx,fixedsloty)] != Build:return
	build_memory_layer1.erase(Vector2(fixedslotx,fixedsloty))

func _ready():

	set_name("map")
	load_menu.visible = true
	Console.add_command('time', self, 'settime')\
			.set_description('setting time')\
			.add_argument('day/night', TYPE_STRING)\
			.register()
	Console.add_command('timelock', self, 'lock_time')\
			.set_description('locking time')\
			.add_argument('true/false', TYPE_BOOL)\
			.register()
	print(ProjectSettings.globalize_path("user://worlds"))
	var file = File.new()
	if not file.file_exists(save_path):
		WorldData.new = true
		WorldData.new2 = true
		var dir = Directory.new()
		dir.open("user://worlds")
		var num = ""
		while file.file_exists(save_path):
			if str(num) == "":
				num = 2
			else:
				num += 1
			save_path = SAVE_DIR + str(WorldData.world_name,num) + "/"+WorldData.world_type+"/objects.json"
		WorldData.world_name = str(WorldData.world_name,num)
		dir.make_dir(WorldData.world_name)
		for structure_val in types[WorldData.world_type]["structures"]:
			load_menu.get_node("ProgressBar").max_value += types[WorldData.world_type]["structures"][structure_val]
		var rand = RandomNumberGenerator.new()
		for structure in types[WorldData.world_type]["structures"].keys():
			var build_scene = load("res://world/"+ structure+".tscn")
			for _i in range(0,types[WorldData.world_type]["structures"][structure]):
				yield(get_tree().create_timer(0.01), "timeout")
				load_menu.get_node("ProgressBar").value += 1
				var build = build_scene.instance()
				var v = randomize_slot_layer1()
				place_on_slot(v,build)
				build.position = v + Vector2(16,16)
				get_node("sort").add_child(build)
		generate_decs()
		pre_save()
		save_date()
		WorldData.new = false
		WorldData.new2 = false
		load_menu.visible = false
		$new_screen_shot.start()
		$time.start()
		$time_move.wait_time = $time.wait_time / 15
		$time_move.start()

	else:

		WorldData.new = false
		WorldData.new2 = false

		load_menu.get_node("ProgressBar").max_value = 5
		load_menu.get_node("Label").text = "loading virables.."
		load_menu.get_node("ProgressBar").value += 1
		load_virables()
		if WorldData.world_date_is_required == true:
			save_date()
		else:
			update_date()
		yield(get_tree().create_timer(0.01), "timeout")
		yield(get_tree(), 'idle_frame')
		load_menu.get_node("Label").text = "loading chunks.."
		yield(get_tree().create_timer(0.01), "timeout")
		load_chunks()
		load_menu.get_node("Label").text = "loading player.."
		load_menu.get_node("ProgressBar").value += 1
		yield(get_tree().create_timer(0.01), "timeout")
		load_players()
		load_menu.get_node("ProgressBar").value += 1
		load_menu.get_node("Label").text = "loading car.."
		yield(get_tree().create_timer(0.01), "timeout")
		load_car()
		load_menu.get_node("ProgressBar").value += 1
		load_menu.get_node("Label").text = "loading layer0.."
		yield(get_tree().create_timer(0.01), "timeout")
		load_chunks_layer0()
		load_menu.get_node("ProgressBar").value += 1
		load_menu.visible = false


	get_node("b/Sprite").texture = load("res://textures/" + types[WorldData.world_type]["graund"]+".png")
	#discord_rpc.details = str("In World: "  + WorldData.world_name)
	#discord_rpc.icon = WorldData.world_type
	#discord_rpc.icon_desc =  WorldData.world_type
	#discord_rpc.small_icon = "icon"
	#discord_rpc.small_icon_desc = "Game Icon"
	#discord_rpc.UpdatePresence()

var random = RandomNumberGenerator.new()

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
	clear_decs()
	if time_set == "night" :
		$time_move.start()
		$time.start()
		time = "night"
		$CanvasModulate/AnimationPlayer.play("night")
		get_parent().get_node("UI2/bg/ViewportContainer/Viewport/CLockBar").set_clock(1)
	elif time_set == "day":
		$time_move.stop()
		$time.stop()
		time = "day"
		get_parent().get_node("UI2/bg/ViewportContainer/Viewport/CLockBar").set_clock(0)
		$time.wait_time += 40
		evning_start_in += 25
		darknes_start_in += 10
		$CanvasModulate/AnimationPlayer.play_backwards("evening")
		$time_move.wait_time = $time.wait_time / 15
		$time.start()
		$time_move.start()
	else:
		Console.write_line("[color=#ffff66][url=time day]day[/url][/color]/[color=#ffff66][url=time night]night[/url][/color]")
	generate_decs()
func _on_kust_fruit_spawn_timeout():
	if Ganaretor.fruit_kustes < 5 :
		var fruit = load("res://world/kust_fruit.tscn")
		for _i in range(0,1):
			var fruits = fruit.instance()
			Ganaretor.fruit_kustes += 1
			get_node("sort").add_child(fruits)

func generate_decs():
	for _i in types[WorldData.world_type]["decs"]:

			#types[WorldData.world_type]["decs"][_i]
			if types[WorldData.world_type]["decs"][_i]["caunt"][2] == false:
				for i in types[WorldData.world_type]["decs"][_i]["caunt"][0]:
					var dec = types[WorldData.world_type]["decs"][_i]["scene"].instance()

					for ii in types[WorldData.world_type]["decs"][_i][time]["random_properties"]:
						randomize()

						dec.set(ii, types[WorldData.world_type]["decs"][_i][time]["random_properties"][ii][randi() % types[WorldData.world_type]["decs"][_i][time]["random_properties"][ii].size()])
					var random_pos = Vector2(random.randi_range(0, 1536),random.randi_range(0, 1536))
					dec.position = random_pos

					if types[WorldData.world_type]["decs"][_i]["layer"] == 2:
						get_node("layer2").add_child(dec)
					elif types[WorldData.world_type]["decs"][_i]["layer"] == 0:
						get_node("b/decorations").add_child(dec)
func clear_decs():
	var decs = get_tree().get_nodes_in_group("decoration")

	for i in decs:
		i.queue_free()
func _on_time_timeout():

	if time == "day" :
		time = "night"
		get_node("/root/world/UI2/bg/ViewportContainer/Viewport/CLockBar").set_clock(1)
		$CanvasModulate/AnimationPlayer.play("night")

	else:
		$time_move.stop()
		$time.stop()
		time = "day"
		get_parent().get_node("UI2/bg/ViewportContainer/Viewport/CLockBar").set_clock(0)
		$time.wait_time += 40
		$CanvasModulate/AnimationPlayer.play_backwards("evening")
		$time_move.wait_time = $time.wait_time / 15
		$time.start()
		$time_move.start()
	clear_decs()
	generate_decs()


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

func change_biome():
	get_node("b/Sprite").texture = load("res://textures/" + types[WorldData.world_type]["graund"]+".png")
	get_node("zombies").reloaddec()
	load_menu.visible = true
	load_menu.get_node("ProgressBar").value = 0
	load_menu.get_node("ProgressBar").max_value = 0
	for n in get_node("sort").get_children():
		if n.type == "player" || n.type == "car":
			continue
		n.queue_free()
	for n in get_node("b/builds").get_children():
		n.queue_free()
	var file = File.new()
	save_path = SAVE_DIR + WorldData.world_name + "/"+WorldData.world_type+"/objects.json"
	if not file.file_exists(save_path):
		WorldData.new = true
		WorldData.new2 = true
		for structure_val in types[WorldData.world_type]["structures"]:
			load_menu.get_node("ProgressBar").max_value += types[WorldData.world_type]["structures"][structure_val]
		for structure in types[WorldData.world_type]["structures"].keys():
			var enemyscene = load("res://world/"+ structure+".tscn")
			for _i in range(0,types[WorldData.world_type]["structures"][structure]):
				yield(get_tree().create_timer(0.01), "timeout")
				load_menu.get_node("ProgressBar").value += 1
				var enemy = enemyscene.instance()
				get_node("sort").add_child(enemy)
		pre_save()
		WorldData.new = false
		WorldData.new2 = false
		load_menu.visible = false
		$new_screen_shot.start()
	else:
		load_menu.get_node("Label").text = "loading chunks.."
		load_menu.get_node("ProgressBar").max_value = 4
		yield(get_tree().create_timer(0.01), "timeout")
		load_chunks()
		load_menu.get_node("Label").text = "loading player.."
		load_menu.get_node("ProgressBar").value += 1
		yield(get_tree().create_timer(0.01), "timeout")
		load_players()
		load_menu.get_node("ProgressBar").value += 1
		load_menu.get_node("Label").text = "loading car.."
		yield(get_tree().create_timer(0.01), "timeout")
		load_car()
		load_menu.get_node("ProgressBar").value += 1
		load_menu.get_node("Label").text = "loading layer0.."
		yield(get_tree().create_timer(0.01), "timeout")
		load_chunks_layer0()
		load_menu.get_node("ProgressBar").value += 1
		load_menu.visible = false

	#discord_rpc.details = str("In World: " ,WorldData.world_name)
	#discord_rpc.icon = WorldData.world_type
	#discord_rpc.icon_desc =  WorldData.world_type
	#discord_rpc.small_icon = "icon"
	#discord_rpc.small_icon_desc = "Game Icon"
	#discord_rpc.UpdatePresence()
func _on_time_move_timeout():
	get_node("/root/world/UI2/bg/ViewportContainer/Viewport/CLockBar").next_step()
#	get_parent().get_node("UI2/bg/ScrollContainer").scroll_horizontal += 1
func save_chunks():
	var world = $sort.get_children()
	save_path2 = SAVE_DIR + WorldData.world_name
	save_path = SAVE_DIR + WorldData.world_name + "/"+WorldData.world_type+"/objects.json"
	var dir = Directory.new()
	dir.open(save_path2)
	dir.make_dir(WorldData.world_type)
	for i in world.size():
		if world[i].type == "skip":
			continue
		if world[i].type == "player":
			save_player(world[i])
			continue
		if world[i].type == "car":
			save_car(world[i])
			continue
		object_data["type"] = world[i].type
		if world[i].type == "drop":
			object_data["drop_name"] = world[i].item_name
		elif world[i].get_node("healthsystem") !=null:
			object_data["health"] = world[i].get_node("healthsystem").health
		object_data["name"] = world[i].name
		if world[i].type == "block":
			object_data["rotare"] = world[i].rotare
		if world[i].type == "stone_block":
			object_data["rotare"] = world[i].rotare
		if world[i].type == "kust_fruit_in_pot":
			object_data["level"] = world[i].level
		object_data["position_x"] = world[i].position.x
		object_data["position_y"] = world[i].position.y
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
	save_path = SAVE_DIR + WorldData.world_name + "/"+WorldData.world_type+"/objects.json"
	var dir = Directory.new()
	dir.open(save_path2)
	dir.make_dir(WorldData.world_type)
	for i in world.size():
		if world[i].type == "player":
			save_player(world[i])
			continue
		if world[i].type == "car":
			save_car(world[i])
			continue
		if world[i].type == "skip":
			continue
		object_data["type"] = world[i].type
		if world[i].type == "kust_fruit_in_pot":
			object_data["level"] = world[i].level
		object_data["name"] = world[i].name
		if world[i].type == "drop":
			object_data["drop_name"] = world[i].item_name
		elif world[i].get_node("healthsystem") != null:
			object_data["health"] = world[i].get_node("healthsystem").health
		if world[i].type == "block":
			object_data["rotare"] = world[i].rotare
		if world[i].type == "stone_block":
			object_data["rotare"] = world[i].rotare
		object_data["position_x"] = world[i].position.x
		object_data["position_y"] = world[i].position.y
		if world[i].type == "player":
			object_data["inventory"] =world[i].inventory
			object_data["inventory1"] = world[i].arm
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
func save_chunksinlayer0():
	var world = get_node("b/builds").get_children()
	save_path2 = SAVE_DIR + WorldData.world_name
	var save_path_layer0 = SAVE_DIR + WorldData.world_name + "/"+WorldData.world_type+"/objects_layer0.json"
	var dir = Directory.new()
	dir.open(save_path2)
	var object_data_layer0 = {

	}
	var save_data_layer0 = {

	}
	dir.make_dir(WorldData.world_type)
	for i in world.size():
		object_data_layer0["position_x"] = world[i].position.x
		object_data_layer0["position_y"] = world[i].position.y
		object_data_layer0["type"] = world[i].type
		save_data_layer0[str("object",i)] = object_data_layer0.duplicate(true)
	var file = File.new()
	#var error = file.open(save_path, File.WRITE)
	var error = file.open_encrypted_with_pass(save_path_layer0, File.WRITE, "P@paB3ar6969")
	if error == OK:
		file.store_line(to_json(save_data_layer0))
		file.close()
		save_data.clear()
func load_time(time_left):
	clear_decs()
	generate_decs()
	$time_move.wait_time = $time.wait_time / 15
	$time_move.start()
	yield(get_tree().create_timer(time_left), "timeout")
	_on_time_timeout()
	$time.start()

func load_chunks_layer0():
	var file = File.new()
	var save_path_layer0 = SAVE_DIR + WorldData.world_name + "/"+WorldData.world_type+"/objects_layer0.json"
	#var error = file.open(save_path, File.READ)
	var error = file.open_encrypted_with_pass(save_path_layer0, File.READ, "P@paB3ar6969")
	var text = file.get_as_text()
	file.close()
	var save_data_layer0 = parse_json(text)
	for i in save_data_layer0:
		if save_data_layer0[i]["type"] == "wooden_floor":
			var enemyscene = load("res://builds/wooden_floor.tscn")
			var enemy = enemyscene.instance()
			enemy.position.x = int(save_data_layer0[i]["position_x"])
			enemy.position.y = int(save_data_layer0[i]["position_y"])
			get_node("b/builds").add_child(enemy)
		elif save_data_layer0[i]["type"] == "wooden_trap":
			var enemyscene = load("res://builds/wooden_trap.tscn")
			var enemy = enemyscene.instance()
			enemy.position.x = int(save_data_layer0[i]["position_x"])
			enemy.position.y = int(save_data_layer0[i]["position_y"])
			get_node("b/builds").add_child(enemy)
func load_chunks():
	var file = File.new()
	save_path = SAVE_DIR + WorldData.world_name + "/"+WorldData.world_type+"/objects.json"
	#var error = file.open(save_path, File.READ)
	var error = file.open_encrypted_with_pass(save_path, File.READ, "P@paB3ar6969")
	var text = file.get_as_text()
	file.close()
	save_data = parse_json(text)
	for i in save_data:
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
		if save_data[i]["type"] == "bucket":
			var enemyscene = load("res://world/bucket.tscn")
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
		if save_data[i]["type"] == "stove":
			var enemyscene = load("res://builds/stove.tscn")
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
			get_node("/root/world/TileMap").rotare = save_data[i]["rotare"]
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
	get_node("/root/world/TileMap").rotare = "up"

func save_virables():
	save_path2 = SAVE_DIR + WorldData.world_name
	save_path = SAVE_DIR + WorldData.world_name + "/"+WorldData.world_type+"/objects.json"
	save_path3 = SAVE_DIR + WorldData.world_name + "/save_virables.json"
	var dir = Directory.new()
	dir.open(save_path2)
	dir.make_dir(WorldData.world_type)
	virables_data["time"] = time
	virables_data["time_left"] = $time.time_left
	virables_data["timer_max_time"] = $time.wait_time
	virables_data["clock"] = get_parent().get_node("UI2/bg/ViewportContainer/Viewport/CLockBar").get_node("CanvasLayer/clock").rect_position.x
	virables_data["type"] =  WorldData.world_type
	virables_data["getted"] = get_parent().get_node("UI2/map/ViewportContainer/Viewport/map").getted
	virables_data["completed"] = get_parent().get_node("UI2/map/ViewportContainer/Viewport/map").completed
	save_data2 = virables_data.duplicate(true)
	var file = File.new()
	#var error = file.open(save_path, File.WRITE)
	var error = file.open_encrypted_with_pass(save_path3, File.WRITE, "P@paB3ar6969")
	if error == OK:
		file.store_line(to_json(save_data2))
		file.close()
		save_data2.clear()
var save_path5 = SAVE_DIR + WorldData.world_name + "/car.json"
func save_car(car):
	save_path5 = SAVE_DIR + WorldData.world_name + "/car.json"
	var dir = Directory.new()
	dir.open(save_path2)
	var car_data = {}
	car_data["health"] = car.health
	var save_data3 = car_data.duplicate(true)
	var file = File.new()
	#var error = file.open(save_path, File.WRITE)
	var error = file.open_encrypted_with_pass(save_path5, File.WRITE, "P@paB3ar6969")
	if error == OK:
		file.store_line(to_json(save_data3))
		file.close()
		save_data3.clear()
func save_date():
	save_path6 = SAVE_DIR + WorldData.world_name + "/world_data.json"
	var dir = Directory.new()
	dir.open(save_path2)
	var data = {}
	data["creation_date"] = OS.get_datetime()
	data["last_join"] = OS.get_datetime()
	data["mode"] = "sorvival_mode"
	var save_data3 = data.duplicate(true)
	var file = File.new()
	#var error = file.open(save_path, File.WRITE)
	var error = file.open_encrypted_with_pass(save_path6, File.WRITE, "P@paB3ar6969")
	if error == OK:
		file.store_line(to_json(save_data3))
		file.close()
		save_data3.clear()
func update_date():
	save_path6 = SAVE_DIR + WorldData.world_name + "/world_data.json"

	var file = File.new()
	#var error = file.open(save_path, File.READ)
	var error = file.open_encrypted_with_pass(save_path6, File.READ, "P@paB3ar6969")
	var text = file.get_as_text()
	file.close()
	var save_data3 = parse_json(text)
	save_data3["last_join"] = OS.get_datetime()
	var save_data4 = save_data3

	var file2 = File.new()
	#var error = file.open(save_path, File.WRITE)
	var error2 = file2.open_encrypted_with_pass(save_path6, File.WRITE, "P@paB3ar6969")

	if error == OK:
		file2.store_line(to_json(save_data4) )
		file2.close()
		save_data3.clear()
func _on_save_timeout():
	update_chunks()
	save_virables()
	save_chunksinlayer0()
	save_car(get_node("sort/car"))
	save_player(get_node("sort/player"))

func _on_screen_shot_icon_timeout():
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	img.save_png(SAVE_DIR + WorldData.world_name + "/icon.png")
func save_player(player):
	save_path4 = SAVE_DIR + WorldData.world_name + "/players/player_beta.json"
	var dir = Directory.new()
	dir.open(save_path2)
	dir.make_dir("players")
	player_data["position_x"] = player.position.x
	player_data["position_y"] = player.position.y
	player_data["inv"] = get_tree().get_nodes_in_group("player")[0].inventory
	player_data["inv1"] =  get_tree().get_nodes_in_group("player")[0].arm
	player_data["health"] = player.health
	var save_data3 = player_data.duplicate(true)
	var file = File.new()
	#var error = file.open(save_path, File.WRITE)
	var error = file.open_encrypted_with_pass(save_path4, File.WRITE, "P@paB3ar6969")
	if error == OK:
		file.store_line(to_json(save_data3))
		file.close()
		save_data3.clear()
func load_car():
	var file = File.new()
	#var error = file.open(save_path, File.READ)
	save_path5 = SAVE_DIR + WorldData.world_name + "/car.json"
	var error = file.open_encrypted_with_pass(save_path5, File.READ, "P@paB3ar6969")
	var text = file.get_as_text()
	file.close()
	var save_data3 = parse_json(text)
	get_node("sort/car").health = int(save_data3["health"])
	get_node("/root/world/UI2/bars/car/bg/bar_health").value = int(save_data3["health"])
func load_players():
	var file = File.new()
	#var error = file.open(save_path, File.READ)
	save_path4 = SAVE_DIR + WorldData.world_name + "/players/player_beta.json"
	var error = file.open_encrypted_with_pass(save_path4, File.READ, "P@paB3ar6969")
	var text = file.get_as_text()
	file.close()
	var save_data3 = parse_json(text)
	get_node("sort/player").position.x = int(save_data3["position_x"])
	get_node("sort/player").position.y = int(save_data3["position_y"])
	get_node("sort/player").health = int(save_data3["health"])
	get_node("/root/world/UI2/bars/health/bg/bar_health").value = int(save_data3["health"])
	for ii in range( save_data3["inv"].size()):
		 get_tree().get_nodes_in_group("player")[0].inventory.append([save_data3["inv"][ii][0],int(save_data3["inv"][ii][1])])
	for ii in save_data3["inv1"]:
		 get_tree().get_nodes_in_group("player")[0].arm[int(ii)] = [save_data3["inv1"][ii][0],int(save_data3["inv1"][ii][1])]
func screen_shot_save():
	var img = get_parent().get_node("Viewport").get_texture().get_data()
	img.flip_y()
	img.save_png(SAVE_DIR + WorldData.world_name + "/icon.png")
func _on_new_screen_shot_timeout():
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	img.save_png(SAVE_DIR + WorldData.world_name + "/icon.png")
func pre_save():
	save_chunks()
func load_virables():
	var file = File.new()
	#var error = file.open(save_path, File.READ)
	save_path3 = SAVE_DIR + WorldData.world_name + "/save_virables.json"
	var error = file.open_encrypted_with_pass(save_path3, File.READ, "P@paB3ar6969")
	var text = file.get_as_text()
	file.close()
	save_data2 = parse_json(text)
	time = save_data2["time"]
	for i in save_data2["getted"].keys():
		for ii in save_data2["getted"][i].size():
			get_node("/root/world/UI2/map/ViewportContainer/Viewport/map").getted[int(i)][ii -1] = int(save_data2["getted"][i][ii -1])
	for i in save_data2["completed"].keys():
		get_node("/root/world/UI2/map/ViewportContainer/Viewport/map").completed[int(i)] =save_data2["completed"][i]
	if time == "night":
		get_node("/root/world/UI2/bg/ViewportContainer/Viewport/CLockBar").set_clock(1)
		$CanvasModulate.color = Color(0.513726, 0.301961, 0.623529)
	$time.wait_time = save_data2["timer_max_time"]
	get_node("/root/world/UI2/bg/ViewportContainer/Viewport/CLockBar").get_node("CanvasLayer/clock").rect_position.x = save_data2["clock"]
	load_time(save_data2["time_left"])
	WorldData.world_type = save_data2["type"]


