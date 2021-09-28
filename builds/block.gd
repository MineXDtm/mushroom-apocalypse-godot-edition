extends Area2D
var health = 10
var broked = false
var cords = [16]
var cords2 = [0]
var number = 0
var number2 = 0
var rotare = "up"
var map_size = 1536
var needed = 0
var cooldown32 = 16
var added = 16
var added2 = 0
var type = "block"
var layer = 1
func _ready():
	WorldData.blocks += 1
	name = str("block",WorldData.blocks)
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
		$AnimatedSprite.play("default")
		$AnimatedSprite.position.y = 0
		$AnimatedSprite.position.x = 0
		$AnimatedSprite/up.visible = true
		$StaticBody2D/up.disabled = false
		rotare = "up"
	elif get_parent().get_parent().get_parent().get_node("TileMap").rotare == "right":
		$AnimatedSprite.play("right")
		$AnimatedSprite/right.visible = true
		$StaticBody2D/right.disabled = false
		$AnimatedSprite.position.y = 41.037
		$AnimatedSprite.position.x = 0
		rotare = "right"
	elif get_parent().get_parent().get_parent().get_node("TileMap").rotare == "left":
		$AnimatedSprite.play("left")
		$AnimatedSprite/left.visible = true
		$StaticBody2D/left.disabled = false
		$AnimatedSprite.position.y = 41.037
		$AnimatedSprite.position.x = 237.775
		rotare = "left"
	elif get_parent().get_parent().get_parent().get_node("TileMap").rotare == "down":
		$AnimatedSprite.play("default")
		$AnimatedSprite/up.visible = true
		$StaticBody2D/down.disabled = false
		$AnimatedSprite.position.y = 82.073
		$AnimatedSprite.position.x = 0
		rotare = "down"
func _on_kust_area_entered(area):
	if broked == false:
		if area.is_in_group("arm") and broked == false:
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
			_drop_intance.item_name = "drop_wood"
			world.call_deferred("add_child", _drop_intance)
			queue_free()





func _on_block_area_area_entered(area):
	if area.is_in_group("zombie_arm"):
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 and broked == false and brokede == false:
			brokede = true
			broked = true
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
			_drop_intance.item_name = "drop_wood"
			world.call_deferred("add_child", _drop_intance)
			queue_free()


func _on_block2_area_entered(area):
	if broked == false:
		if area.is_in_group("arm") and broked == false:
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
			_drop_intance.item_name = "drop_wood"
			_drop_intance.position = position
			world.call_deferred("add_child", _drop_intance)
			_drop_intance.position = position
			queue_free()

var brokede= false
