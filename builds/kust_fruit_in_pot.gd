extends Area2D
var health = 7
var broked = false
var started = true
var level = 0
var cords = [16]
var cords2 = [0]
var number
var number2
var map_size = 1536
var needed = 0
var cooldown32 = 16
var added = 16
var added2 = 0
var type = "kust_fruit_in_pot"
func _on_kust_area_entered(area):
	if area.is_in_group("arm") and started == false:
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			$ProgressBar.visible = false
			$AnimatedSprite.position.x = -110
			$AnimatedSprite.play("broked")
			broked = true
	if area.is_in_group("wooden_exe") and broked == false and started == false:
		health -= 1.3
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			$ProgressBar.visible = false
			$AnimatedSprite.position.x = -110
			$AnimatedSprite.play("broked")
			broked = true
	if area.is_in_group("wooden_pickaxe") and broked == false:
		health -= 0.5
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			$ProgressBar.visible = false
			$AnimatedSprite.position.x = -110
			$AnimatedSprite.play("broked")
			print("broked")
			broked = true
	if area.is_in_group("stone_pickaxe") and broked == false:
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			$ProgressBar.visible = false
			$AnimatedSprite.position.x = -110
			$AnimatedSprite.play("broked")
			print("broked")
			broked = true
	if area.is_in_group("stone_exe") and broked == false:
		health -= 1.7
		$ProgressBar.visible = true
		$ProgressBar.value = health
		$AnimatedSprite.play("broke")
		if health <= 0 :
			$ProgressBar.visible = false
			$AnimatedSprite.position.x = -110
			$AnimatedSprite.play("broked")
			print("broked")
			broked = true
func _on_AnimatedSprite_animation_finished():
	if broked == false and health > 0 and started == false:
		$AnimatedSprite.play("default")
		
	if broked == true :
		$StaticBody2D.visible = false
		$StaticBody2D/CollisionShape2D.disabled = true
		$StaticBody2D/CollisionShape2D2.disabled = true
		$CollisionShape2D.visible = false
		$AnimatedSprite.visible = false
		$CollisionShape2D.disabled = true
		var navigationscene = load("res://world/NavigationPolygonInstance.tscn")
		var _world = get_parent()
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
		_drop_intance.position = position
		_drop_intance.item_name = "drop_wood"
		var drop_scene2 = load("res://world/drop/ItemDrop.tscn")
		var _drop_intance2 = drop_scene2.instance()
		_drop_intance2.position = position
		_drop_intance2.item_name = "apple"
		var drop_scene3 = load("res://world/drop/ItemDrop.tscn")
		var _drop_intance3 = drop_scene3.instance()
		_drop_intance3.position = position
		_drop_intance3.item_name = "apple"
		world.call_deferred("add_child", _drop_intance)
		world.call_deferred("add_child", _drop_intance2)
		world.call_deferred("add_child", _drop_intance3)
		queue_free()
		
func _physics_process(_delta):
	get_input()
	if level == 4 and started == true:
		$AnimatedSprite.play("default")
		started = false
		$StaticBody2D/CollisionShape2D.disabled = false
		$StaticBody2D/CollisionShape2D2.disabled = false
		pass
func get_input():
	var parent = get_parent().name
	if started == true:
		$StaticBody2D/CollisionShape2D.disabled = true
		$StaticBody2D/CollisionShape2D2.disabled = true
		$AnimatedSprite.play("up")
		$AnimatedSprite.frame = level
		
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
func _on_Timer_timeout():
	level += 1


func _on_kust_fruit_build_area_entered(area):
	if area.is_in_group("zombie_arm"):
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 :
			$ProgressBar.visible = false
			$AnimatedSprite.play("broked")
			broked = true
