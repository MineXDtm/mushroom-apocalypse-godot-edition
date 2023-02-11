extends CanvasLayer
func inte():
	$hand_slots.initialize_inventory()
	$inventory.initialize_inventory()
func _ready():
	yield(get_tree().create_timer(1),"timeout")
	yield(get_tree().create_timer(3),"timeout")
#	for i in get_node("emotes/GridContainer").get_children():
#			if i.name == "center":continue
#			if $emotes.emoteslist.size() < int(i.name):continue
#			i.get_node("CenterContainer/TextureRect/Viewport/playerview/player").play($emotes.emoteslist[int(i.name)])


func openinv():
	$inventory.visible = !$inventory.visible
func _physics_process(_delta):
	if joystick_pressed:
		
		get_tree().get_nodes_in_group("player")[0].velocity = move_vector
		
	if Input.is_action_just_pressed("menu") and get_parent().get_node(str(WorldData.map,"/sort/player")).opened == false and get_node("inventory").visible == false:
		if $game_menu.visible == false:
			$game_menu.visible = true
			get_tree().paused = true
			get_parent().get_node(str(WorldData.map,"/sort/player")).in_menu = true
		else:
			$game_menu.visible = false
			get_tree().paused = false
			get_parent().get_node(str(WorldData.map,"/sort/player")).in_menu = false
	


func _input(event):
	if event.is_action_pressed("emotebar"):
		$emotes.visible = true
		
	if event.is_action_released("emotebar"):
		$emotes.visible = false
		
		if $emotes.selected != null and $emotes.emoteslist.has(str(int($emotes.selected))):
			var p = get_parent().get_node(str(WorldData.map,"/sort/player/player")) as AnimationPlayer
			get_parent().get_node(str(WorldData.map,"/sort/player")).emote = true
			
			p.play($emotes.emoteslist[str(int($emotes.selected))])


func _on_inv_but_pressed():
	openinv()
var move_vector = Vector2.ZERO
var joystick_pressed = false
func _on_joystick_movement_gui_input(event):
	if event is InputEventScreenTouch:
		if not event.pressed:
			joystick_pressed = event.pressed
			$joystick_movement/stick.rect_position = Vector2($joystick_movement.rect_size.x/2,$joystick_movement.rect_size.y/2) - Vector2($joystick_movement/stick.rect_size.x/2,$joystick_movement/stick.rect_size.y/2)
			return
		move_vector = (event.position- Vector2($joystick_movement.rect_size.x/2,$joystick_movement.rect_size.y/2)).normalized() 
		$joystick_movement/stick.rect_position = (event.position- Vector2($joystick_movement.rect_size.x/2,$joystick_movement.rect_size.y/2)).clamped($joystick_movement.rect_size.x/2) + Vector2(60,60) - Vector2($joystick_movement/stick.rect_size.x/2,$joystick_movement/stick.rect_size.y/2)
		joystick_pressed = event.pressed
	if event is InputEventScreenDrag:
		move_vector = (event.position- Vector2($joystick_movement.rect_size.x/2,$joystick_movement.rect_size.y/2)).normalized()
		$joystick_movement/stick.rect_position =(event.position- Vector2($joystick_movement.rect_size.x/2,$joystick_movement.rect_size.y/2)).clamped($joystick_movement.rect_size.x/2) + Vector2(60,60) - Vector2($joystick_movement/stick.rect_size.x/2,$joystick_movement/stick.rect_size.y/2)
