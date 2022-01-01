extends KinematicBody2D
export (int) var speed = 70
var velocity = Vector2()
var isattacking = false
var opened = false
var arm = "arm"
var invenory_slot = "1"
var fliped = false
var full = false
var inventory_slot1_full = false
var inv1 = "arm"
var inventory_slot2_full = false
var inv2 = "arm"
var inventory_slot3_full = false
var inv3 = "arm"
var inventory_opened = false
var rands
var cooldown = false
var health = 20
var energy = 10
var min_energy = 4
var full2 = false
var cd = false
var died = false
var anim_name2
var eating = false
var layer = 1
var type = "player"

onready var heals = get_node("/root/world/UI2/bars/health")
func changed_settings():
	if gamesettings.shadow_mode == "low":
		shadow.visible = true
	else:
		shadow.visible = false
func _process(_delta):
	$Label.text = str(position)
	if health <= 0 and cd == false:
		cd = true
		get_node("/root/world/UI2/inventory").drop_all()
		get_node("/root/world/UI2/died_menu").visible = true
		get_tree().paused = true
		visible = false
		died = true
	elif health >= 0 :
		cd = false
	if invenory_slot == "1" and isattacking == false:
		if PlayerInventory.inventory1.has(0):
			$model/arm1/item.visible = true
			$model/arm1/item.texture = load("res://textures/items/" + PlayerInventory.inventory1[0][0] + ".png")
			arm = PlayerInventory.inventory1[0][0]
		elif isattacking == false:
			arm = "arm"
			$model/arm1/item.visible = false
	elif isattacking == false:
		var inv =get_node("/root/world/UI2/hand_slots")
		inv.unselect("slot1")
	if invenory_slot == "2" and isattacking == false:
		if PlayerInventory.inventory1.has(1): 
			$model/arm1/item.visible = true
			$model/arm1/item.texture = load("res://textures/items/" + PlayerInventory.inventory1[1][0] + ".png")
			arm = PlayerInventory.inventory1[1][0]
		elif isattacking == false:
			arm = "arm"
			$model/arm1/item.visible = false
	elif isattacking == false:
		var inv = get_node("/root/world/UI2/hand_slots")
		inv.unselect("slot2")
	if invenory_slot == "3" and isattacking == false:
		if PlayerInventory.inventory1.has(2): 
			$model/arm1/item.visible = true
			$model/arm1/item.texture = load("res://textures/items/" + PlayerInventory.inventory1[2][0] + ".png")
			arm = PlayerInventory.inventory1[2][0]
		elif isattacking == false:
			arm = "arm"
			$model/arm1/item.visible = false
	elif isattacking == false:
		var inv = get_node("/root/world/UI2/hand_slots")
		inv.unselect("slot3")
var in_console = false
var player_god = false
func god(value = true):
	if value == true:
		player_god = true
	else:
		player_god = false
func _ready():
	loadskin()
	if gamesettings.shadow_mode != "low":
		$model/shadow.visible = false
	gamesettings.connect("change_settings",self,"changed_settings")
	Console.add_command('god_mode', self, 'god')\
		.set_description('god mode')\
		.add_argument('true/false', TYPE_BOOL)\
		.register()
	Console.add_command('kill', self, 'dead')\
		.set_description('kills your player')\
		.add_argument('tasdrue/false', TYPE_BOOL)\
		.register()
func dead(va = false):
	health = 0
func _input(event):
	if event.is_action_pressed("inv") and isattacking == false and opened == false  and died == false:
		var inv = get_parent().get_parent().get_parent().get_node("UI2")
		inv.openinv()
		if inventory_opened == false:
			inventory_opened = true
		else:
			inventory_opened = false

onready var player = get_node("player")
onready var shadow = get_node("model/shadow")
var in_menu = false
func loadskin():
	for i in get_node("model").get_children():
		if i.name == "shadow":continue
		i.texture.set_atlas(SkinManager.skin)
		
func _physics_process(_delta):
	if in_console == false and in_menu == false:
		get_input()
		$Label.text = str(position)
		velocity = move_and_slide(velocity)
		get_node("/root/world/UI2/bars/health/bg/bar_health").value = health
		if fliped == false:
			$armsattack/CollisionShape2D.position.x = 17.478
			$wooden_exe/CollisionShape2D.position.x = 17.478
			$wooden_pickaxe/CollisionShape2D.position.x = 17.478
			$stone_pickaxe/CollisionShape2D.position.x = 17.478
			$stone_exe/CollisionShape2D.position.x = 17.478
		else:
			if arm != "arm":
				if JsonData.item_data[arm]["ItemCategory"] == "instrument":
					$model/arm1/item.rect_position.x = -8
					$model/arm1/item.rect_position.y = -3.5
					$model/arm1/item.rect_rotation = -45
				else:
					$model/arm1/item.rect_rotation = 0
					$model/arm1/item.rect_position.x = -7
					$model/arm1/item.rect_position.y = -8
			$armsattack/CollisionShape2D.position.x = -17.478
			$wooden_exe/CollisionShape2D.position.x = -17.478
			$wooden_pickaxe/CollisionShape2D.position.x = -17.478
			$stone_pickaxe/CollisionShape2D.position.x = -17.478
			$stone_exe/CollisionShape2D.position.x = -17.478
func get_input():
	velocity = Vector2()
	if Input.is_action_just_released("scrolling_up") and isattacking == false and opened == false  and died == false and eating == false:
		if invenory_slot != "3":
			var inv = get_node("/root/world/UI2/hand_slots")
			var i = int(invenory_slot)
			i += 1
			inv.select(str("slot",i))
			invenory_slot = str(i)
		else:
			var inv = get_node("/root/world/UI2/hand_slots")
			var i = int(invenory_slot)
			i = 1
			inv.select(str("slot",i))
			invenory_slot = str(i)
	elif Input.is_action_just_released("scrolling_down") and isattacking == false and opened == false  and died == false and eating == false:
		
		if invenory_slot != "1":
			var inv = get_node("/root/world/UI2/hand_slots")
			var i = int(invenory_slot)
			i -= 1
			inv.select(str("slot",i))
			invenory_slot = str(i)
		else:
			var inv = get_node("/root/world/UI2/hand_slots")
			var i = int(invenory_slot)
			i = 3
			inv.select(str("slot",i))
			invenory_slot = str(i)
	if Input.is_action_just_pressed("open")  and died == false:
		$body/CollisionShape2D2.disabled = false
	if Input.is_action_just_pressed("inv1") and isattacking == false and opened == false  and died == false and eating == false:
		var inv = get_parent().get_node("/root/world/UI2/hand_slots")
		inv.select("slot1")
		invenory_slot = "1"
	elif Input.is_action_just_pressed("inv2") and isattacking == false and opened == false and died == false  and eating == false:
		var inv = get_node("/root/world/UI2/hand_slots")
		inv.select("slot2")
		invenory_slot = "2"
	elif Input.is_action_just_pressed("inv3") and isattacking == false and opened == false and died == false  and eating == false:
		var inv = get_node("/root/world/UI2/hand_slots")
		inv.select("slot3")
		invenory_slot = "3"
	if Input.is_action_pressed("player_right") and isattacking == false and opened == false and died == false  and eating == false:
		velocity.x += 1
		fliped = false
		$Particles2D.position.x = -7
		$Particles2D.process_material.gravity.x = -50
	elif Input.is_action_pressed("player_left") and isattacking == false and opened == false and died == false and eating == false:
		velocity.x -= 1
		fliped = true
		$Particles2D.position.x = 7
		$Particles2D.process_material.gravity.x = 50
	if Input.is_action_pressed("Player_down") and isattacking == false and opened == false and died == false and eating == false:
		velocity.y += 1
	if Input.is_action_pressed("player_up") and isattacking == false and opened == false and died == false and eating == false:
		velocity.y -= 1
	if velocity.x == 0 and velocity.y == 0 :
		if Input.is_action_just_pressed("click_left") and opened == false and isattacking == false and inventory_opened == false and died == false:
			var rand = randi() % 2
			rands = rand
			if arm == "arm":
				isattacking = true
				$armsattack/CollisionShape2D.disabled = false
			elif JsonData.item_data[arm]["ItemCategory"] == "food" and health < 20 and eating == false:
				eating = true
			elif JsonData.item_data[arm]["ItemCategory"] == "resurse":
				isattacking = true
				$armsattack/CollisionShape2D.disabled = false
			elif JsonData.item_data[arm]["ItemCategory"] == "instrument":
				isattacking = true
				get_node(str(arm,"/CollisionShape2D")).disabled = false
	velocity = velocity.normalized() * speed
	animate()
	inventory()

func inventory():
	if arm != "arm" and JsonData.item_data[arm]["ItemCategory"] == "build"  and JsonData.item_data[arm]["layer"] == 1:
		var block = get_parent().get_parent().get_parent().get_node("TileMap")
		block.visible = true
		if block.empty != load("res://textures/build_player/" + arm +"_true.png"):
			block.empty = load("res://textures/build_player/" + arm +"_true.png")
			if JsonData.item_data[arm]["rotation"]:
				block.empty_rotare = load("res://textures/build_player/" + arm +"_rotare_true.png")
				block.full_rotare = load("res://textures/build_player/" + arm +"_rotare_false.png")
			block.full  = load("res://textures/build_player/" + arm +"_false.png")
			block.type = arm
		if Input.is_action_just_pressed("click_left") and full ==  false and opened == false and inventory_opened == false and died == false:
			var _map = get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort"))
			var fruit = load("res://builds/"+arm+".tscn")
			var fruits = fruit.instance()
			fruits.position = get_parent().get_parent().get_parent().get_node("TileMap/Node2D").position
			fruits.position.x += 16
			fruits.position.y += 16
			_map.add_child(fruits)
			if invenory_slot == "1":
				var inventory1 = get_parent().get_parent().get_parent().get_node("UI2/inventory")
				inventory1.place("slot1")
			elif  invenory_slot == "2":
				var inventory1 = get_parent().get_parent().get_parent().get_node("UI2/inventory")
				inventory1.place("slot2")
			elif  invenory_slot == "3":
				var inventory1 = get_parent().get_parent().get_parent().get_node("UI2/inventory")
				inventory1.place("slot3")
	else:
		var block = get_node("/root/world/TileMap")
		block.visible = false
	if arm != "arm" and JsonData.item_data[arm]["ItemCategory"] == "build" and JsonData.item_data[arm]["layer"] == 0:
		var block = get_parent().get_parent().get_node("b/TileMap")
		block.visible = true
		if block.empty != load("res://textures/build_player/" + arm +"_true.png"):
			block.collides = JsonData.item_data[arm]["collides"]
			block.empty = load("res://textures/build_player/" + arm +"_true.png")
			if JsonData.item_data[arm]["rotation"]:
				block.empty_rotare = load("res://textures/build_player/" + arm +"_rotare_true.png")
				block.full_rotare = load("res://textures/build_player/" + arm +"_rotare_false.png")
			block.full  = load("res://textures/build_player/" + arm +"_false.png")
			block.type = arm
		if Input.is_action_just_pressed("click_left") and full2 ==  false and opened == false and inventory_opened == false and died == false:
			var _map = get_parent().get_parent().get_node("b/builds")
			var fruit = load("res://builds/"+arm+".tscn")
			var fruits = fruit.instance()
			fruits.position = get_parent().get_parent().get_node("b/TileMap/Node2D").position
			fruits.position.x += 16
			fruits.position.y += 16
			_map.add_child(fruits)
			if invenory_slot == "1":
				var inventory1 = get_parent().get_parent().get_parent().get_node("UI2/inventory")
				inventory1.place("slot1")
			elif  invenory_slot == "2":
				var inventory1 = get_parent().get_parent().get_parent().get_node("UI2/inventory")
				inventory1.place("slot2")
			elif  invenory_slot == "3":
				var inventory1 = get_parent().get_parent().get_parent().get_node("UI2/inventory")
				inventory1.place("slot3")
	else:
		var block = get_parent().get_parent().get_node("b/TileMap")
		block.visible = false
func animate():
	var anim
	if isattacking == false:
		anim = "idle"
	if velocity.x != 0 and isattacking == false and eating == false:
		anim = "move"
		$Particles2D.emitting = true
	elif velocity.y != 0 and isattacking == false and eating == false:
		anim = "move"
		$Particles2D.emitting = true
	if isattacking == true and eating == false:
		if arm == "arm" and rands == 0:
			anim = "attack"
		elif arm == "arm" and rands == 1:
			anim = "attack_2"
		else:
			anim = "attack"
	if eating == true:
		anim = "eating"
	if fliped == false:
		$model.scale.x = -1
	else:
		$model.scale.x = 1
	if $player.current_animation != anim:
		$player.play(anim)








func _on_Timer_timeout():
	$body/CollisionShape2D2.disabled = true


var finder = 0





func _on_area_area_entered(area):
	if area.is_in_group("zombie_arm"):
		modulate = Color(1,0,0)
		health -= 1
		$Timer2.start()
	if area.is_in_group("wooden_trap_damage"):
		modulate = Color(1,0,0)
		health -= 1
		$Timer2.start()

func _on_Timer2_timeout():
	modulate = Color(1,1,1)


func _on_Timer3_timeout():
	if $player.current_animation == "attack" :
		$armsattack/CollisionShape2D.disabled = true
		isattacking = false
	elif $player.current_animation == "attack_2" :
		$armsattack/CollisionShape2D.disabled = true
		isattacking = false

func _on_player_animation_finished(_anim_name):
	var animations = ["attack","attack_2"]
	if fliped == false:
		$model.scale.x = -1
	if arm == "arm":
		isattacking = false
		$armsattack/CollisionShape2D.disabled = true
	elif JsonData.item_data[arm]["ItemCategory"] == "food":
		health += 0.5
		var inventory1 = get_parent().get_parent().get_parent().get_node("UI2/inventory")
		inventory1.place(str("slot",invenory_slot))
		eating = false
	elif JsonData.item_data[arm]["ItemCategory"] == "resurse":
		isattacking = false
		$armsattack/CollisionShape2D.disabled = true
	elif JsonData.item_data[arm]["ItemCategory"] == "instrument":
		isattacking = false
		get_node(str(arm,"/CollisionShape2D")).disabled = true

func remove(point):
	opened = false
	var new_parent = get_parent().get_parent().get_parent().get_node(str("map",point,"/sort"))
	if point == "1":
		new_parent = get_parent().get_parent().get_parent().get_node("map/sort")
	get_parent().remove_child(self)
	new_parent.add_child(self)
	if point == "1":
		$Camera2D.limit_left = 0
		$Camera2D.limit_top = 0
		$Camera2D.limit_right = 1536
		$Camera2D.limit_bottom = 1536
	else:
		$Camera2D.limit_left = 2048
		$Camera2D.limit_top = 0
		$Camera2D.limit_right = 3584
		$Camera2D.limit_bottom = 1536
	position = Vector2(752,656)
