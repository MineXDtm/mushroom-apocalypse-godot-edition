extends Area2D
var health = 16
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
var type = "bucket"
func _on_bucket_area_entered(area):
	if area.is_in_group("kust"):
		randomize()
		for i in range(randi() % cords.size()):
			random_x = cords[i]
			number = i
		for i in range(randi() % cords.size()):
			random_y = cords[i]
			number2 = i
		var random_pos = Vector2(random_x,random_y)
		position = random_pos
		
	if area.is_in_group("blocked"):
		randomize()
		for i in range(randi() % cords.size()):
			random_x = cords[i]
			number = i
		for i in range(randi() % cords.size()):
			random_y = cords[i]
			number2 = i
		var random_pos = Vector2(random_x,random_y)
		position = random_pos
	if area.is_in_group("kust_fruit"):
		randomize()
		for i in range(randi() % cords.size()):
			random_x = cords[i]
			number = i
		for i in range(randi() % cords.size()):
			random_y = cords[i]
			number2 = i
		var random_pos = Vector2(random_x,random_y)
		position = random_pos
	if area.is_in_group("stone"):
		randomize()
		for i in range(randi() % cords.size()):
			random_x = cords[i]
			number = i
		for i in range(randi() % cords.size()):
			random_y = cords[i]
			number2 = i
		var random_pos = Vector2(random_x,random_y)
		position = random_pos
	if area.is_in_group("car_area"):
		randomize()
		for i in range(randi() % cords.size()):
			random_x = cords[i]
			number = i
		for i in range(randi() % cords.size()):
			random_y = cords[i]
			number2 = i
		var random_pos = Vector2(random_x,random_y)
		position = random_pos
	if area.is_in_group("arm") and broked == false:
		health -= 0.5
		print(position.y, name)
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			queue_free()
	if area.is_in_group("wooden_exe") and broked == false:
		health -= 0.7
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			queue_free()
	if area.is_in_group("wooden_pickaxe") and broked == false:
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			$ProgressBar.visible = false
			broked = true
	if area.is_in_group("stone_pickaxe") and broked == false:
		health -= 1.5
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			$ProgressBar.visible = false
			broked = true
	if area.is_in_group("stone_exe") and broked == false:
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			queue_free()
	if broked == true :
		broked = false
		Ganaretor.kustes -= 1
		var world = get_parent()
		var drop_scene = load("res://world/drop/ItemDrop.tscn")
		var _drop_intance = drop_scene.instance()
		_drop_intance.item_name = "piece_of_rust"
		_drop_intance.position = position
		world.add_child(_drop_intance)
		var navigationscene = load("res://world/NavigationPolygonInstance.tscn")
		var _world = get_parent()
		var navigation = navigationscene.instance()
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		get_parent().get_parent().get_node("zombie").add_child(navigation)
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		queue_free()
func _on_AnimatedSprite_animation_finished():
	if broked == false and health > 0 :
		$AnimatedSprite.play("default")

func _ready():
	while cooldown32 <= map_size:
		cooldown32 += 32
		needed += 1 
	for i in needed:
		added += 32
		added2 += 32
		cords.append(added)
		cords2.append(added2)
	randomize()
	for i in range(randi() % cords.size()):
		random_x = cords[i]
		number = i
	for i in range(randi() % cords.size()):
		random_y = cords[i]
		number2 = i
	var random_pos = Vector2(random_x,random_y)
	position = random_pos
	
	
	


