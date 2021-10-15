extends Area2D
var health = 12
var broked = false
var cords = [16]
var cords2 = [0]
var random_x = 16
var random_y = 16
var number = 0
var random = RandomNumberGenerator.new()
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
		if health <= 0 :
			queue_free()
	elif area.is_in_group("wooden_exe") and broked == false:
		health -= 0.7
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 :
			queue_free()
	elif area.is_in_group("wooden_pickaxe") and broked == false:
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 :
			$ProgressBar.visible = false
			print("broked")
			broked = true
	elif area.is_in_group("stone_pickaxe") and broked == false:
		health -= 1.5
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 :
			$ProgressBar.visible = false
			print("broked")
			broked = true
	elif area.is_in_group("stone_exe") and broked == false:
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 :
			queue_free()
	if broked == true :
		$AnimatedSprite.visible = false
		for i in range(10):
				var particle = Polygon2D.new()
				random.randomize()
				var pos = Vector2(random.randi_range(0,$AnimatedSprite.texture.get_size().x),random.randi_range(0,$AnimatedSprite.texture.get_size().y))
				particle.polygon = [pos , Vector2(pos.x +5 ,pos.y), Vector2(pos.x +5 ,pos.y+5) , Vector2(pos.x ,pos.y+5)]
				particle.texture = $AnimatedSprite.texture
				particle.position = $AnimatedSprite.position -pos 
				particle.set_script(load("res://world/particle.gd"))
				add_child(particle)
		yield(get_tree().create_timer(0.2), "timeout")
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
