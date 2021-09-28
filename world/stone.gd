extends Area2D
var health = 12
var broked = false
var cords = [16]
var cords2 = [0]
var random_x = 16
var random_y = 16
var number = 0
var number2 = 0
var cooldown32 = 16
var map_size = 1536
var needed = 0
var added = 16
var skip = 0
var added2 = 0
var layer = 1
var type = "stone"
func _on_kust_area_entered(area):
	if area.is_in_group("kust"):
		$CollisionPolygon2D2.set_deferred("disabled" , true)
		var navigationscene = load("res://world/NavigationPolygonInstance.tscn")
		var navigation = navigationscene.instance()
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		get_parent().get_parent().get_node("zombies").call_deferred("add_child", navigation)
		randomize()
		for i in range(randi() % cords.size()):
			random_x = cords[i]
			number = i
		for i in range(randi() % cords.size()):
			random_y = cords[i]
			number2 = i
		var random_pos = Vector2(random_x,random_y)
		position = random_pos
		$CollisionPolygon2D2.set_deferred("disabled" , false)
	elif area.is_in_group("blocked"):
		$CollisionPolygon2D2.set_deferred("disabled" , true)
		var navigationscene = load("res://world/NavigationPolygonInstance.tscn")
		var navigation = navigationscene.instance()
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		get_parent().get_parent().get_node("zombies").call_deferred("add_child", navigation)
		randomize()
		for i in range(randi() % cords.size()):
			random_x = cords[i]
			number = i
		for i in range(randi() % cords.size()):
			random_y = cords[i]
			number2 = i
		var random_pos = Vector2(random_x,random_y)
		position = random_pos
		$CollisionPolygon2D2.set_deferred("disabled" , false)
	elif area.is_in_group("kust_fruit"):
		$CollisionPolygon2D2.set_deferred("disabled" , true)
		var navigationscene = load("res://world/NavigationPolygonInstance.tscn")
		var navigation = navigationscene.instance()
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		get_parent().get_parent().get_node("zombies").call_deferred("add_child", navigation)
		randomize()
		for i in range(randi() % cords.size()):
			random_x = cords[i]
			number = i
		for i in range(randi() % cords.size()):
			random_y = cords[i]
			number2 = i
		var random_pos = Vector2(random_x,random_y)
		position = random_pos
		$CollisionPolygon2D2.set_deferred("disabled" , false)
	elif area.is_in_group("stone"):
		$CollisionPolygon2D2.set_deferred("disabled" , true)
		var navigationscene = load("res://world/NavigationPolygonInstance.tscn")
		var navigation = navigationscene.instance()
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		get_parent().get_parent().get_node("zombies").call_deferred("add_child", navigation)
		randomize()
		for i in range(randi() % cords.size()):
			random_x = cords[i]
			number = i
		for i in range(randi() % cords.size()):
			random_y = cords[i]
			number2 = i
		var random_pos = Vector2(random_x,random_y)
		position = random_pos
		$CollisionPolygon2D2.set_deferred("disabled" , false)
	elif area.is_in_group("car_area"):
		$CollisionPolygon2D2.set_deferred("disabled" , true)
		var navigationscene = load("res://world/NavigationPolygonInstance.tscn")
		var navigation = navigationscene.instance()
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		get_parent().get_parent().get_node("zombies").call_deferred("add_child", navigation)
		randomize()
		for i in range(randi() % cords.size()):
			random_x = cords[i]
			number = i
		for i in range(randi() % cords.size()):
			random_y = cords[i]
			number2 = i
		var random_pos = Vector2(random_x,random_y)
		position = random_pos
		$CollisionPolygon2D2.set_deferred("disabled" , false)
	if area.is_in_group("arm") and broked == false:
		health -= 0.5
		print(position.y, name)
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			queue_free()
	elif area.is_in_group("wooden_exe") and broked == false:
		health -= 0.7
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			queue_free()
	elif area.is_in_group("wooden_pickaxe") and broked == false:
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			$ProgressBar.visible = false
			print("broked")
			broked = true
	elif area.is_in_group("stone_pickaxe") and broked == false:
		health -= 1.5
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			$ProgressBar.visible = false
			print("broked")
			broked = true
	elif area.is_in_group("stone_exe") and broked == false:
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			queue_free()
func _on_AnimatedSprite_animation_finished():
	if broked == false and health > 0 :
		$AnimatedSprite.play("default")
		
	if broked == true :
		broked = false
		#Ganaretor.fruit_kustes -= 1
		var world = get_parent()
		var drop_scene = load("res://world/drop/ItemDrop.tscn") 
		var _drop_intance = drop_scene.instance()
		_drop_intance.item_name = "cobblestone"
		_drop_intance.position = position
		var navigationscene = load("res://world/NavigationPolygonInstance.tscn")
		var navigation = navigationscene.instance()
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		get_parent().get_parent().get_node("zombies").call_deferred("add_child", navigation)
		var exit_scene = load("res://exit.tscn")
		var _exit_intance = exit_scene.instance()
		_exit_intance.position = position
		world.call_deferred("add_child", _exit_intance)
		_exit_intance.position = position
		_drop_intance.position = position
		world.call_deferred("add_child", _drop_intance)
		_drop_intance.position = position
		queue_free()

func _ready():
	while cooldown32 <= map_size:
		cooldown32 += 32
		needed += 1 
	for i in needed:
		added += 32
		added2 += 32
		cords.append(added)
		cords2.append(added2)
	if WorldData.new == true:
		randomize()
		for i in range(randi() % cords.size()):
			random_x = cords[i]
			number = i
		for i in range(randi() % cords.size()):
			random_y = cords[i]
			number2 = i
		var random_pos = Vector2(random_x,random_y)
		position = random_pos


	
	
	



func _on_VisibilityNotifier2D_screen_entered():
	visible = true


func _on_VisibilityNotifier2D_screen_exited():
	visible = false
