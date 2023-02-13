extends KinematicBody2D
export var speed = 50
var velocity = Vector2()
var isattacking = false
var opened = false
var selected_item = "arm"
var invenory_slot = 1
var fliped = false
var full = false
var inventory_slot1_full = false

var inventory_slot2_full = false

var inventory_slot3_full = false
var arm = {}
var inventory = []
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
	if arm.has(invenory_slot-1):
		$model/arm1/item.visible = true
		$model/arm1/item.texture = load("res://textures/items/" +arm[invenory_slot-1][0] + ".png")
		selected_item = arm[invenory_slot-1][0] 
	elif isattacking == false:
		selected_item = "arm"
		$model/arm1/item.visible = false
	elif isattacking == false:
		var inv =get_node("/root/world/UI2/hand_slots")
		inv.unselect("slot" +  str(invenory_slot))

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
	Console.add_command('add_item', self, 'add_item')\
			.set_description('god mode')\
			.add_argument('item', TYPE_STRING)\
			.add_argument('num', TYPE_INT)\
			.register()
func dead(va = false):
	health = 0
func _input(event):
	if event.is_action_pressed("inv") and isattacking == false and opened == false  and died == false:
		var inv = get_parent().get_parent().get_parent().get_node("UI2")
		inv.openinv()
		

onready var player = get_node("player")
onready var shadow = get_node("model/shadow")
var in_menu = false
func loadskin():
	return
	for i in get_node("model").get_children():
		if i.name == "shadow":continue
		i.texture.set_atlas(SkinManager.skin)


var direction_attack_js = Vector2.ZERO
func _physics_process(_delta):
	if in_console == false and in_menu == false:
		if gamesettings.device_mode == "pc":
			$RayCast2D.look_at(get_global_mouse_position())
			$RayCast2D.global_rotation_degrees -= 90
		elif direction_attack_js != Vector2.ZERO:
			$RayCast2D.look_at(position+(direction_attack_js))
			$RayCast2D.global_rotation_degrees -= 90
	
		$Line2D.global_rotation_degrees = $RayCast2D.global_rotation_degrees
		
		if $RayCast2D.is_colliding():
			if $Line2D.visible == true:
				get_parent().get_node("select").visible = true
			get_parent().get_node("select").position = $RayCast2D.get_collider().position
			get_parent().get_node("select").texture = $RayCast2D.get_collider().get_node("tex").texture
			
			var origin = $RayCast2D.global_transform.origin
			var collision_point = $RayCast2D.get_collision_point()
			var distance = origin.distance_to(collision_point)
			$Line2D.points[1].y = distance
		else:
			get_parent().get_node("select").visible = false
			$Line2D.points[1].y = 25
		get_input(_delta)
		
		animate()
		inventory()
		$Label.text = str(position)
		
		get_node("/root/world/UI2/bars/health/bg/bar_health").value = health
		if selected_item != "arm":
			if JsonData.item_data[selected_item]["ItemCategory"] == "instrument":
				$model/arm1/item.rect_position.x = -8
				$model/arm1/item.rect_position.y = -3.5
				$model/arm1/item.rect_rotation = -45
			else:
				$model/arm1/item.rect_rotation = 0
				$model/arm1/item.rect_position.x = -7
				$model/arm1/item.rect_position.y = -8
	velocity = Vector2()
func get_input(_delta):
	
	if Input.is_action_just_released("scrolling_up") and isattacking == false and opened == false  and died == false and eating == false:
		if invenory_slot != 3:
			var inv = get_node("/root/world/UI2/hand_slots")
			var i = invenory_slot
			i += 1
			#inv.select(str("slot",i))
			invenory_slot = i
		else:
			var inv = get_node("/root/world/UI2/hand_slots")
			var i = invenory_slot
			i = 1
			#inv.select(str("slot",i))
			invenory_slot =i
	elif Input.is_action_just_released("scrolling_down") and isattacking == false and opened == false  and died == false and eating == false:
		
		if invenory_slot != 1:
			var inv = get_node("/root/world/UI2/hand_slots")
			var i = invenory_slot
			i -= 1
			#inv.select(str("slot",i))
			invenory_slot = i
		else:
			var inv = get_node("/root/world/UI2/hand_slots")
			var i = invenory_slot
			i = 3
			#inv.select(str("slot",i))
			invenory_slot = i
	if Input.is_action_just_pressed("open")  and died == false:
		$body/CollisionShape2D2.disabled = false
	if gamesettings.device_mode == "mobile" and direction_attack_js != Vector2.ZERO:
		$Line2D.visible = true
	elif gamesettings.device_mode == "mobile":
		$Line2D.visible = false
	if Input.is_action_just_pressed("click_left") and gamesettings.device_mode == "pc" and opened == false and isattacking == false and inventory_opened == false and died == false:
		$Line2D.visible = true
		
	if Input.is_action_just_released("click_left")and gamesettings.device_mode == "pc" and opened == false and isattacking == false and inventory_opened == false and died == false :
		
		attack()
	
	if  isattacking == false and opened == false  and died == false and eating == false:
		if gamesettings.device_mode == "pc":
			if Input.is_action_just_pressed("inv1") :
				invenory_slot = 1
			elif Input.is_action_just_pressed("inv2") and isattacking == false and opened == false and died == false  and eating == false:
				invenory_slot = 2
			elif Input.is_action_just_pressed("inv3") and isattacking == false and opened == false and died == false  and eating == false:
				invenory_slot = 3
			if Input.is_action_pressed("player_right") and isattacking == false and opened == false and died == false  and eating == false:
				velocity.x += 1
			elif Input.is_action_pressed("player_left") and isattacking == false and opened == false and died == false and eating == false:
				velocity.x -= 1
			if Input.is_action_pressed("Player_down") and isattacking == false and opened == false and died == false and eating == false:
				velocity.y += 1
			if Input.is_action_pressed("player_up") and isattacking == false and opened == false and died == false and eating == false:
				velocity.y -= 1
		velocity *= speed
		if velocity.x > 0:
			fliped = false
			$Particles2D.position.x = -7
			$Particles2D.process_material.gravity.x = -50
		elif velocity.x < 0:
			fliped = true
			$Particles2D.position.x = 7
			$Particles2D.process_material.gravity.x = 50
		move_and_slide(velocity)

func inventory():
	if selected_item != "arm" and JsonData.item_data[selected_item]["ItemCategory"] == "build"  and JsonData.item_data[selected_item]["layer"] == 1:
		
		var block = get_parent().get_parent().get_parent().get_node("TileMap")
		block.visible = true
		if block.empty != load("res://textures/build_player/" + selected_item +"_true.png"):
			block.empty = load("res://textures/build_player/" + selected_item +"_true.png")
			if JsonData.item_data[selected_item]["rotation"]:
				block.empty_rotare = load("res://textures/build_player/" + selected_item +"_rotare_true.png")
				block.full_rotare = load("res://textures/build_player/" + selected_item +"_rotare_false.png")
			block.full  = load("res://textures/build_player/" + selected_item +"_false.png")
			block.type = selected_item
		if Input.is_action_just_pressed("click_left") and gamesettings.device_mode == "pc" and full ==  false and opened == false and inventory_opened == false and died == false:
			place_build()
	else:
		var block = get_node("/root/world/TileMap")
		block.visible = false
	if selected_item != "arm" and JsonData.item_data[selected_item]["ItemCategory"] == "build" and JsonData.item_data[selected_item]["layer"] == 0:
		var block = get_parent().get_parent().get_node("b/TileMap")
		block.visible = true
		if block.empty != load("res://textures/build_player/" + selected_item +"_true.png"):
			block.collides = JsonData.item_data[selected_item]["collides"]
			block.empty = load("res://textures/build_player/" + selected_item +"_true.png")
			if JsonData.item_data[selected_item]["rotation"]:
				block.empty_rotare = load("res://textures/build_player/" + selected_item +"_rotare_true.png")
				block.full_rotare = load("res://textures/build_player/" + selected_item +"_rotare_false.png")
			block.full  = load("res://textures/build_player/" + selected_item +"_false.png")
			block.type = selected_item
		if Input.is_action_just_pressed("click_left") and gamesettings.device_mode == "pc" :
			place_build()
	else:
		var block = get_parent().get_parent().get_node("b/TileMap")
		block.visible = false
var emote = false
func place_build():
	if JsonData.item_data[selected_item]["layer"] == 0:
		if  full2 ==  false and opened == false and inventory_opened == false and died == false:
			var _map = get_parent().get_parent().get_node("b/builds")
			var build = load("res://builds/"+selected_item+".tscn")
			var build_s = build.instance()
			build_s.position = get_parent().get_parent().get_node("b/TileMap/Node2D").position
			build_s.position.x += 16
			build_s.position.y += 16
			_map.add_child(build_s)
			arm[invenory_slot-1][1] -=1 
			if arm[invenory_slot-1][1] == 0:arm.erase(invenory_slot-1)
	elif JsonData.item_data[selected_item]["layer"] == 1:
		if full ==  false and opened == false and inventory_opened == false and died == false:
			var _map = get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort"))
			var build = load("res://builds/"+selected_item+".tscn")
			var build_s = build.instance()
			build_s.position = get_parent().get_parent().get_parent().get_node("TileMap/Node2D").position
			build_s.position.x += 16
			build_s.position.y += 16
			_map.add_child(build_s)
			arm[invenory_slot-1][1] -=1
			if arm[invenory_slot-1][1] == 0:arm.erase(invenory_slot-1)

func animate():
	var anim
	if isattacking == false and emote == false :
		anim = "idle"
	if velocity.x != 0 and isattacking == false and eating == false:
		anim = "move"
		emote = false
		$Particles2D.emitting = true
	elif velocity.y != 0 and isattacking == false and eating == false:
		anim = "move"
		emote = false
		$Particles2D.emitting = true
	if isattacking == true and eating == false:
		emote = false
		if selected_item == "arm" and rands == 0:
			anim = "attack"
		elif selected_item == "arm" and rands == 1:
			anim = "attack_2"
		else:
			anim = "attack"
	if eating == true:
		emote = false
		anim = "eating"
	if fliped == false:
		$model.scale.x = -1
	else:
		$model.scale.x = 1
	if $player.current_animation != anim and anim != null:
		$player.play(anim)








func _on_Timer_timeout():
	$body/CollisionShape2D2.disabled = true


var finder = 0





func _on_area_area_entered(area):
	if area.is_in_group("zombie_selected_item"):
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
		
		isattacking = false
	elif $player.current_animation == "attack_2" :
		
		isattacking = false

func _on_player_animation_finished(_anim_name):
	var animations = ["attack","attack_2"]
	emote = false
	if fliped == false:
		$model.scale.x = -1
	if selected_item == "arm":
		isattacking = false
	elif JsonData.item_data[selected_item]["ItemCategory"] == "food":
		health += 0.5
		var inventory1 = get_parent().get_parent().get_parent().get_node("UI2/inventory")
		inventory1.place(str("slot",invenory_slot))
		eating = false
	elif JsonData.item_data[selected_item]["ItemCategory"] == "resurse":
		isattacking = false
	elif JsonData.item_data[selected_item]["ItemCategory"] == "instrument":
		isattacking = false
		get_node(str(selected_item,"/CollisionShape2D")).disabled = true

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

func add_item(item_name, item_quantity):
	print("t")
	for item_index in range(inventory.size()):
		if inventory[item_index][0] == item_name:
			
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item_index][1]
			if able_to_add >= item_quantity:
				inventory[item_index][1] += item_quantity
				return
			else:
				inventory[item_index][1] += able_to_add
				item_quantity = item_quantity - able_to_add
	inventory.append([item_name, item_quantity])
func remove_item(slot):
	inventory.erase(slot.slot_index)
func  add_item_to_empty_slot(item, slot):
	print(inventory)
	inventory.append([item.item_name, item.item_quantity])
func attack():
	direction_attack_js = Vector2.ZERO;
	get_parent().get_node("select").visible = false
	$Line2D.visible = false
	var rand = randi() % 2
	rands = rand
	
	if selected_item == "arm":
		isattacking = true
		if !$RayCast2D.is_colliding():return
		$RayCast2D.get_collider().get_node("healthsystem").call("damage")
		
	elif JsonData.item_data[selected_item]["ItemCategory"] == "food" and health < 20 and eating == false:
		eating = true
	elif JsonData.item_data[selected_item]["ItemCategory"] == "resurse":
		isattacking = true
		if !$RayCast2D.is_colliding():return
	elif JsonData.item_data[selected_item]["ItemCategory"] == "instrument":
		isattacking = true
		if !$RayCast2D.is_colliding():return
