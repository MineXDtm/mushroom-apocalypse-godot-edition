extends Area2D
var type = "door"
var health = 10
var cords = [16]
var cords2 = [0]
var opened = false
var rotare = "up"
var number = 0
var number2 = 0
var map_size = 1536
var needed = 0
var cooldown32 = 16
var added = 16
var added2 = 0
var layer = 1
func _ready():
	while cooldown32 <= map_size:
		cooldown32 += 32
		needed += 1 
	for i in needed:
		added += 32
		added2 += 32
		cords.append(added)
		cords2.append(added2)
	for i in range(0,cords.size()):
		if cords[i] == position.x:
			number =  i
		if cords[i] == position.y:
			number2 = i
	if get_parent().get_parent().get_parent().get_node("TileMap").rotare == "up":
		$StaticBody2D/CollisionShape2D.disabled = false
		rotare = "up"
	elif get_parent().get_parent().get_parent().get_node("TileMap").rotare == "right":
		$AnimatedSprite.frame = 1
		$AnimatedSprite.flip_h = true
		$StaticBody2D3/CollisionShape2D.disabled = false
		rotare = "right"
	elif get_parent().get_parent().get_parent().get_node("TileMap").rotare == "left":
		$AnimatedSprite.frame = 1
		$StaticBody2D2/CollisionShape2D.disabled = false
		rotare = "left"
	elif get_parent().get_parent().get_parent().get_node("TileMap").rotare == "down":
		$AnimatedSprite.position.y = 30
		$StaticBody2D4/CollisionShape2D.disabled = false
		rotare = "down"
func _on_block_area_area_entered(area):
	if area.is_in_group("body") and area.is_in_group("player") and rotare == "up":
		if opened == false:
			$StaticBody2D/CollisionShape2D.set_deferred("disabled",true)
			$AnimatedSprite.frame = 1
			opened = true
		elif opened == true:
			$StaticBody2D/CollisionShape2D.set_deferred("disabled",false)
			$AnimatedSprite.frame = 0
			opened = false
	elif area.is_in_group("body") and area.is_in_group("player") and rotare == "right":
		if opened == false:
			$StaticBody2D3/CollisionShape2D.set_deferred("disabled",true)
			$AnimatedSprite.frame = 0
			opened = true
		elif opened == true:
			$StaticBody2D3/CollisionShape2D.set_deferred("disabled",false)
			$AnimatedSprite.frame = 1
			opened = false
	elif area.is_in_group("body") and area.is_in_group("player") and rotare == "down":
		if opened == false:
			$StaticBody2D4/CollisionShape2D.set_deferred("disabled",true)
			$AnimatedSprite.frame = 1
			$AnimatedSprite.position.y = 0
			opened = true
		elif opened == true:
			$StaticBody2D4/CollisionShape2D.set_deferred("disabled",false)
			$AnimatedSprite.position.y = 30
			$AnimatedSprite.frame = 0
			opened = false
	elif area.is_in_group("body") and area.is_in_group("player") and rotare == "left":
		if opened == false:
			$StaticBody2D2/CollisionShape2D.set_deferred("disabled",true)
			$AnimatedSprite.frame = 0
			$AnimatedSprite.position.y = 30
			opened = true
		elif opened == true:
			$StaticBody2D2/CollisionShape2D.set_deferred("disabled",false)
			$AnimatedSprite.position.y = 0
			$AnimatedSprite.frame = 1
			opened = false
func _on_Timer2_timeout():
	pass # Replace with function body.


func _on_door_area_area_entered(area):
	pass # Replace with function body.


func _on_Timer_timeout():
	pass # Replace with function body.
var brokede = false
var broked = false
func _on_door_area_entered(area):
	if broked == false:
		if area.is_in_group("zombie_arm"):
			health -= 1
			$ProgressBar.visible = true
			$ProgressBar.value = health
			if health <= 0 :
				$ProgressBar.visible = false
				broked = true
		elif area.is_in_group("arm") and broked == false:
			health -= 1
			$ProgressBar.visible = true
			$ProgressBar.value = health
			if health <= 0 :
				$ProgressBar.visible = false
				broked = true
		elif area.is_in_group("wooden_exe") and broked == false:
			health -= 1.3
			$ProgressBar.visible = true
			$ProgressBar.value = health
			if health <= 0 :
				$ProgressBar.visible = false
				broked = true
		elif area.is_in_group("wooden_pickaxe") and broked == false:
			health -= 0.7
			$ProgressBar.visible = true
			$ProgressBar.value = health
			if health <= 0 :
				$ProgressBar.visible = false
				broked = true
		elif area.is_in_group("stone_pickaxe") and broked == false:
			health -= 1.3
			$ProgressBar.visible = true
			$ProgressBar.value = health
			if health <= 0 :
				$ProgressBar.visible = false
				$AnimatedSprite.position.x = -110
				broked = true
		elif area.is_in_group("stone_exe") and broked == false:
			health -= 1.7
			$ProgressBar.visible = true
			$ProgressBar.value = health
			if health <= 0 :
				$ProgressBar.visible = false
				$AnimatedSprite.position.x = -110
				broked = true
		if broked == true and brokede == false:
			brokede = true
			var navigationscene = load("res://world/NavigationPolygonInstance.tscn")
			var navigation = navigationscene.instance()
			navigation.position.x = cords2[number]
			navigation.position.y = cords2[number2]
			navigation.position.x = cords2[number]
			navigation.position.y = cords2[number2]
			navigation.added_by_gen = false
			get_parent().get_parent().get_node("zombies").call_deferred("add_child", navigation)
			var world = get_parent()
			var exit_scene = load("res://exit.tscn")
			var _exit_intance = exit_scene.instance()
			_exit_intance.position = position
			world.call_deferred("add_child", _exit_intance)
			_exit_intance.position = position
			var drop_scene = load("res://world/drop/ItemDrop.tscn")
			var _drop_intance = drop_scene.instance()
			_drop_intance.position = position
			_drop_intance.item_name = "door"
			world.call_deferred("add_child", _drop_intance)
			queue_free()
