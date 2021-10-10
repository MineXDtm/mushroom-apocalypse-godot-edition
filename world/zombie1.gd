extends KinematicBody2D
var standing = false
var inplayer = false
var selected = null
var health = 5
var isattacking = false
var attack = false
var inblock = false
var noplayerfinded = false
var mind
var cords = [0,32,64,96,128,160,192,224,256,288,320,352,384,416,448,480]
var number = 0
var number2 = 0
var random_x = 16
var random_y = 16
var index = 0
var layer = 1
var can_broke = true
var cooldown2 = false
var path = PoolVector2Array()
var block_pos = null
var cooldown = 0
var deleted_path
var anime = true
var detected = "player"
var end_pos
var type = "skip"
onready var tile_t = get_parent().get_parent().get_node("TileMap")
var random_pos = Vector2(random_x,random_y)
export(float) var character_speed = 40
var screen = false
func _process(delta):
	if inplayer == false and inblock == false  and get_parent().get_parent().get_node("sort/player").died == false:
		var distance_to_walk = 50 * delta
		# Move the player along the path until he has run out of movement or the path ends.
		while distance_to_walk > 0 and path.size() > 0:
			var distance_to_next_point = position.distance_to(path[0])
			if distance_to_walk <= distance_to_next_point:
				standing = false
				# The player does not have enough movement left to get to the next point.
				position += position.direction_to(path[0]) * distance_to_walk
			else:
				# The player get to the next point
				position = path[0]
				deleted_path = path[0]
				standing = true
				path.remove(0)
			# Update the distance to walk
			distance_to_walk -= distance_to_next_point




func animate(): #istandbyscott
	if anime == true:
		var anim
		if standing == false and isattacking == false:
			anim = "move_zombie"
		elif standing == true and isattacking == false:
			anim = "idle_zombie"
		elif isattacking == true and standing == true:
			anim = "attack_zombie"
		if selected > position.x:
			scale = Vector2(-1,1)
		else:
			scale = Vector2(1,1)
		if $player.current_animation != anim and anim != null and anim != "Null fliped":
			$player.play(anim)

func _on_Area2D_area_entered(area):
	if area.is_in_group("car_damage_zone") and noplayerfinded == false and inplayer == false    and get_parent().get_parent().get_node("sort/player").died == false and detected == "car": 
		inplayer = true
		standing = true
		mind = area.name
		attack = true
	if area.is_in_group("area") and inplayer == false  and noplayerfinded == false  and get_parent().get_parent().get_node("sort/player").died == false: 
		inplayer = true
		standing = true
		mind = area.name
		attack = true
	if cooldown2 == false:
		if area.is_in_group("block"): 
			randomize()
			for i in range(randi() % 17):
				random_x = cords[i]
			for i in range(randi() % 16):
				random_y = cords[i]
			var random_pos3 = Vector2(random_x,random_y)
			position = random_pos3
		elif area.is_in_group("kust"): 
			randomize()
			for i in range(randi() % 17):
				random_x = cords[i]
			for i in range(randi() % 16):
				random_y = cords[i]
			var random_pos3 = Vector2(random_x,random_y)
			position = random_pos3
		elif area.is_in_group("stone"): 
			randomize()
			for i in range(randi() % 17):
				random_x = cords[i]
			for i in range(randi() % 16):
				random_y = cords[i]
			var random_pos3 = Vector2(random_x,random_y)
			position = random_pos3
	if noplayerfinded == true and can_broke == true  and get_parent().get_parent().get_node("sort/player").died == false:
		if area.is_in_group("block_area"):
			standing = true
			attack = true
			mind = area.name
			inblock = true
		if area.is_in_group("kust_fruit_build") :
			standing = true
			attack = true
			mind = area.name
			inblock = true
		if area.is_in_group("buildblock"):
			standing = true
			attack = true
			mind = area.name
			inblock = true
		if area.is_in_group("door"):
			standing = true
			attack = true
			mind = area.name
			inblock = true
	if area.is_in_group("arm"):
		modulate = Color(2,0,0)
		$Timer2.start()
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 :
			get_parent().get_parent().zombies.erase(index)
			queue_free()
	elif area.is_in_group("wooden_exe"):
		modulate = Color(2,0,0)
		$Timer2.start()
		health -= 1.3
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$Timer2.start()
		if health <= 0 :
			get_parent().get_parent().zombies.erase(index)
			queue_free()
	elif area.is_in_group("wooden_pickaxe"):
		modulate = Color(2,0,0)
		$Timer2.start()
		health -= 0.5
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$Timer2.start()
		if health <= 0 :
			get_parent().get_parent().zombies.erase(index)
			queue_free()
	elif area.is_in_group("stone_pickaxe"):
		modulate = Color(2,0,0)
		$Timer2.start()
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$Timer2.start()
		if health <= 0 :
			get_parent().get_parent().zombies.erase(index)
			queue_free()
	elif area.is_in_group("wooden_trap_damage"):
		modulate = Color(2,0,0)
		$Timer2.start()
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 :
			get_parent().get_parent().zombies.erase(index)
			queue_free()
	elif area.is_in_group("stone_exe"):
		modulate = Color(2,0,0)
		$Timer2.start()
		health -= 1.7
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$Timer2.start()
		if health <= 0 :
			get_parent().get_parent().zombies.erase(index)
			queue_free()
func _on_Area2D_area_exited(area):
	if area.is_in_group("area") and mind == area.name:
		inplayer = false
		standing = false
	elif mind == area.name:
		inplayer = false
		inblock = false
		block_pos = null


func _on_player_animation_finished(_anim_name):
	var animations = ["attack","attack_2"]
	if selected > position.x:
		for i in animations.size():
			animations[i] = str(animations[i]," fliped")
	if isattacking == true:
		isattacking = false


func _on_Timer_timeout():
	if attack == true and inplayer == true:
		isattacking = true
	elif attack == true and inblock == true:
		isattacking = true


func _on_Timer2_timeout():
	modulate = Color(1,1,1)


func _on_body_area_entered(area):
	if area.is_in_group("block_area") and can_broke == true:
		block_pos = area.get_parent().position
	if area.is_in_group("buildblock") and can_broke == true:
		block_pos = area.get_parent().position
	if area.is_in_group("kust_fruit_build") and can_broke == true:
		block_pos = area.get_parent().position
func _ready():
	gamesettings.connect("change_settings",self,"changed_settings")
	if gamesettings.shadow_mode == "low":
		$shadow.visible = true
	else:
		$shadow.visible = false
	randomize()
	for i in range(randi() % get_parent().get_parent().get_node("zombies").cords.size()):
		random_x = get_parent().get_parent().get_node("zombies").cords[i]
	for i in range(randi() % get_parent().get_parent().get_node("zombies").cords.size()):
		random_y = get_parent().get_parent().get_node("zombies").cords[i]
	var random_pos2 = Vector2(random_x,random_y)
	randomize()
	for i in range(randi() %  get_parent().get_parent().get_node("zombies").cords.size()):
		random_x = get_parent().get_parent().get_node("zombies").cords[i]
		number = i
	for i in range(randi() %  get_parent().get_parent().get_node("zombies").cords.size()):
		random_y = get_parent().get_parent().get_node("zombies").cords[i]
		number2 = i
	random_pos = Vector2(random_x,random_y)
	position = random_pos2
	
	var rand_val = randi() % 2
	if rand_val == 1:
		detected = "car"
	else:
		detected = "player"
	can_broke = true 
	for _i in get_parent().get_parent().zombie:
		if get_parent().get_parent().zombies.has(_i) == true:
			if  get_parent().get_parent().zombies[_i][2] == name:
				index = _i
				return
	
func changed_settings():
	print('works')
	if gamesettings.shadow_mode == "low":
		$shadow.visible = true
	else:
		$shadow.visible = false
func _on_VisibilityNotifier2D_screen_entered():
	screen = true


func _on_VisibilityNotifier2D_screen_exited():
	screen = false


func new_pos():
	randomize()
	for i in range(randi() %  get_parent().get_parent().get_node("zombies").cords.size()):
		random_x = get_parent().get_parent().get_node("zombies").cords[i]
		number = i
	for i in range(randi() %  get_parent().get_parent().get_node("zombies").cords.size()):
		random_y = get_parent().get_parent().get_node("zombies").cords[i]
		number2 = i
	random_pos = Vector2(random_x,random_y)


func _on_VisibilityNotifier2D2_screen_entered():
	visible = true
	anime = true


func _on_VisibilityNotifier2D2_screen_exited():
	visible = false
	$player.stop()
	anime = false
var detected_block = null

func _on_Timer4_timeout():
	$Label.text = name
	if $PathFollow2D.is_colliding() and zombie_status == "finding" and detected_block == null :
		detected_block = $PathFollow2D.get_collider()
	if $PathFollow2D2.is_colliding() and zombie_status == "finding" and detected_block == null  :
		detected_block = $PathFollow2D2.get_collider()
	if $PathFollow2D3.is_colliding() and zombie_status == "finding" and detected_block == null :
		detected_block = $PathFollow2D3.get_collider()
	if $PathFollow2D4.is_colliding() and zombie_status == "finding" and detected_block == null :
		detected_block = $PathFollow2D4.get_collider()
	if WorldData.map == get_parent().get_parent().name:
		if position == random_pos:
			randomize()
			for i in range(randi() %  get_parent().get_parent().get_node("zombies").cords.size()):
				random_x = get_parent().get_parent().get_node("zombies").cords[i]
				number = i
			for i in range(randi() %  get_parent().get_parent().get_node("zombies").cords.size()):
				random_y = get_parent().get_parent().get_node("zombies").cords[i]
				number2 = i
			random_pos = Vector2(random_x,random_y)
		if screen == false:
			visible = false
		else:
			visible = true
		if selected == null:
			selected = get_parent().get_parent().get_node("sort/" + detected).position.x
		animate()

func _on_Timer3_timeout():
	cooldown2 = true


func _on_Timer5_timeout():
	if inplayer == false and inblock == false  and get_parent().get_parent().get_node("sort/player").died == false:
		var tile = get_parent().get_parent().get_node("TileMap2").world_to_map(position)
		var pos = get_parent().get_parent().get_node("TileMap2").map_to_world(tile)
		if not get_parent().get_parent().get_node("zombies").walk_zone.has(pos) :
						new_pos()
						position = random_pos
						return
		var name1 = get_parent().get_parent().get_node("zombies").indexes[pos]
		var pathes = {
			"pathe1":[],
			"pathe2":[],
			"pathe3":[]
		}
		var pathe = []
		if detected == "car":
			for i in range(1,4):
				if pathes[str("pathe",i)].size() != 0:
					continue
				var point = get_parent().get_parent().get_node("sort/" + detected+ "/pos"+str(i))
				var indexes = [Vector2(point.get_global_position().x + 32 ,point.get_global_position().y ),
					Vector2(point.get_global_position().x - 32 ,point.get_global_position().y ),
					Vector2(point.get_global_position().x ,point.get_global_position().y + 32 ),
					Vector2(point.get_global_position().x ,point.get_global_position().y - 32)]
				for point_relative in indexes:
					var tile2 = get_parent().get_parent().get_node("TileMap2").world_to_map(point_relative)
					var pos2 = get_parent().get_parent().get_node("TileMap2").map_to_world(tile2)
					if not get_parent().get_parent().get_node("zombies").walk_zone.has(pos2) :
						continue
					var name2 = get_parent().get_parent().get_node("zombies").indexes[pos2]
					pathes[str("pathe",i)] = get_parent().get_parent().get_node("zombies").astar.get_point_path(int(pos.x + pos.y+ int(name1)), int(pos2.x + pos2.y + int(name2)))
					
		else:
			var tile2 = get_parent().get_parent().get_node("TileMap2").world_to_map(get_parent().get_parent().get_node("sort/" + detected).position)
			var pos2 = get_parent().get_parent().get_node("TileMap2").map_to_world(tile2)
			if not get_parent().get_parent().get_node("zombies").walk_zone.has(pos2) :
				
				return
			var name2 = get_parent().get_parent().get_node("zombies").indexes[pos2]
			pathe = get_parent().get_parent().get_node("zombies").astar.get_point_path(int(pos.x + pos.y+ int(name1)), int(pos2.x + pos2.y + int(name2)))
			
		if pathe.size() != 0 || pathes["pathe1"].size() != 0 || pathes["pathe2"].size() != 0 ||  pathes["pathe3"].size() != 0  :
			zombie_status = "following"
			$Timer6.stop()
			selected = get_parent().get_parent().get_node("sort/" + detected).position.x
			noplayerfinded = false 
			can_broke = false
			if pathe.size() != 0:
				path = pathe
			elif pathes["pathe1"].size() != 0:
				path = pathes["pathe1"]
			elif pathes["pathe2"].size() != 0:
				path = pathes["pathe2"]
			elif pathes["pathe3"].size() != 0:
				path = pathes["pathe3"]
			if path[0] == deleted_path:
				path.remove(0)
		else:
			if detected_block != null:
				$Timer5.pause_mode = true
				if not weakref(detected_block).get_ref() :
					detected_block = null
					$Timer5.pause_mode = false
					zombie_status = "finding"
					return
				var check = 0
				var indexes = [Vector2(detected_block.cords2[detected_block.number]+ 32 ,detected_block.cords2[detected_block.number2] ),
					Vector2(detected_block.cords2[detected_block.number] - 32 ,detected_block.cords2[detected_block.number2]),
					Vector2(detected_block.cords2[detected_block.number] ,detected_block.cords2[detected_block.number2] + 32 ),
					Vector2(detected_block.cords2[detected_block.number] ,detected_block.cords2[detected_block.number2]- 32)]
				for point_relative in indexes:
					check += 1
					if not get_parent().get_parent().get_node("zombies").walk_zone.has(point_relative):
						if check == 4:
							detected_block = null
							$Timer5.pause_mode = false
							zombie_status = "finding"
						continue
					if not get_parent().get_parent().get_node("zombies").astar.has_point(int(point_relative.x + point_relative.y) + int(get_parent().get_parent().get_node("zombies").indexes[point_relative])):
						if check == 4:
							detected_block = null
							$Timer5.pause_mode = false
							zombie_status = "finding"
						continue
					# Note the 3rd argument. It tells the astar_node that we want the
					# connection to be bilateral: from point A to B and B to A
					
					# If you set this value to false, it becomes a one-way path
					if zombie_status == "detected_block" and path.size() != 0:
						print('lol')
						return
					# As we loop through all points we can set it to false
					var name3 = get_parent().get_parent().get_node("zombies").indexes[point_relative]
					var pathe2 = get_parent().get_parent().get_node("zombies").astar.get_point_path(int(pos.x + pos.y+ int(name1)), int(point_relative.x  + point_relative.y) + int(name3))
					if pathe2.size() != 0 and pathe2[0] == deleted_path:
						pathe2.remove(0)
					if pathe2.size() == 0:
						if check == 4:
							detected_block = null
							$Timer5.pause_mode = false
							zombie_status = "finding"
						continue
					else:
						selected  = point_relative.x
					can_broke = true
					path = pathe2
					zombie_status = "detected_block"
					return
			
			if not get_parent().get_parent().get_node("zombies").walk_zone.has(random_pos) :
				new_pos()
				return
			zombie_status = "finding"
			var name3 = get_parent().get_parent().get_node("zombies").walk_zone[random_pos].name
			var pathe2 = get_parent().get_parent().get_node("zombies").astar.get_point_path(int(pos.x + pos.y+ int(name1)), int(random_pos.x + random_pos.y + int(name3)))
			if pathe2.size() != 0 and pathe2[0] == deleted_path:
				pathe2.remove(0)
			if pathe2.size() == 0:
				new_pos()
			else:
				selected  = random_pos.x
			noplayerfinded = true 
			path = pathe2
			if $Timer6.is_stopped():
				$Timer6.start()
var zombie_status = "finding"
func _on_Timer6_timeout():
	new_pos()
